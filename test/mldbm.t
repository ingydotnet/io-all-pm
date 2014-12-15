use strict; use warnings;
use lib -e 't' ? 't' : 'test';
use Test::More;
use IO::All;
use IO_All_Test;

TODO: {
    local $TODO = "FIXME (object-model, hash, dbm)";
    fail "Can't use hash object as tied hash";
}
# plan((eval {require MLDBM; 1})
#     ? (tests => 4)
#     : (skip_all => "requires MLDBM")
# );
# 
# my $io = io(o_dir() . '/mldbm')->mldbm('SDBM_File', 'Data::Dumper');
# $io->{test} = { qw( foo foolsgold bar bargain baz bazzarro ) };
# $io->{test2} = [ 1..4 ];
# $io->close;
# 
# my $io2 = io(o_dir() . '/mldbm')->mldbm('SDBM_File', 'Data::Dumper');
# is(scalar(@{[%$io2]}), 4);
# is(scalar(@{[%{$io2->{test}}]}), 6);
# is($io2->{test}{bar}, 'bargain');
# is($io2->{test2}[3], 4);

del_output_dir();

done_testing;
