use strict;
use warnings;
my $t;
use lib ($t = -e 't' ? 't' : 'test');
use Test::More tests => 8;
use IO::All;
use IO_All_Test;

my $outfile = "$t/out.pm";
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
