use lib 'lib';
use IO::All;

my $socket = io(':12345')->accept('-fork');
$socket->print($_) while <DATA>;
$socket->close;

__DATA__
On your mark,
Get set,
Go!
