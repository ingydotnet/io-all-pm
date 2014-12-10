use strict;
use warnings;
use Test::More;
use IO::All -binary;

my $t = -e 't' ? 't' : 'test';
my $io = io( "$t/mystuff" );

my %hash;
my @for = $io->for( sub { $hash{$_} = length } );
is_deeply \%hash, { "No bluff.\n" => 10, "is quite enough.\n" => 17, "My stuff\n" => 9 },
  "for runs a bit of code on each line";
is_deeply \@for, [], "for returns nothing";

my @map = $io->map( sub { "$_+", "-" } );
is_deeply \@map, [ "My stuff\n+", "-", "is quite enough.\n+", "-", "No bluff.\n+", "-" ],
  "map returns modified version of the input lines";

my @grep = $io->grep( sub { /uff/ } );
is_deeply \@grep, [ "My stuff\n", "No bluff.\n" ], "grep finds the lines for which \$code is true";

my $reduce = $io->reduce( sub { shift() + length }, 0 );
is $reduce, 36, "reduce returns an accumulator based on the input lines";

my $grep_dir = io->dir($t)->grep( sub { !/\./ } );
is $grep_dir, 9, "grep works on directories too";

done_testing;
