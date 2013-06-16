#!/usr/bin/perl

use strict;
use warnings;

use lib 't', 'lib';
use IO_All_Test;

use Test::More tests => 1;

# This is a test for cleanup.
{
    IO_All_Test::del_output_dir();
    # TEST
    ok (1, "Cleanup success.");
}
