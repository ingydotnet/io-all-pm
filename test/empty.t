use strict; use warnings;
use lib -e 't' ? 't' : 'test';
use Test::More tests => 5;
use IO::All;
use IO_All_Test;

my $d = io(o_dir() . '/empty');
ok($d->mkdir);
ok($d->empty);

my $f = io(o_dir() . '/file');
ok($f->touch->touch);
ok($f->empty);

eval {io('qwerty')->empty};
like($@, qr"Can't call empty");


del_output_dir();
