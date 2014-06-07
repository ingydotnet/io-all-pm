use strict;
use warnings;
use File::Basename;
use lib dirname(__FILE__);
use File::Spec::Functions;
use Test::More;
use IO::All;
use IO_All_Test;

my $f = catfile(dirname(__FILE__), 'mystuff');
my @lines = read_file_lines($f);
plan(tests => 1 + @lines + 1);

my $io = io($f)->tie;
is($io->autoclose(0) . '', $f);
while (<$io>) {
    is($_, shift @lines);
}
ok(close $io);

del_output_dir();
