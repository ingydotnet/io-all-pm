use lib 't', 'lib';
use strict;
use warnings;
use Test::More tests => 2;
use IO_All_Test;

package Normal;

use IO::All;

package UTF8;

use IO::All -utf8;

package Big5;

use IO::All -encoding => 'big5';

package main;

isnt Normal::io('t/text.big5')->all,
     Big5::io('t/text.big5')->all,
     'Read big5 with different io-s does not match';
is UTF8::io('t/text.utf8')->all,
   Big5::io('t/text.big5')->all,
   'Big5 text matches utf8 text after read';

