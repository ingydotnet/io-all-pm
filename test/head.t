#!/usr/bin/perl

use strict;
use warnings;

use File::Spec;
use Test::More tests => 2;

use IO::All;

my $t = -e 't' ? 't' : 'test';
my $fn = File::Spec->catfile(File::Spec->curdir, $t, 'data', 'head_test.txt');

{
    # See: https://github.com/ingydotnet/io-all-pm/issues/44

    # TEST
    is_deeply(
        [io->file($fn)->chomp->head()],
        [qw(
            1
            2
            0
            3
            4
            5
            6
            7
            8
            9
            )
        ],
        "Read the first 10 lines with chomp (should not stop at 0).",
    );

    # TEST
    is_deeply(
        [io->file($fn)->chomp->head(5)],
        [qw(
            1
            2
            0
            3
            4
            )
        ],
        "Read the first 5 lines.",
    );
}

