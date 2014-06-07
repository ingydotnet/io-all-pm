use strict;
use warnings;
use File::Basename;
use lib dirname(__FILE__);
use Test::More;
use IO::All;
use IO_All_Test;

plan((eval {require File::ReadBackwards; 1})
    ? (tests => 2)
    : (skip_all => "requires File::ReadBackwards")
);

my $testdir = dirname(__FILE__);
my @reversed;
my $io = io("$testdir/mystuff");
$io->backwards;
while (my $line = $io->getline) {
    push @reversed, $line;
}

test_file_contents(join('', reverse @reversed), "$testdir/mystuff");

@reversed = io("$testdir/mystuff")->backwards->getlines;

test_file_contents(join('', reverse @reversed), "$testdir/mystuff");

del_output_dir();
