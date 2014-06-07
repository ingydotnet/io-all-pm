use strict;
use warnings;
use File::Basename;
use lib dirname(__FILE__);
use Test::More tests => 24;
use IO_All_Test;
use IO::All;

unlink(o_dir() . '/overload1');
unlink(o_dir() . '/overload2');
unlink(o_dir() . '/overload3');

my $testdir = dirname(__FILE__);
my $data < io("$testdir/mystuff");
test_file_contents($data, "$testdir/mystuff");
my $data1 = $data;
my $data2 = $data . $data;
$data << io("$testdir/mystuff");
is($data, $data2);
$data < io("$testdir/mystuff");
is($data, $data1);

io("$testdir/mystuff") > $data;
test_file_contents($data, "$testdir/mystuff");
io("$testdir/mystuff") >> $data;
is($data, $data2);
io("$testdir/mystuff") > $data;
is($data, $data1);

$data > io(o_dir() . '/overload1');
test_file_contents($data, o_dir() . '/overload1');
$data > io(o_dir() . '/overload1');
test_file_contents($data, o_dir() . '/overload1');
$data >> io(o_dir() . '/overload1');
test_file_contents($data2, o_dir() . '/overload1');

io(o_dir() . '/overload1') < $data;
test_file_contents($data, o_dir() . '/overload1');
io(o_dir() . '/overload1') < $data;
test_file_contents($data, o_dir() . '/overload1');
io(o_dir() . '/overload1') << $data;
test_file_contents($data2, o_dir() . '/overload1');

$data > io(o_dir() . '/overload1');
test_file_contents($data, o_dir() . '/overload1');
io(o_dir() . '/overload1') > io(o_dir() . '/overload2');
test_matching_files(o_dir() . '/overload1', o_dir() . '/overload2');
io(o_dir() . '/overload3') < io(o_dir() . '/overload2');
test_matching_files(o_dir() . '/overload1', o_dir() . '/overload3');
io(o_dir() . '/overload3') << io(o_dir() . '/overload2');
io(o_dir() . '/overload1') >> io(o_dir() . '/overload2');
test_matching_files(o_dir() . '/overload2', o_dir() . '/overload3');
test_file_contents($data2, o_dir() . '/overload3');

is(io('foo') . '', 'foo');

is("@{io $testdir . '/mydir'}",
   flip_slash
     "$testdir/mydir/dir1 $testdir/mydir/dir2 $testdir/mydir/file1 $testdir/mydir/file2 $testdir/mydir/file3",
);

is(join(' ', sort keys %{io "$testdir/mydir"}),
   'dir1 dir2 file1 file2 file3',
);

is(join(' ', sort map {"$_"} values %{io "$testdir/mydir"}),
   flip_slash
     "$testdir/mydir/dir1 $testdir/mydir/dir2 $testdir/mydir/file1 $testdir/mydir/file2 $testdir/mydir/file3",
);

${io("$testdir/mystuff")} . ${io("$testdir/mystuff")} > io(o_dir() . '/overload1');
test_file_contents2(o_dir() . '/overload1', $data2);

${io("$testdir/mystuff")} . "xxx\n" . ${io("$testdir/mystuff")} > io(o_dir() . '/overload1');
$data < io("$testdir/mystuff");
my $cat3 = $data . "xxx\n" . $data;
test_file_contents2(o_dir() . '/overload1', $cat3);

is "" . ${io($testdir)}, $testdir, "scalar overload of directory (for mst)";


del_output_dir();
