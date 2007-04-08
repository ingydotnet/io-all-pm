use lib 'lib';
use IO::All;

my @stuff = qw(one two three);
$stuff[1] .= "xxx\n";

io('-')->println(@stuff);

