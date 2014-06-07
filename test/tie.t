use strict;
use warnings;
use File::Basename;
use lib dirname(__FILE__);
use Test::More tests => 1;
use IO::All;
use IO_All_Test;

my $testdir = dirname(__FILE__);
{
my $io = io("$testdir/tie.t")->tie;
my $file = join '', <$io>;
test_file_contents($file, "$testdir/tie.t");

my $io1 = io(o_dir() . '/tie.t')->tie;
print $io1 "test";
}

del_output_dir();
