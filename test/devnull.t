use strict;
use warnings;
use File::Basename;
use lib dirname(__FILE__);
use Test::More tests => 2;
use IO::All;
use IO_All_Test;

ok("xxx" > io->devnull);
ok(io->devnull->print("yyy"));

del_output_dir();
