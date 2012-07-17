use Test::More tests => 3;

use IO::All -with => qw(Dir File), -strict, -overload => 0;

system("touch foo");

my $io = io('foo');

is $io->{name}, 'foo';
is $io->{_strict}, 1;
is $io->{_overload}, 0;

system("rm -f foo");
