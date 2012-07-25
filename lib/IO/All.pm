##
# name:      IO::All
# author:    Ingy döt Net
# abstract:  I Owe All to Larry Wall!
# license:   perl
# copyright: 2004, 2006, 2008, 2010, 2012

package IO::All;
use IO::All::OO;
use strict;

our $VERSION = 0.01;

has location => ();
has plugin_classes => (
    default => sub { [qw(
        IO::All::File
        IO::All::Dir
    )] }
);
option 'strict';
option 'overload';

has methods => ( default => sub { +{} } );

my $arg_key_pattern = qr/^-(\w+)$/;
sub import {
    my $class = shift;
    my $caller = caller;
    no strict 'refs';
    *{"${caller}::io"} = $class->make_constructor(@_);
}

sub make_constructor {
    my $class = shift;
    my $scope_args = $class->parse_args(@_);
    return sub {
        $class->throw("'io' constructor takes zero or one arguments")
            if @_ > 1;
        my $location = @_ ? shift(@_) : undef;
        $class->new([-location => $location], @$scope_args);
    };
}

{
    no warnings 'redefine';
    sub new {
        my $class = shift;
        my $self = bless {}, $class;
        for (@_) {
            my $property = shift(@$_);
            $property =~ s/^-//;
            $self->$property(@$_);
        }
        for my $plugin_class (@{$self->plugin_classes}) {
            eval "require $plugin_class; 1"
                or $self->throw("Can't require $plugin_class: $@");
            $self->register_methods($plugin_class);
            $self->register_overloads($plugin_class);
            if ($plugin_class->can_upgrade($self)) {
                $self->rebless($plugin_class);
                last;
            }
        }
        return $self;
    }
}

# Parse
#   use IO::All -foo, -bar => 'x', 'y', -baz => 0;
# Into
#   [ ['-foo'], ['-bar', 'x', 'y'], ['-baz, 0] ]
sub parse_args {
    my $class = shift;
    my $args = [];
    while (@_) {
        my $key = shift(@_);
        die "Unknown argument '$key' for '$class' usage"
            unless $key =~ $arg_key_pattern;
        my $arg = [$1];
        push @$arg, shift(@_)
            while @_ and $_[0] !~ $arg_key_pattern;
        push @$args, $arg;
    }
    return $args;
}

sub with {
    my $self = shift;
    $self->plugin_classes([
        map { /::/ ? $_ : __PACKAGE__ . "::$_" } @_
    ]);
}

sub register_methods {
    my ($self, $plugin_class) = @_;
    for my $method (@{$plugin_class->upgrade_methods}) {
        $self->methods->{$method} = $plugin_class;
    }
}

sub register_overloads {
    my ($self, $plugin_class) = @_;
}

sub AUTOLOAD {
    my $self = shift;
    (my $method = $IO::All::AUTOLOAD) =~ s/.*:://;
    my $plugin_class = $self->methods->{$method}
        or $self->throw(
            "Can't locate object method '$method' for '$self' object"
        );
    $self->rebless($plugin_class);
    $self->$method(@_);
}

sub rebless {
    my ($self, $plugin_class) = @_;
    delete $self->{plugin_classes};
    bless $self, $plugin_class;
    $self->upgrade;
}

sub DESTROY {}

1;
