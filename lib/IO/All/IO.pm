##
# name:      IO::All::IO
# author:    Ingy döt Net
# abstract:  Base Class for Various IO::All Objects
# license:   perl
# copyright: 2012

package IO::All::IO;
use IO::All::OO;

has upgrade_methods => ( default => sub { [] } );

sub upgrade {
    my ($self) = @_;
    for my $key (keys %$self) {
        next if $key =~ /^_/;
        delete $self->{$key}
            unless $self->can($key);
    }
}

1;
