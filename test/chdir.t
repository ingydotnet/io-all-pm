use strict;
use warnings;
use File::Basename;
use lib dirname(__FILE__);
use Test::More tests => 1;
use IO::All;
use IO_All_Test;
use Cwd;

my $testdir = dirname(__FILE__);
{
    my $dir = io($testdir)->chdir;
    is((io(io->curdir->absolute->pathname)->splitdir)[-1], $testdir);
}

del_output_dir();
