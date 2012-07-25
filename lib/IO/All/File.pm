##
# name:      IO::All::File
# author:    Ingy döt Net
# abstract:  File Plugin For IO::All
# license:   perl
# copyright: 2004, 2006, 2008, 2010, 2012

package IO::All::File;
use IO::All::OO;
extends 'IO::All::Filesys';

option 'utf8';

has handle => ();

# Upgrade from IO::All to IO::All::Dir
use constant upgrade_methods => [qw(file print)];

sub can_upgrade {
    my ($self, $object) = @_;
    my $location = $object->location;
    return if
        not defined $location or
        not length $location;
    -f $location;
}

#
# Worker Methods:
#

sub file {
    my $self = shift;
    $self->name(shift) if @_;
    return $self;
}

sub open {
    my $self = shift;
    my $fh;
    open $fh, '<', $self->name;
    $self->handle($fh);
    return $self;
}

sub all {
    my $self = shift;
    my $fh = $self->open->handle;
    return do { local $/; <$fh> }
}

sub print {
    my $self = shift;
    CORE::print(@_);
}

1;
