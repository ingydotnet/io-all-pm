use strict; use warnings;
my $t; use lib ($t = -e 't' ? 't' : 'test');
use Test::More tests => 1;
use IO::All;
use IO_All_Test;

{
my $io = io("$t/tie.t")->tie;
my $file = join '', <$io>;
test_file_contents($file, "$t/tie.t");

my $io1 = io(o_dir() . '/tie.t')->tie;
print $io1 "test";
}

del_output_dir();
