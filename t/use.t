use Test::More tests => 1;

use IO::All -with => qw(Foo Bar), -strict, -overload => 0;

use XXX;

XXX io('foo', 0);
