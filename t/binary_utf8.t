use lib 't', 'lib';
use strict;
use warnings;

use Test::More tests => 3;

use IO::All;
use IO_All_Test;

my $f = io->file(o_dir(), 'binary_utf8')->name;

io($f)->open('>')->binary->binmode('crlf')->print("\n");
is(-s $f, 2, "layers of a filehandle are correctly edited if defined after opening it");

io($f)->binary->binmode('crlf')->print("\n");
is(-s $f, 2, "layers of a filehandle are correctly edited if defined before opening it");

io($f)->binary->utf8->print("\n");
is(-s $f, 1, "a filehandle marked binary should never mangle newlines");

del_output_dir();
