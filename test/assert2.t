use strict; use warnings;
use lib -e 't' ? 't' : 'test';
use Test::More;
use IO::All;
use IO_All_Test;

ok(io(o_dir() . '/xxx/yyy/zzz.db')->dbm->assert->{foo} = "bar");
TODO: {
    local $TODO = "FIXME (object-model, unknown)";
    ok(
    -f o_dir() . '/xxx/yyy/zzz.db' or
    -f o_dir() . '/xxx/yyy/zzz.db.dir' or
    -f o_dir() . '/xxx/yyy/zzz.db.db'
    );
}
SKIP: {
    skip "requires MLDBM", 2
      unless eval { require MLDBM; 1};
    ok(io(o_dir() . '/xxx/yyy/zzz2.db')->assert->mldbm->{foo} = ["bar"]);
TODO: {
    local $TODO = "FIXME (object-model, unknown)";
    ok(-f o_dir() . '/xxx/yyy/zzz2.db' or -f o_dir() . '/xxx/yyy/zzz.db.dir');
}
}
del_output_dir();

done_testing;
