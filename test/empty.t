use strict;
use warnings;
use File::Basename;
use lib dirname(__FILE__);
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
