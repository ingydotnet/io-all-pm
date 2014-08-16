use strict; use warnings;
my $t; use lib ($t = -e 't' ? 't' : 'test');
use Test::More tests => 1;
use IO::All;
use IO_All_Test;
use Cwd;

{
    my $dir = io($t)->chdir;
    is((io(io->curdir->absolute->pathname)->splitdir)[-1], $t);
}

del_output_dir();
