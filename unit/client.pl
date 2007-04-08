use lib 'lib';
use IO::All;

my $io = io('localhost:12345');
print while $_ = $io->getline;
