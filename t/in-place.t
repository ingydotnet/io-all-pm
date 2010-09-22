#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 5;
use IO::All;
use File::Temp qw/tempdir/;

{
    my $tempdir = tempdir( CLEANUP => 1);

    my $f = sub { return io->catfile($tempdir, 'test.txt') };

    $f->()->print(<<'EOF');
#One
#Two
#Three
#Four
EOF

    # Test that the array overloading of IO::All can be modified to
    # produce new contents.
    foreach my $line (@{$f->()})
    {
        # TEST*4
        ok (($line =~ s{\A#}{}), 'Done substitution.');
    }

    # TEST
    is (scalar($f->()->slurp()), <<'EOF', 'File contents were modified.');
One
Two
Three
Four
EOF
}
