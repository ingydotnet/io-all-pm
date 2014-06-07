use strict;
use warnings;
use File::Basename;
use lib dirname(__FILE__);
use Test::More tests => 30;
use IO::All;
use IO_All_Test;

my $testdir = dirname(__FILE__);
my $expected1 = "$testdir/mydir/dir1;$testdir/mydir/dir2;$testdir/mydir/file1;$testdir/mydir/file2;$testdir/mydir/file3";
my $expected2 = "$testdir/mydir/dir1;$testdir/mydir/dir1/dira;$testdir/mydir/dir1/file1;$testdir/mydir/dir2;$testdir/mydir/dir2/file1;$testdir/mydir/file1;$testdir/mydir/file2;$testdir/mydir/file3";
my $expected3 = "$testdir/mydir/dir1;$testdir/mydir/dir1/dira;$testdir/mydir/dir1/dira/dirx;$testdir/mydir/dir1/file1;$testdir/mydir/dir2;$testdir/mydir/dir2/file1;$testdir/mydir/file1;$testdir/mydir/file2;$testdir/mydir/file3";
my $expected4 = "$testdir/mydir/dir1;$testdir/mydir/dir1/dira;$testdir/mydir/dir1/dira/dirx;$testdir/mydir/dir1/dira/dirx/file1;$testdir/mydir/dir1/file1;$testdir/mydir/dir2;$testdir/mydir/dir2/file1;$testdir/mydir/file1;$testdir/mydir/file2;$testdir/mydir/file3";
my $expected_files1 = "$testdir/mydir/file1;$testdir/mydir/file2;$testdir/mydir/file3";
my $expected_files2 = "$testdir/mydir/dir1/file1;$testdir/mydir/dir2/file1;$testdir/mydir/file1;$testdir/mydir/file2;$testdir/mydir/file3";
my $expected_files4 = "$testdir/mydir/dir1/dira/dirx/file1;$testdir/mydir/dir1/file1;$testdir/mydir/dir2/file1;$testdir/mydir/file1;$testdir/mydir/file2;$testdir/mydir/file3";
my $expected_dirs1 = "$testdir/mydir/dir1;$testdir/mydir/dir2";
my $expected_dirs2 = "$testdir/mydir/dir1;$testdir/mydir/dir1/dira;$testdir/mydir/dir2";
my $expected_dirs3 = "$testdir/mydir/dir1;$testdir/mydir/dir1/dira;$testdir/mydir/dir1/dira/dirx;$testdir/mydir/dir2";
my $expected_filt1 = "$testdir/mydir/dir1/dira;$testdir/mydir/dir1/dira/dirx";
my $expected_filt2 = "$testdir/mydir/dir1/dira/dirx";

sub prep { join ';', grep { not /CVS|\.svn/ } @_ }

is(prep(io("$testdir/mydir")->all), f$expected1);
is(prep(io("$testdir/mydir")->all(1)), f$expected1);
is(prep(io("$testdir/mydir")->all(2)), f$expected2);
is(prep(io("$testdir/mydir")->all(3)), f$expected3);
is(prep(io("$testdir/mydir")->all(4)), f$expected4);
is(prep(io("$testdir/mydir")->all(5)), f$expected4);
is(prep(io("$testdir/mydir")->all(0)), f$expected4);
is(prep(io("$testdir/mydir")->All), f$expected4);
is(prep(io("$testdir/mydir")->deep->all), f$expected4);
is(prep(io("$testdir/mydir")->all_files), f$expected_files1);
is(prep(io("$testdir/mydir")->all_files(1)), f$expected_files1);
is(prep(io("$testdir/mydir")->all_files(2)), f$expected_files2);
is(prep(io("$testdir/mydir")->all_files(3)), f$expected_files2);
is(prep(io("$testdir/mydir")->all_files(4)), f$expected_files4);
is(prep(io("$testdir/mydir")->all_files(5)), f$expected_files4);
is(prep(io("$testdir/mydir")->all_files(0)), f$expected_files4);
is(prep(io("$testdir/mydir")->All_Files), f$expected_files4);
is(prep(io("$testdir/mydir")->deep->all_files), f$expected_files4);
is(prep(io("$testdir/mydir")->All_Files(2)), f$expected_files4);
is(prep(io("$testdir/mydir")->all_dirs), f$expected_dirs1);
is(prep(io("$testdir/mydir")->all_dirs(1)), f$expected_dirs1);
is(prep(io("$testdir/mydir")->all_dirs(2)), f$expected_dirs2);
is(prep(io("$testdir/mydir")->all_dirs(3)), f$expected_dirs3);
is(prep(io("$testdir/mydir")->all_dirs(4)), f$expected_dirs3);
is(prep(io("$testdir/mydir")->all_dirs(5)), f$expected_dirs3);
is(prep(io("$testdir/mydir")->all_dirs(0)), f$expected_dirs3);
is(prep(io("$testdir/mydir")->All_Dirs), f$expected_dirs3);
is(prep(io("$testdir/mydir")->deep->all_dirs), f$expected_dirs3);
is(prep(io("$testdir/mydir")->filter(sub {/dira/})->All_Dirs), f$expected_filt1);
is(prep(io("$testdir/mydir")->filter(sub {/x/})->All_Dirs), f$expected_filt2);

del_output_dir();
