use lib 't';
use strict;
use warnings;
use Test::More tests => 12;
use IO::All;

is("".io->file(qw(foo bar baz biff))->as_foreign('Unix'), 'foo/bar/baz/biff');
is("".io->file(qw(foo bar baz biff))->as_foreign('Win32'), 'foo\bar\baz\biff');
is("".io->file(qw(foo bar baz biff))->as_foreign('Win32')->as_foreign('Unix'), 'foo/bar/baz/biff');
is("".io->file(qw(foo bar baz biff))->as_foreign('Unix')->as_foreign('Win32'), 'foo\bar\baz\biff');
is("".io->file(qw(C: foo bar baz biff))->as_foreign('Unix')->as_foreign('Win32'), 'C:\foo\bar\baz\biff');
is("".io->file(qw(C: foo bar baz biff))->as_foreign('Win32')->as_foreign('Unix'), '/foo/bar/baz/biff');

is("".io->dir(qw(foo bar baz biff))->as_foreign('Unix'), 'foo/bar/baz/biff');
is("".io->dir(qw(foo bar baz biff))->as_foreign('Win32'), 'foo\bar\baz\biff');
is("".io->dir(qw(foo bar baz biff))->as_foreign('Win32')->as_foreign('Unix'), 'foo/bar/baz/biff');
is("".io->dir(qw(foo bar baz biff))->as_foreign('Unix')->as_foreign('Win32'), 'foo\bar\baz\biff');
is("".io->dir(qw(C: foo bar baz biff))->as_foreign('Unix')->as_foreign('Win32'), 'C:\foo\bar\baz\biff');
is("".io->dir(qw(C: foo bar baz biff))->as_foreign('Win32')->as_foreign('Unix'), '/foo/bar/baz/biff');

