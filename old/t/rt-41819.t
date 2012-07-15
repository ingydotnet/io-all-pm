use Test::More;
use IO::All;

plan 'skip_all' unless -d '/dev';
plan tests => 1;

my $io = io('/dev');
my $path;

my $f = $path->name while ($path = $io->next());
pass 'It works now';
