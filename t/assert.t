use lib 't', 'lib';
use strict;
use warnings;
use Test::More tests => 4;
use IO::All;
use IO_All_Test;

ok(not -e o_dir() . '/newpath/hello.txt');
ok(not -e o_dir() . '/newpath');
my $io = io(o_dir() . '/newpath/hello.txt')->assert;
ok(not -e o_dir() . '/newpath');
"Hello\n" > $io;
ok(-f o_dir() . '/newpath/hello.txt');


del_output_dir();
