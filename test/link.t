use strict; use warnings;
use lib -e 't' ? 't' : 'test';
use Test::More;
use IO::All;
use IO_All_Test;
use Cwd qw(abs_path);

my $cwd = abs_path('.');
eval { symlink("$cwd/lib/IO/All.pm", o_dir() . '/IO-All-file-link') or die $! };

if ($@ or not (-e o_dir() . '/IO-All-file-link' and -l o_dir() . '/IO-All-file-link')) {
    plan skip_all => 'Cannot call symlink on this platform';
}
else {
    plan tests => 9;
}

my $file_link = io(o_dir() . '/IO-All-file-link');
ok($file_link->is_link, 'Link to file is a link (not a file)');
my $file_target = $file_link->readlink;
ok(! $file_target->is_link, 'readlink returns file object, not link' );
is($file_target->filename, 'All.pm', 'link target is expected file' );
is($$file_link, $file_target, 'Link to file derefs to the file');

symlink("$cwd/lib/IO", o_dir() . '/IO-All-dir-link');

my $dir_link = io(o_dir() . '/IO-All-dir-link');
ok($dir_link->is_link, 'Link to dir is a link (not a dir)');
my $dir_target = $dir_link->readlink;
ok(! $dir_target->is_link, 'readlink returns dir object, not link' );
ok($dir_target->is_dir, 'readlink returns dir object, not link' );
is($dir_target->filename, 'IO', 'link target is expected dir' );
is($$dir_link, $dir_target, 'Link to dir derefs to the dir');



del_output_dir();
