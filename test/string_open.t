use strict; use warnings;
use lib -e 't' ? 't' : 'test';
use Test::More tests => 1;
use IO::All;
use IO_All_Test;

my $s = io('$');
$s->append("write 1\n");
my $s1 = "scalar ref: (".$s->string_ref.")";
$s->append("write 2\n");
my $s2 = "scalar ref: (".$s->string_ref.")";

is($s1, $s2, "Don't create new string object with each write");

del_output_dir();
