use strict; use warnings;
my $t; use lib ($t = -e 't' ? 't' : 'test');
use Test::More;
use IO_All_Test;
use IO::All;
use open qw(:std :utf8);
use utf8;

plan((eval {require Tie::File; 1})
    ? (tests => 4)
    : (skip_all => "requires Tie::File")
);

(io(o_dir() . '/tie_file1') < io($0))->close;
my $file = io(o_dir() . '/tie_file1')->rdonly;
is($file->[-1], 'bar');
is($file->[-2], 'foo');

"foo\n" x 3 > io(o_dir() . '/tie_file2');
$file = io(o_dir() . '/tie_file2');
$file->[1] = 'bar';

$file = io(o_dir() . '/tie_file2')->utf8;
push @{$file}, 'åäöüß';

is ($file->size, 23, "file size with UTF-8 chars");

is ($file->all, <<EOT, "UTF-8 content");
foo
bar
foo
åäöüß
EOT

del_output_dir();

__END__
foo
bar
