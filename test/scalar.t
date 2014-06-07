use strict;
use warnings;
use File::Basename;
use lib dirname(__FILE__);
use Test::More tests => 2;
use IO::All;
use IO_All_Test;

my $testdir = dirname(__FILE__);
my $io = io("$testdir/scalar.t");
my @list = $io->scalar;
ok(@list == 1);
test_file_contents($list[0], "$testdir/scalar.t");

del_output_dir();
