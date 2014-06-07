use strict;
use warnings;
use File::Basename;
use lib dirname(__FILE__);
use Test::More tests => 1;
use IO::All;
use IO_All_Test;

my $testdir = dirname(__FILE__);
{
my $string < (io("$testdir/mystuff") > io(o_dir() . '/seek'));
my $io = io(o_dir() . '/seek');
$io->seek(index($string, 'quite'), 0);
is($io->getline, "quite enough.\n");
}

del_output_dir();
