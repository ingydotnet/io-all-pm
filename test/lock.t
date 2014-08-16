use strict; use warnings;
use lib -e 't' ? 't' : 'test';
use IO::All;
use IO_All_Test;

# XXX This needs to be fixed!!!
$^O !~ /^(cygwin|hpux)$/
    ? print "1..3\n"
    : do { print "1..0 # skip - locking problems on $^O\n"; exit(0) };

{
my $io1 = io(o_dir() . '/foo')->lock;
$io1->println('line 1');

my $pid;
($pid = fork) or do {
    my $io2 = io(o_dir() . '/foo')->lock;
    foreach (1 .. 3) {
        print "not " unless($io2->getline eq "line $_\n");
        print "ok $_\n";
    }
    exit;
};

sleep 1;
$io1->println('line 2');
$io1->println('line 3');
$io1->unlock;

waitpid($pid, 0);
}

del_output_dir();

1;
