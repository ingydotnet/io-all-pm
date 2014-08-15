use strict; use warnings;
my $t; use lib ($t = -e 't' ? 't' : 'test');
use Test::More tests => 24;
use IO_All_Test;
use IO::All;

unlink(o_dir() . '/overload1');
unlink(o_dir() . '/overload2');
unlink(o_dir() . '/overload3');
unlink(o_dir() . '/tmp/mystuff') if -e o_dir() . '/tmp/mystuff';
rmdir(o_dir() . '/tmp') if -d o_dir() . '/tmp';;

my $data < io("$t/mystuff");
test_file_contents($data, "$t/mystuff");
my $data1 = $data;
my $data2 = $data . $data;
$data << io("$t/mystuff");
is($data, $data2);
$data < io("$t/mystuff");
is($data, $data1);

io("$t/mystuff") > $data;
test_file_contents($data, "$t/mystuff");
io("$t/mystuff") >> $data;
is($data, $data2);
io("$t/mystuff") > $data;
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

# io(o_dir() . '/tmp/') < io("$testdir/mystuff");
# test_file_contents($data1, o_dir() . "/tmp/mystuff");
# io(o_dir() . '/tmp/') << io("$testdir/mystuff");
# test_file_contents($data2, o_dir() . "/tmp/mystuff");
# io("$testdir/mystuff") > io(o_dir() . '/tmp/');
# test_file_contents($data1, o_dir() . "/tmp/mystuff");
# io("$testdir/mystuff") >> io(o_dir() . '/tmp/');
# test_file_contents($data2, o_dir() . "/tmp/mystuff");

is(io('foo') . '', 'foo');

is("@{io $t . '/mydir'}",
   flip_slash
     "$t/mydir/dir1 $t/mydir/dir2 $t/mydir/file1 $t/mydir/file2 $t/mydir/file3",
);

is(join(' ', sort keys %{io "$t/mydir"}),
   'dir1 dir2 file1 file2 file3',
);

is(join(' ', sort map {"$_"} values %{io "$t/mydir"}),
   flip_slash
     "$t/mydir/dir1 $t/mydir/dir2 $t/mydir/file1 $t/mydir/file2 $t/mydir/file3",
);

${io("$t/mystuff")} . ${io("$t/mystuff")} > io(o_dir() . '/overload1');
test_file_contents2(o_dir() . '/overload1', $data2);

${io("$t/mystuff")} . "xxx\n" . ${io("$t/mystuff")} > io(o_dir() . '/overload1');
$data < io("$t/mystuff");
my $cat3 = $data . "xxx\n" . $data;
test_file_contents2(o_dir() . '/overload1', $cat3);

is "" . ${io($t)}, $t, "scalar overload of directory (for mst)";


del_output_dir();
