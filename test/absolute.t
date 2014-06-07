use strict;
use warnings;
use File::Basename;
use lib dirname(__FILE__);
use Test::More tests => 3;
use IO::All;
use IO_All_Test;
use diagnostics;

my $io = io($0);

my $testdir = dirname(__FILE__);
$io->absolute;
is("$io", File::Spec->rel2abs($0));
$io->relative;
is($io->pathname, File::Spec->abs2rel($0));

ok(io($testdir)->absolute->next->is_absolute);

del_output_dir();
