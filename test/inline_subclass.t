use strict; use warnings;
use lib -e 't' ? 't' : 'test';

package IO::Dumper;
use IO::All -base;
use Data::Dumper;

our @EXPORT = 'io';

sub io { return IO::Dumper->new(@_) };

package IO::All::Filesys;
sub dump {
    my $self = shift;
    $self->print(Data::Dumper::Dumper(@_));
    return $self;
}

package main;
use Test::More tests => 5;
use IO_All_Test;

IO::Dumper->import;

my $hash = {
    red => 'square',
    yellow => 'circle',
    pink => 'triangle',
};

die if -f o_dir() . '/dump1';
my $io = io(o_dir() . '/dump1')->file->dump($hash);
ok(-f o_dir() . '/dump1');
ok($io->close);
ok(-s o_dir() . '/dump1');

my $VAR1;
my $a = do (o_dir() . '/dump1');
my $b = eval join('',<DATA>);
is_deeply($a,$b);

ok($io->unlink);

del_output_dir();

__END__
$VAR1 = {
  'pink' => 'triangle',
  'red' => 'square',
  'yellow' => 'circle'
};
