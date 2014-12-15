use strict; use warnings;
my $t; use lib ($t = -e 't' ? 't' : 'test');
use Test::More;
use IO::All;
use IO_All_Test;

TODO: {
    local $TODO = "FIXME (object-model, tie)";
    fail "Can't tie filenames as I/O handles";
}
# {
# my $io = io("$t/tie.t")->tie;
# my $file = join '', <$io>;
# test_file_contents($file, "$t/tie.t");
# 
# my $io1 = io(o_dir() . '/tie.t')->tie;
# print $io1 "test";
# }

del_output_dir();

done_testing;
