use lib 't', 'lib';
use strict;
use warnings;
use Test::More tests => 1;
use IO::All;
use IO_All_Test;

my $string < (io('t/mystuff') > io(o_dir() . '/seek'));
my $io = io(o_dir() . '/seek');
$io->seek(index($string, 'quite'), 0);
is($io->getline, "quite enough.\n");


del_output_dir();
