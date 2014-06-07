use strict;
use warnings;
use File::Basename;
use lib dirname(__FILE__);
use Test::More tests => 4;
use IO::All;
use IO_All_Test;

my $filename = f dirname(__FILE__) . '/mydir/file1';

my $file = io($filename);
ok($file->isa('IO::All::File'), 'string passed to io() is returned as a file');
is($file->name, $filename, 'name() is the same as the string');

my $file2 = io($file);
ok($file2->isa('IO::All::File'), 'IO::All::File object passed to io() is returned as a file');
is($file2->name, $filename, 'name() is the same as the original string');

del_output_dir();
