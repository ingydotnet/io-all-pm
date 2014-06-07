use strict;
use warnings;
use File::Basename;
use lib dirname(__FILE__);
use Test::More tests => 18;
use IO::All;
use IO_All_Test;

my $testdir = dirname(__FILE__);
my $io1 = IO::All->new("$testdir/mystuff");
is(ref($io1), 'IO::All::File');
test_file_contents($$io1, "$testdir/mystuff");

my $io2 = io("$testdir/mystuff");
is(ref($io2), 'IO::All::File');
test_file_contents($$io2, "$testdir/mystuff");

my $io3 = io->file("$testdir/mystuff");
is(ref($io3), 'IO::All::File');
test_file_contents($$io3, "$testdir/mystuff");

my $io4 = $io3->file("$testdir/construct.t");
is(ref($io4), 'IO::All::File');
test_file_contents($$io4, "$testdir/construct.t");

my $io5 = io->dir("$testdir/mydir");
is(ref($io5), 'IO::All::Dir');
is(join('+', map $_->filename, grep {! /CVS|\.svn/} $io5->all), 'dir1+dir2+file1+file2+file3');

my $io6 = io->rdonly->new->file("$testdir/construct.t");
ok($io6->_rdonly);

SKIP: {
    eval {require Tie::File};
    skip "requires Tie::File", 1	if $@;

    test_file_contents(join('', map {"$_\n"} @$io6), "$testdir/construct.t");
}

my $io7 = io->socket('foo.com:80')->get_socket_domain_port;
ok($io7->is_socket);
is($io7->domain, 'foo.com');
is($io7->port, '80');

my $io8 = io(':8000')->get_socket_domain_port;
ok($io8->is_socket);
is($io8->domain, 'localhost');
is($io8->port, '8000');

del_output_dir();
