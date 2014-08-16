use strict; use warnings;
use lib -e 't' ? 't' : 'test';
use Test::More tests => 7;
use IO::All;

use IO_All_Test;

my $data = join '', <DATA>;
my $io = io(o_dir() . '/subtleties1') < $data;
is("$io", o_dir() . '/subtleties1');

ok($io->close);
ok(not $io->close);

my $data2 = $io->slurp;
$data2 .= $$io;
$data2 << $io;
is($data2, $data x 3);
ok(not $io->close);

my $io2 = io(io(io('xxx')));
ok(ref $io2);
ok($io2->isa('IO::All'));
# is("$io2", 'xxx');
del_output_dir();

__DATA__
test
data


