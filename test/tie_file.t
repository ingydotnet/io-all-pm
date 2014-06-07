use strict;
use warnings;
use File::Basename;
use lib dirname(__FILE__);
use Test::More;
use IO_All_Test;
use IO::All;

my $testdir = dirname(__FILE__);
plan((eval {require Tie::File; 1})
    ? (tests => 2)
    : (skip_all => "requires Tie::File")
);

{
(io(o_dir() . '/tie_file1') < io("$testdir/tie_file.t"))->close;
my $file = io(o_dir() . '/tie_file1')->rdonly;
is($file->[-1], 'bar');
is($file->[-2], 'foo');

"foo\n" x 3 > io(o_dir() . '/tie_file2');
io(o_dir() . '/tie_file2')->[1] = 'bar';
}

del_output_dir();

__END__
foo
bar
