use strict;
use warnings;
use File::Basename;
use lib dirname(__FILE__);
use Test::More tests => 2;
use IO::All;
use IO_All_Test;

my $io1 = io(o_dir() . '/print.t');
is($io1->print("one\n")->print("two\n")->close->scalar, "one\ntwo\n");
my $io2 = io(o_dir() . '/print.t');
is($io2->println("one")->println("two")->close->scalar, "one\ntwo\n");


del_output_dir();
