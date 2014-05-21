#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

use lib 't', 'lib';

use IO::All;
use IO_All_Test;

io->file(o_dir() . '/test')->encoding("UTF-16")->binmode("crlf")->write("frew\nbar");

my @f = stat o_dir() . '/test';
is($f[7], 20, 'encoding + binmode');

del_output_dir();
done_testing();
