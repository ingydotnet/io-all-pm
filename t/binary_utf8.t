use lib 't', 'lib';
use strict;
use warnings;
use File::Spec::Functions;
use Test::More;
use IO::All;

my $f = catfile('t', 'binary_utf8');
plan(tests => 3);

io($f)->open('>')->binary->binmode('crlf')->print("\n");
is(-s $f, 2, "layers of a filehandle are correctly edited if defined after opening it");

io($f)->binary->binmode('crlf')->print("\n");
is(-s $f, 2, "layers of a filehandle are correctly edited if defined before opening it");

io($f)->binary->utf8->print("\n");
is(-s $f, 1, "a filehandle marked binary should never mangle newlines");

unlink $f;
