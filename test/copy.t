use strict; use warnings;
my $t; use lib ($t = -e 't' ? 't' : 'test');
use Test::More tests => 4;
use IO::All;
use IO_All_Test;

my $ret = io->file("$t/img.jpg")->copy(o_dir() . '/img.jpg');
ok(io->file("$t/img.jpg")->binary->all eq $ret->binary->all, 'file copied correctly');
is(f($ret->name), f(io->file(o_dir(), 'img.jpg')->name), 'copy returns new obj');

SKIP: {
    skip 'requires File::Copy::Recursive', 2
       unless eval { require File::Copy::Recursive; 1 };

    my $lib = io->dir('lib');
    my $ret = $lib->copy(o_dir() . '/station');
    my $orig =()= $lib->All;
    my $new =()= $ret->All;
    is($new, $orig, 'dir copied correctly');
    is($ret->name, io->dir(o_dir() . '/station')->name, 'copy returns new obj');
};

del_output_dir();
