use strict; use warnings;
use lib -e 't' ? 't' : 'test';
use Test::More tests => 5;
use IO_Dumper;
use IO_All_Test;

my $hash = {
    red => 'square',
    yellow => 'circle',
    pink => 'triangle',
};

my $io = io->file(o_dir() . '/dump2')->dump($hash);
ok(-f o_dir() . '/dump2');
ok($io->close);
ok(-s o_dir() . '/dump2');

my $VAR1;
my $a = do (o_dir() . '/dump2');
my $b = eval join('',<DATA>);
is_deeply($a,$b);

ok($io->unlink);

del_output_dir();

package main;
__END__
$VAR1 = {
  'pink' => 'triangle',
  'red' => 'square',
  'yellow' => 'circle'
};
