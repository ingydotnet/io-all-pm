use lib 'lib';
use IO::All;

my $io = io('foo');
$io->append(io($0)->slurp);

my @stuff = qw(one two three);
$stuff[1] .= "xxx\n";

$io->appendln(@stuff);
