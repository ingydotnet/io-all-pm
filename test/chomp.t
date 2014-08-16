use strict; use warnings;
my $t; use lib ($t = -e 't' ? 't' : 'test');
use Test::More 'no_plan';
use IO::All;
use IO_All_Test;

my $io = io("$t/chomp.t")->chomp;
for ($io->slurp) {
    ok(not /\n/);
}
$io->close;

for ($io->chomp->separator('io')->getlines) {
    ok(not /io/);
}

del_output_dir();
