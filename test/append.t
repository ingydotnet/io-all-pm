use strict; use warnings;
use lib -e 't' ? 't' : 'test';
use Test::More;
use IO::All;
use IO_All_Test;

plan((lc($^O) eq 'mswin32' and defined $ENV{PERL5_CPANPLUS_IS_RUNNING})
    ? (skip_all => "CPANPLUS/MSWin32 breaks this")
    : ($] < 5.008003)
      ? (skip_all => 'Broken on older perls')
      : (tests => 4)
);

{
    my $log = io->file(o_dir() . "/myappend.txt")->mode('>>')->open();

    $log->print("Hello World!\n");

    $log->close();
}

{
    # TEST
    ok (scalar(-f o_dir() . "/myappend.txt"), "myappend.txt exists.");

    my $contents = _slurp(o_dir() . "/myappend.txt");

    # TEST
    is ($contents, "Hello World!\n", "contents of the file are OK.");
}


{
    my $log = io->file(o_dir() . "/myappend.txt")->mode('>>')->open();

    $log->print("Message No. 2!\n");

    $log->close();
}

{
    # TEST
    ok (scalar(-f o_dir() . "/myappend.txt"), "myappend.txt exists.");

    my $contents = _slurp(o_dir() . "/myappend.txt");

    # TEST
    is ($contents, "Hello World!\nMessage No. 2!\n",
        "Second append was ok.");
}

sub _slurp
{
    my $filename = shift;

    open my $in, "<", $filename
        or die "Cannot open '$filename' for slurping - $!";

    local $/;
    my $contents = <$in>;

    close($in);

    return $contents;
}

del_output_dir();
