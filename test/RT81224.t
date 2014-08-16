use strict; use warnings;
my $t; use lib ($t = -e 't' ? 't' : 'test');
use Test::More tests => 1;
use IO::All -utf8;
my $warnings = 0;
$SIG{__WARN__} = sub { $warnings++ };
my $img = io("$t/img.jpg")->binary->all;
ok(!$warnings, 'no unicode warnings');
