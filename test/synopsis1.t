use strict;
use warnings;
use File::Basename;
use lib dirname(__FILE__);
use Test::More tests => 6;
use IO::All;
use IO_All_Test;

my $testdir = dirname(__FILE__);
# Combine two files into a third
my $my_stuff = io("$testdir/mystuff")->slurp;
test_file_contents($my_stuff, "$testdir/mystuff");
my $more_stuff << io("$testdir/morestuff");
test_file_contents($more_stuff, "$testdir/morestuff");
io("$testdir/allstuff")->print($my_stuff, $more_stuff);
ok(-f "$testdir/allstuff");
ok(-s "$testdir/allstuff");
test_file_contents($my_stuff . $more_stuff, "$testdir/allstuff");
ok(unlink("$testdir/allstuff"));

del_output_dir();
