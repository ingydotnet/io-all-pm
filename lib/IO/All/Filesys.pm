##
# name:      IO::All::Filesys
# author:    Ingy döt Net
# abstract:  Filesys Base Class
# license:   perl
# copyright: 2004, 2006, 2008, 2010, 2012

package IO::All::Filesys;
use IO::All::OO;
extends 'IO::All::IO';

has name => ();
option overload => ();

sub upgrade {
    my $self = shift;
    $self->{name} = delete $self->{location}
        if $self->{location};
    $self->SUPER::upgrade(@_);
}

1;
