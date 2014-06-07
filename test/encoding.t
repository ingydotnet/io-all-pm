use strict;
use warnings;
use File::Basename;
use lib dirname(__FILE__);
use Test::More;
use IO_All_Test;

BEGIN {
    eval { require PerlIO::encoding };
    plan(skip_all => 'no PerlIO::encoding') if $@;
    plan(($] < 5.008003)
          ? (skip_all => 'Broken on older perls')
          : (tests => 4)
    );
}

package Normal;

use IO::All;

package UTF8;

use IO::All -utf8;

package Big5;

use IO::All -encoding => 'big5';

package main;

my $testdir = dirname(__FILE__);
isnt Normal::io("$testdir/text.big5")->all,
     Normal::io("$testdir/text.utf8")->all,
     'big5 and utf8 tests are different';

isnt Normal::io("$testdir/text.big5")->all,
     Big5::io("$testdir/text.big5")->all,
     'Read big5 with different io-s does not match';

is UTF8::io("$testdir/text.utf8")->all,
   Big5::io("$testdir/text.big5")->all,
   'Big5 text matches utf8 text after read';

is Normal::io("$testdir/text.utf8")->utf8->all,
   Normal::io("$testdir/text.big5")->encoding('big5')->all,
   'Big5 text matches utf8 text after read';


del_output_dir();
