use strict;
use warnings;
use File::Basename;
use lib dirname(__FILE__);
use Test::More tests => 4;
use IO::All;

my $perl_version < io("$^X -v|");
ok($perl_version =~ /Larry Wall/);
ok($perl_version =~ /This is perl/);

io("$^X -v|") > $perl_version;
ok($perl_version =~ /Larry Wall/);
ok($perl_version =~ /This is p(erl|onie)/);
