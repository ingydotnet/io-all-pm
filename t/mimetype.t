use lib 't', 'lib';
use strict;
use warnings;
use Test::More;
use IO::All;
use IO_All_Test;

plan((eval {require File::MimeInfo; 1})
    ? (tests => 1)
    : (skip_all => "requires File::MimeInfo")
);

is(io->file('foo.jpg')->mimetype, 'image/jpeg');
