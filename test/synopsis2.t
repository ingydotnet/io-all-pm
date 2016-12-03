use strict;
use warnings;
my $t;
use lib ($t = -e 't' ? 't' : 'test');
use Test::More tests => 10;
use IO::All;
use IO_All_Test;

# Print name and first line of all files in a directory
my $dir = io("$t/mydir");
ok($dir->is_dir);
my @results;
while (my $io = $dir->next) {
    if ($io->is_file) {
        push @results, $io->name . ' - ' . $io->getline;
    }
}

for my $line (sort @results) {
    my $dataline = <DATA>;
    $dataline =~ s/^t\//test\// if -e 'test';
    is($line, flip_slash $dataline);
}

# Print name of all files recursively
for (
    sort {$a->name cmp $b->name}
    grep {!/CVS|\.svn/} io("$t/mydir")->all_files(0)
  )
{
    my $dataline = <DATA>;
    $dataline =~ s/^t\//test\// if -e 'test';
    is(
        "$_\n", flip_slash $dataline);
}

del_output_dir();

__END__
t/mydir/file1 - file1 is fun
t/mydir/file2 - file2 is woohoo
t/mydir/file3 - file3 is whee
t/mydir/dir1/dira/dirx/file1
t/mydir/dir1/file1
t/mydir/dir2/file1
t/mydir/file1
t/mydir/file2
t/mydir/file3
