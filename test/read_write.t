use strict; use warnings;
use lib -e 't' ? 't' : 'test';
use Test::More tests => 2;
use IO::All;
use IO_All_Test;

my $io = io('lib/IO/All.pm');
my $buffer;
$io->buffer($buffer);
1 while $io->read;
ok(length($buffer));
test_file_contents($buffer, 'lib/IO/All.pm');

del_output_dir();
