use strict;
use warnings;
my $t;
use lib ($t = -e 't' ? 't' : 'test');
use Test::More tests => 30;
use IO::All;
use IO_All_Test;

my $expected1 = "$t/mydir/dir1;$t/mydir/dir2;$t/mydir/file1;$t/mydir/file2;$t/mydir/file3";
my $expected2 =
"$t/mydir/dir1;$t/mydir/dir1/dira;$t/mydir/dir1/file1;$t/mydir/dir2;$t/mydir/dir2/file1;$t/mydir/file1;$t/mydir/file2;$t/mydir/file3";
my $expected3 =
"$t/mydir/dir1;$t/mydir/dir1/dira;$t/mydir/dir1/dira/dirx;$t/mydir/dir1/file1;$t/mydir/dir2;$t/mydir/dir2/file1;$t/mydir/file1;$t/mydir/file2;$t/mydir/file3";
my $expected4 =
"$t/mydir/dir1;$t/mydir/dir1/dira;$t/mydir/dir1/dira/dirx;$t/mydir/dir1/dira/dirx/file1;$t/mydir/dir1/file1;$t/mydir/dir2;$t/mydir/dir2/file1;$t/mydir/file1;$t/mydir/file2;$t/mydir/file3";
my $expected_files1 = "$t/mydir/file1;$t/mydir/file2;$t/mydir/file3";
my $expected_files2 = "$t/mydir/dir1/file1;$t/mydir/dir2/file1;$t/mydir/file1;$t/mydir/file2;$t/mydir/file3";
my $expected_files4 =
  "$t/mydir/dir1/dira/dirx/file1;$t/mydir/dir1/file1;$t/mydir/dir2/file1;$t/mydir/file1;$t/mydir/file2;$t/mydir/file3";
my $expected_dirs1 = "$t/mydir/dir1;$t/mydir/dir2";
my $expected_dirs2 = "$t/mydir/dir1;$t/mydir/dir1/dira;$t/mydir/dir2";
my $expected_dirs3 = "$t/mydir/dir1;$t/mydir/dir1/dira;$t/mydir/dir1/dira/dirx;$t/mydir/dir2";
my $expected_filt1 = "$t/mydir/dir1/dira;$t/mydir/dir1/dira/dirx";
my $expected_filt2 = "$t/mydir/dir1/dira/dirx";

sub prep {
    join ';', grep {not /CVS|\.svn/} @_;
}

is(prep(io("$t/mydir")->all),             f $expected1);
is(prep(io("$t/mydir")->all(1)),          f $expected1);
is(prep(io("$t/mydir")->all(2)),          f $expected2);
is(prep(io("$t/mydir")->all(3)),          f $expected3);
is(prep(io("$t/mydir")->all(4)),          f $expected4);
is(prep(io("$t/mydir")->all(5)),          f $expected4);
is(prep(io("$t/mydir")->all(0)),          f $expected4);
is(prep(io("$t/mydir")->All),             f $expected4);
is(prep(io("$t/mydir")->deep->all),       f $expected4);
is(prep(io("$t/mydir")->all_files),       f $expected_files1);
is(prep(io("$t/mydir")->all_files(1)),    f $expected_files1);
is(prep(io("$t/mydir")->all_files(2)),    f $expected_files2);
is(prep(io("$t/mydir")->all_files(3)),    f $expected_files2);
is(prep(io("$t/mydir")->all_files(4)),    f $expected_files4);
is(prep(io("$t/mydir")->all_files(5)),    f $expected_files4);
is(prep(io("$t/mydir")->all_files(0)),    f $expected_files4);
is(prep(io("$t/mydir")->All_Files),       f $expected_files4);
is(prep(io("$t/mydir")->deep->all_files), f $expected_files4);
is(prep(io("$t/mydir")->All_Files(2)),    f $expected_files4);
is(prep(io("$t/mydir")->all_dirs),        f $expected_dirs1);
is(prep(io("$t/mydir")->all_dirs(1)),     f $expected_dirs1);
is(prep(io("$t/mydir")->all_dirs(2)),     f $expected_dirs2);
is(prep(io("$t/mydir")->all_dirs(3)),     f $expected_dirs3);
is(prep(io("$t/mydir")->all_dirs(4)),     f $expected_dirs3);
is(prep(io("$t/mydir")->all_dirs(5)),     f $expected_dirs3);
is(prep(io("$t/mydir")->all_dirs(0)),     f $expected_dirs3);
is(prep(io("$t/mydir")->All_Dirs),        f $expected_dirs3);
is(prep(io("$t/mydir")->deep->all_dirs),  f $expected_dirs3);
is(prep(io("$t/mydir")->filter(sub {/dira/})->All_Dirs), f $expected_filt1);
is(prep(io("$t/mydir")->filter(sub {/x/})->All_Dirs),    f $expected_filt2);

del_output_dir();
