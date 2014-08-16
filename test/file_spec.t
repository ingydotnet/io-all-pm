use strict; use warnings;
my $t; use lib ($t = -e 't' ? 't' : 'test');
use Test::More tests => 33;
use IO::All;
use IO_All_Test;

my $path = f("$t/file_spec.t");
like(io("././$t/file_spec.t")->canonpath, qr/\Q$path\E$/, 'give full canonical path for real files' );
is(io("././$t/file_spec.t")->ext, 't');
is(io("././$t/file_spec.t")->extension, 't');
$path = f("$t/bogus");
like(io("././$t/bogus")->canonpath, qr/\Q$path\E$/, 'give full canonical path for files that could exist');
is(join(';', grep {! /CVS|\.svn/} io->catdir($t, 'mydir')->all), f "$t/mydir/dir1;$t/mydir/dir2;$t/mydir/file1;$t/mydir/file2;$t/mydir/file3");
test_file_contents(io->catfile($t, 'mystuff')->scalar, "$t/mystuff");
test_file_contents(io->join($t, 'mystuff')->scalar, "$t/mystuff");
is(ref(io->devnull), 'IO::All::File');
ok(io->devnull->print('IO::All'));
# Not supporting class calls anymore. Objects only.
# ok(IO::All->devnull->print('IO::All'));
ok(io->rootdir->is_dir);
ok(io->tmpdir->is_dir);
ok(io->updir->is_dir);
like(io->case_tolerant, qr/^[01]$/);
ok(io('/foo/bar')->is_absolute);
ok(not io('foo/bar')->is_absolute);
{
    # if this fails on other OSes more examples for PATH will need to be made
    local $ENV{PATH} =
      $^O eq 'MSWin32'
      ? 'C:\PROGRAM FILES\COMMON FILES\MICROSOFT SHARED\WINDOWS LIVE;C:\PROGRAM FILES (X86)\COMMON FILES\MICROSOFT SHARED\WINDOWS LIVE;C:\PROGRAM FILES (X86)\INTEL\ICLS CLIENT\;C:\PROGRAM FILES\INTEL\ICLS CLIENT\;C:\Windows\SYSTEM32;C:\Windows;C:\Windows\SYSTEM32\WBEM;C:\Windows\SYSTEM32\WINDOWSPOWERSHELL\V1.0\;;C:\PROGRAM FILES (X86)\INTEL\OPENCL SDK\2.0\BIN\X86;C:\PROGRAM FILES (X86)\INTEL\OPENCL SDK\2.0\BIN\X64;C:\PROGRAM FILES\COMMON FILES\LENOVO;C:\PROGRAM FILES (X86)\WINDOWS LIVE\SHARED;C:\PROGRAM FILES (X86)\LENOVO\ACCESS CONNECTIONS\;C:\SWTOOLS\READYAPPS;C:\PROGRAM FILES (X86)\SYMANTEC\VIP ACCESS CLIENT\;C:\PROGRAM FILES (X86)\COMMON FILES\LENOVO;C:\PROGRAM FILES\INTEL\INTEL(R) MANAGEMENT ENGINE COMPONENTS\DAL;C:\PROGRAM FILES\INTEL\INTEL(R) MANAGEMENT ENGINE COMPONENTS\IPT;C:\PROGRAM FILES (X86)\INTEL\INTEL(R) MANAGEMENT ENGINE COMPONENTS\DAL;C:\PROGRAM FILES (X86)\INTEL\INTEL(R) MANAGEMENT ENGINE COMPONENTS\IPT;C:\PROGRAM FILES\INTEL\WIFI\BIN\;C:\PROGRAM FILES\COMMON FILES\INTEL\WIRELESSCOMMON\;C:\Program Files\ThinkPad\Bluetooth Software\;C:\Program Files\ThinkPad\Bluetooth Software\syswow64;C:\Program Files\MiKTeX 2.9\miktex\bin\x64\;C:\Dwimperl\perl\bin;C:\Dwimperl\perl\site\bin;C:\Dwimperl\c\bin;C:\Program Files\Intel\WiFi\bin\;C:\Program Files\Common Files\Intel\WirelessCommon'
      : '/home/frew/.plenv/bin:/home/frew/node/bin::/home/frew/code/git-super-status/bin:/opt/bin:/home/frew/code/teatime/bin:/home/frew/bin:/home/frew/code/dotfiles/bin:/home/frew/Dropbox/bin:/home/frew/Dropbox/go/bin:/home/frew/Dropbox/node/bin:/opt/bin:/home/frew/.plenv/bin:/home/frew/node/bin:/home/frew/code/git-super-status/bin:/opt/bin:/home/frew/code/teatime/bin:/home/frew/bin:/home/frew/code/dotfiles/bin:/home/frew/Dropbox/bin:/home/frew/Dropbox/go/bin:/home/frew/Dropbox/node/bin:/home/frew/.plenv/shims:/home/frew/perl5/perlbrew/bin:/home/frew/perl5/perlbrew/perls/perl-5.16.0/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/frew/.zsh/adenosine/bin:/home/frew/.zsh/adenosine/bin';
    my $expected = $^O eq 'MSWin32' ? 31 : 36;
    my @path1 = io->path;
    is scalar( @path1 ), $expected, "expected amount of PATH entries returned";
}
my ($v, $d, $f) = io('foo/bar')->splitpath;
is($d, 'foo/');
is($f, 'bar');
my @dirs = io('foo/bar/baz')->splitdir;
is(scalar(@dirs), 3);
is(join('+', @dirs), 'foo+bar+baz');
test_file_contents(io->catpath('', $t, 'mystuff')->scalar, "$t/mystuff");
is(io('/foo/bar/baz')->abs2rel('/foo'), f 'bar/baz');
is(io('foo/bar/baz')->rel2abs('/moo'), f '/moo/foo/bar/baz');

is("".io->dir('doo/foo')->catdir('goo', 'hoo'), f 'doo/foo/goo/hoo');
is("".io->dir->catdir('goo', 'hoo'), f 'goo/hoo');
is("".io->catdir('goo', 'hoo'), f 'goo/hoo');

is("".io->file('doo/foo')->catfile('goo', 'hoo'), f 'doo/foo/goo/hoo');
is("".io->file->catfile('goo', 'hoo'), f 'goo/hoo');
is("".io->catfile('goo', 'hoo'), f 'goo/hoo');

is("".io->file('goo', 'hoo', 'bar.txt'), f 'goo/hoo/bar.txt');
is("".io->dir('goo', 'hoo'), f 'goo/hoo');

is("".io->dir('goo', 'hoo')->dir('boo', 'foo'), f 'goo/hoo/boo/foo');
is("".io->dir('goo', 'hoo')->dir('boo'), f 'goo/hoo/boo');
del_output_dir();
