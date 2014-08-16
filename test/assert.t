use strict; use warnings;
use lib -e 't' ? 't' : 'test';
use Test::More tests => 8;
use IO::All;
use IO_All_Test;

use Cwd qw(getcwd);

{
ok(not -e o_dir() . '/newpath/hello.txt');
ok(not -e o_dir() . '/newpath');
my $io = io(o_dir() . '/newpath/hello.txt')->assert;
ok(not -e o_dir() . '/newpath');
"Hello\n" > $io;
ok(-f o_dir() . '/newpath/hello.txt');
}

{
    my $orig_path = getcwd();

    chdir(o_dir() . '/newpath');
    # Bug http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=733680
    "Hello" > io->file('foobar')->assert;

    ok( -f 'foobar');
    is( scalar (-s 'foobar'), 5);

    "12345678" > io->file('./1_8')->assert;

    ok( -f '1_8', "Dot-slash-assert.");
    is( scalar (-s '1_8'), 8, "Size is 8.");

    chdir($orig_path);
}

del_output_dir();
