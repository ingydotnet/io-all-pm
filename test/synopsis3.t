use strict; use warnings;
my $t; use lib ($t = -e 't' ? 't' : 'test');
use Test::More tests => 3;
use IO_All_Test;
use Config;

sub fix {
    local $_ = shift;
    if ($^O eq 'MSWin32') {
        s/"/'/g;
        return qq{"$_"};
    }
    return qq{'$_'};
}

undef $/;
# # Copy STDIN to STDOUT
# io('-')->print(io('-')->slurp);
my $test1 = fix 'io("-")->print(io("-")->slurp)';
open TEST, '-|', qq{$^X -Ilib -MIO::All -e $test1 < $t/mystuff}
  or die "open failed: $!";
test_file_contents(<TEST>, "$t/mystuff");
close TEST;

# # Copy STDIN to STDOUT a block at a time
# my $stdin = io('-');
# my $stdout = io('-');
# $stdout->buffer($stdin->buffer);
# $stdout->write while $stdin->read;
my $test2 = fix 'my $stdin = io("-");my $stdout = io("-");$stdout->buffer($stdin->buffer);$stdout->write while $stdin->read';
open TEST, '-|', qq{$^X -Ilib -MIO::All -e $test2 < $t/mystuff}
  or die "open failed: $!";
test_file_contents(<TEST>, "$t/mystuff");
close TEST;

# # Copy STDIN to a String File one line at a time
# my $stdin = io('-');
# my $string_out = io('$');
# while (my $line = $stdin->getline) {
#     $string_out->print($line);
# }
my $test3 = fix 'my $stdin = io("-");my $string_out = io(q{$});while (my $line = $stdin->getline("")) {$string_out->print($line)} print ${$string_out->string_ref}';
open TEST, '-|', qq{$^X -Ilib -MIO::All -e $test3 < $t/mystuff}
  or die "open failed: $!";
test_file_contents(<TEST>, "$t/mystuff");
close TEST;

del_output_dir();
