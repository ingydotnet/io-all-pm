use strict; use warnings;
use lib -e 't' ? 't' : 'test';

# my $db_file;
# BEGIN {
#     use Config;
#     foreach (qw/SDBM_File GDBM_File ODBM_File NDBM_File DB_File/) {
#         if ($Config{extensions} =~ /\b$_\b/) {
#             $db_file = $_;
#             last;
#         }
#     }
# }
# 
# use Test::More defined($db_file)
#     ? (tests => 2)
#     : (skip_all => 'No DBM modules available');
use Test::More;

use IO::All;
use IO_All_Test;

TODO: {
    local $TODO = "FIXME (object-model, hash)";
    fail "Can't use IO::All hash object as a data hash";
}

# {
# my $db = io(o_dir() . '/mydbm')->dbm($db_file);
# $db->{fortytwo} = 42;
# $db->{foo} = 'bar';
# 
# is(join('', sort keys %$db), 'foofortytwo');
# is(join('', sort values %$db), '42bar');
# }

del_output_dir();

done_testing;
