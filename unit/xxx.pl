BEGIN {$^W = 1}
use strict;
use IO::All;

# Copy STDIN to a String File one paragraph at a time
my $stdin = io('-');
my $string_out = io('$');
while (my $paragraph = $stdin->getline('')) {
    $string_out->print($paragraph);
}

print ${$string_out->string_ref};
