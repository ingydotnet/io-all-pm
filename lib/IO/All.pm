##
# name:      IO::All
# author:    Ingy döt Net
# abstract:  I Owe All of it to Graham and Damian!
# license:   perl
# copyright: 2004, 2006, 2008, 2010, 2012

package IO::All;
use IO::All::OO;
use strict;

our $VERSION = 0.44;

use XXX;

use constant registry => {};

has plugins => (
    default => sub {
        [qw(
            IO::All::File
            IO::All::Dir
        )];
    }
);

my $arg_key_pattern = qr/^-(\w+)$/;
sub import {
    my $class = shift;
    my $args = [];
    my $insert;
    while (@_) {
        my $key = shift(@_);
        die "Unknown argument '$key' for $class usage"
            unless $key =~ $arg_key_pattern;
        my $arg = [$1];
        while (@_ and $_[0] !~ $arg_key_pattern) {
            push @$arg, shift(@_);
        }
        push @$args, $arg;
    }
    my $caller = caller;
    no strict 'refs';
    *{"${caller}::io"} = $class->make_constructor($args);
}

sub make_constructor {
    my ($class, $args) = @_;
    return sub {
        $class->new(%$args);
    };
}

sub new {
    my ($class, $object, $args) = @_;
}

sub BUILD {
}

1;
