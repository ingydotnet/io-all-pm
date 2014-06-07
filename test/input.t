use strict;
use warnings;
use File::Basename;
use lib dirname(__FILE__);
use Test::More tests => 12;
use IO::All;
use IO_All_Test;

my $testdir = dirname(__FILE__);
io("$testdir/input.t") > my $contents;
test_file_contents($contents, "$testdir/input.t");

$contents < io "$testdir/input.t";
test_file_contents($contents, "$testdir/input.t");

my $io = io "$testdir/input.t";
$contents = $$io;
test_file_contents($contents, "$testdir/input.t");

$contents = $io->slurp;
test_file_contents($contents, "$testdir/input.t");

$contents = $io->scalar;
test_file_contents($contents, "$testdir/input.t");

$contents = join '', $io->getlines;
test_file_contents($contents, "$testdir/input.t");

SKIP: {
    eval {require Tie::File};
    skip "requires Tie::File", 2	if $@;

    $io->rdonly;
    $contents = join '', map "$_\n", @$io;
    test_file_contents($contents, "$testdir/input.t");
    $io->close;

    $io->tie;
    $contents = join '', <$io>;
    test_file_contents($contents, "$testdir/input.t");
}

my @lines = io("$testdir/input.t")->slurp;
ok(@lines > 36);
test_file_contents(join('', @lines), "$testdir/input.t");

my $old_contents = $contents;
$contents << io("$testdir/input.t");
is($contents, $old_contents . $old_contents);

is(io("$testdir/input.t") >> $contents, ($old_contents x 3));

del_output_dir();
