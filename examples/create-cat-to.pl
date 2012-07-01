#!/usr/bin/perl

# create-cat-to.pl
# cat to a file that can be created.

use strict;
use warnings;

use IO::All;

my $filename = shift(@ARGV);

# Create a file called $filename, including all leading components.
io('-') > io->file($filename)->assert;
