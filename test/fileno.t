use strict; use warnings;
use lib -e 't' ? 't' : 'test';
use Test::More;
use IO::All;
use IO_All_Test;

plan((lc($^O) eq 'mswin32' and defined $ENV{PERL5_CPANPLUS_IS_RUNNING})
    ? (skip_all => "CPANPLUS/MSWin32 breaks this")
    : ($] < 5.008003)
      ? (skip_all => 'Broken on older perls')
      : (tests => 7)
);

is(io('-')->mode('<')->open->fileno, 0);
is(io('-')->mode('>')->open->fileno, 1);
is(io('=')->fileno, 2);

is(io->stdin->fileno, 0);
is(io->stdout->fileno, 1);
is(io->stderr->fileno, 2);

ok(io(o_dir() . '/xxx')->open('>')->fileno > 2);


del_output_dir();
