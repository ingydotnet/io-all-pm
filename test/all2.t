use strict; use warnings;
my $t; use lib ($t = -e 't' ? 't' : 'test');
use Test::More tests => 2;
use IO::All;
use IO_All_Test;

test_file_contents(io->file("$t/all2.t")->all, "$t/all2.t");
test_file_contents(io->file("$t/all2.t")->scalar, "$t/all2.t");

del_output_dir();
