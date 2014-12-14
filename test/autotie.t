use strict; use warnings;
my $t; use lib ($t = -e 't' ? 't' : 'test');
use File::Spec::Functions;
use Test::More;
use IO::All;
use IO_All_Test;

my $f = catfile($t, 'mystuff');
my @lines = read_file_lines($f);
plan(tests => 1 + @lines + 1 + 7);

{
my $io = io($f)->tie;
is($io->autoclose(0) . '', $f);
while (<$io>) {
    is($_, shift @lines);
}
ok(close $io);
}

{
my $f = catfile($t, 'mystuff2');
my @lines = ('This ', 'is ', 'a ', 'silly ', "example\n");
my $io = io($f)->separator(q( ))->tie;
is($io->autoclose(0) . '', $f);
while (<$io>) {
    is($_, shift @lines, $_);
}
ok(close $io);
}

del_output_dir();
