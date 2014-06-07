use strict;
use warnings;
use File::Basename;
use lib dirname(__FILE__);
use Test::More tests => 3;
use IO::All;

my $testdir = dirname(__FILE__);
# Write some data to a temporary file and retrieve all the paragraphs.
my $data = io("$testdir/synopsis5.t")->slurp;

my $temp = io->temp;
ok($temp->print($data));
ok($temp->seek(0, 0));

my @paragraphs = $temp->getlines('');
is(scalar @paragraphs, 4);
