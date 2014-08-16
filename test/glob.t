use strict; use warnings;
my $t; use lib ($t = -e 't' ? 't' : 'test');
use Test::More tests => 1;
use IO::All;
use IO_All_Test;

my @foo = sort map $_->filename,
    io()->dir($t, 'mydir')->glob('f*');
is_deeply(\@foo, [qw( file1 file2 file3 )]);

del_output_dir();
