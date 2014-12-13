use strict; use warnings;
use Test::More tests => 4;
my $t; use lib ($t = -e 't' ? 't' : 'test');
use IO::All;
use IO_All_Test;
use diagnostics;

my $io = io($0);

$io->absolute;
is("$io", File::Spec->rel2abs($0));
$io->relative;
is($io->pathname, File::Spec->abs2rel($0));

ok(io($t)->absolute->next->is_absolute);

# url like test
{
   my $io = io->file($0);
   $io->absolute;
   is(
      $io->relative(io->file($0)->absolute->filepath)
         ->os('unix')->name,
      "$t/absolute.t",
      'relative with base',
   );
}

del_output_dir();
