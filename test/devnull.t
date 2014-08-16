use strict; use warnings;
use lib -e 't' ? 't' : 'test';
use Test::More tests => 2;
use IO::All;
use IO_All_Test;

ok("xxx" > io->devnull);
ok(io->devnull->print("yyy"));

del_output_dir();
