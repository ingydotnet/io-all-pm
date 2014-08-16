use strict; use warnings;
my $t; use lib ($t = -e 't' ? 't' : 'test');
use Test::More;
use IO::All;
use IO_All_Test;
use Cwd qw(abs_path);

my $linkname = o_dir() . '/mylink';

my $cwd = abs_path('.');
eval { symlink("$t/mydir", $linkname) or die $! };

if ($@ or not -l $linkname) {
    plan skip_all => 'Cannot call symlink on this platform';
}
else {
    plan tests => 2;
}

my $io = io($linkname);

my @files = $io->all_files;
is(scalar @files, 3);

@files = $io->All_Files;
is(scalar @files, 6);


del_output_dir();
