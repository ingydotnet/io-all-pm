use lib 't';
use strict;
use warnings;
use Test::More tests => 12;
use IO::All;

is("".io->file(qw(foo bar baz biff))->os('unix'), 'foo/bar/baz/biff');
is("".io->file(qw(foo bar baz biff))->os('win32'), 'foo\bar\baz\biff');
is("".io->file(qw(foo bar baz biff))->os('win32')->os('unix'), 'foo/bar/baz/biff');
is("".io->file(qw(foo bar baz biff))->os('unix')->os('win32'), 'foo\bar\baz\biff');
{
   local $TODO = 'unix drops drive';
   is("".io->file(qw(C: foo bar baz biff))->os('unix')->os('win32'), 'C:\foo\bar\baz\biff');
   is("".io->dir(qw(C: foo bar baz biff))->os('unix')->os('win32'), 'C:\foo\bar\baz\biff');
}
is("".io->file(qw(C: foo bar baz biff))->os('win32')->os('unix'), '/foo/bar/baz/biff');

is("".io->dir(qw(foo bar baz biff))->os('unix'), 'foo/bar/baz/biff');
is("".io->dir(qw(foo bar baz biff))->os('win32'), 'foo\bar\baz\biff');
is("".io->dir(qw(foo bar baz biff))->os('win32')->os('unix'), 'foo/bar/baz/biff');
is("".io->dir(qw(foo bar baz biff))->os('unix')->os('win32'), 'foo\bar\baz\biff');
is("".io->dir(qw(C: foo bar baz biff))->os('win32')->os('unix'), '/foo/bar/baz/biff');

