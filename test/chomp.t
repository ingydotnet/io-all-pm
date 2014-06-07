use strict;
use warnings;
use File::Basename;
use lib dirname(__FILE__);
use Test::More 'no_plan';
use IO::All;
use IO_All_Test;

my $testdir = dirname(__FILE__);
my $io = io("$testdir/chomp.t")->chomp;
for ($io->slurp) {
    ok(not /\n/);
}
$io->close;

for ($io->chomp->separator('io')->getlines) {
    ok(not /io/);
}

del_output_dir();
