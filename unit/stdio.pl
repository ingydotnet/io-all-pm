use IO::All;

my $stdin = io('-');
my $stdout = io('-');
$stdout->buffer($stdin->buffer); 
$stdout->write while $stdin->read;
