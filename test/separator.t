use strict; use warnings;
use lib -e 't' ? 't' : 'test';
use Test::More tests => 4;
use IO::All;
use IO_All_Test;

join('', <DATA>) > io(o_dir() . '/separator1');
my $io = io(o_dir() . '/separator1');
$io->separator('t');
my @chunks = $io->slurp;
is(scalar @chunks, 3);
is($chunks[0], "one\nt");
is($chunks[1], "wo\nt");
is($chunks[2], "hree\nfour\n");

del_output_dir();

__DATA__
one
two
three
four
