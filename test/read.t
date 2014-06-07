use strict;
use warnings;
use File::Basename;
use lib dirname(__FILE__);
use Test::More tests => 8;
use IO::All;
use IO_All_Test;

my $testdir = dirname(__FILE__);
my $outfile = "$testdir/out.pm";
ok(not -f $outfile);
my $input = io('lib/IO/All.pm')->open;
ok(ref $input);
my $output = io($outfile)->open('>');
ok(ref $output);
my $buffer;
$input->buffer($buffer);
$output->buffer($buffer);
ok(defined $buffer);
$output->write while $input->read;
ok(not length($buffer));
ok($output->close);
test_matching_files($outfile, 'lib/IO/All.pm');
ok($output->unlink);

del_output_dir();
