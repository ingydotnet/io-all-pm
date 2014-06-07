use strict;
use warnings;
use File::Basename;
use lib dirname(__FILE__);
use Test::More tests => 2;
use IO::All;
use IO_All_Test;

my $testdir = dirname(__FILE__);
test_file_contents(io->file("$testdir/all2.t")->all, "$testdir/all2.t");
test_file_contents(io->file("$testdir/all2.t")->scalar, "$testdir/all2.t");

del_output_dir();
