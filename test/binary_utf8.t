use strict; use warnings;
use lib -e 't' ? 't' : 'test';
use utf8;

use Test::More tests => 8;

use IO::All;
use IO_All_Test;

my $f = io->file(o_dir(), 'binary_utf8')->name;

io($f)->open('>')->binary->binmode('crlf')->print("\n");
is(-s $f, 2, "layers of a filehandle are correctly edited if defined after opening it");

io($f)->binary->binmode('crlf')->print("\n");
is(-s $f, 2, "layers of a filehandle are correctly edited if defined before opening it");

io($f)->binary->utf8->print("\n");
is(-s $f, 1, "a filehandle marked binary should never mangle newlines");

io($f)->open('>')->binary->encoding('UTF-8')->print("ö\n");
is(-s $f, 3, ":raw and utf8 encoding work correctly if defined after opening fh");

io($f)->binary->encoding('UTF-8')->print("ö\n");
is(-s $f, 3, ":raw and utf8 encoding work correctly if defined before opening fh");

io($f)->open('>')->binmode->encoding('UTF-8')->print("ö\n");
is(-s $f, 3, "binmode functions correctly without args after opening it");

io($f)->encoding('UTF-8')->binmode->print("ö\n");
is(-s $f, 2, "binmode functions correctly without args before opening it");

io($f)->binary->encoding('UTF-8')->binmode->print("ö\n");
is(-s $f, 2, "binmode functions correctly without args before opening it");

del_output_dir();
