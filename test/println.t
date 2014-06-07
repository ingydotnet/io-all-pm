use strict;
use warnings;
use File::Basename;
use lib dirname(__FILE__);
use Test::More tests => 1;
use IO::All;
use IO_All_Test;

my $testdir = dirname(__FILE__);
my $io = io("$testdir/println.t");
my @lines = map {chomp; $_} $io->slurp;
my $temp = io('?');
$temp->println(@lines);
$temp->seek(0, 0);
my $text = $temp->slurp;

test_file_contents($text, "$testdir/println.t");

del_output_dir();
