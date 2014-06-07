use strict;
use warnings;
use File::Basename;
use lib dirname(__FILE__);
use Test::More tests => 1;
use IO::All;
use IO_All_Test;

my @foo = sort map $_->filename,
    io()->dir(dirname(__FILE__), 'mydir')->glob('f*');
is_deeply(\@foo, [qw( file1 file2 file3 )]);

del_output_dir();
