use lib 't', 'lib';
use strict;
use warnings;
use Test::More tests => 2;
use IO::All;
use IO_All_Test;

my @foo = sort (io()->dir(qw( t mydir ))->glob_raw('f*'));
is_deeply(\@foo, [qw( t/mydir/file1 t/mydir/file2 t/mydir/file3 )]);

@foo = sort map $_->filename, io()->dir(qw( t mydir ))->glob('f*');
is_deeply(\@foo, [qw( file1 file2 file3 )]);
