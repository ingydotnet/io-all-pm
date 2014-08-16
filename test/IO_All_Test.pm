package IO_All_Test;
use File::Path;
@EXPORT = qw(
    del_output_dir
    o_dir
    test_file_contents
    test_file_contents2
    test_matching_files
    read_file_lines
    flip_slash f
    $output_dir
);
use strict;
use base 'Exporter';
use Test::More ();

sub test_file_contents {
    my ($data, $file) = @_;
    Test::More::is($data, read_file($file));
}

sub test_file_contents2 {
    my ($file, $data) = @_;
    Test::More::is(read_file($file), $data);
}

sub test_matching_files {
    my ($file1, $file2) = @_;
    Test::More::is(read_file($file1), read_file($file2));
}

sub read_file {
    my ($file) = @_;
    local(*FILE, $/);
    open FILE, $file
      or die "Can't open $file for input:\n$!";
    return scalar <FILE>;
}

sub read_file_lines {
    my ($file) = @_;
    local(*FILE);
    open FILE, $file or die $!;
    (<FILE>);
}

sub flip_slash {
    my $string = shift;
    if ($^O =~ /^mswin32$/i) {
        $string =~ s/\//\\/g;
    }
    return $string;
}
{
    no warnings;
    *f = \&flip_slash;
}

use vars qw($output_dir);

BEGIN {
    use FindBin qw($Script);
    use File::Temp qw(tempdir);
    my $t = -e 't' ? 't' : 'test';

    if ($Script =~ m{([\w\-]+)\.t\z}) {
        $output_dir = "$t/output__$1";
    }
    else {
        $output_dir = tempdir("$t/output__XXXXXXXX");
    }
}

sub o_dir
{
    return $output_dir;
}

sub del_output_dir
{
    File::Path::rmtree($output_dir);
}

# TODO : this common directory that is deleted and recreated may prevent
# running the tests in parallel.
BEGIN {
    if (-d $output_dir)
    {
        del_output_dir();
    }
    File::Path::mkpath($output_dir);
}

1;
