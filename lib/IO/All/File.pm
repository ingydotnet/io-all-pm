##
# name:      IO::All
# author:    Ingy döt Net
# abstract:  File Plugin For IO::All
# license:   perl
# copyright: 2004, 2006, 2008, 2010, 2012

package IO::All::File;
use IO::All::OO;
extends 'IO::All::Plugin';

sub io_upgrade {
    my ($self) = @_;
    $self->file if
        defined $self->name and
        -e $self->name;
}

use constant io_methods => [qw(file print)];

use constant io_overloads => {
    'file > file' => 'overload_file_to_file',
    'file < file' => 'overload_file_from_file',
    '${} file' => 'overload_file_as_scalar',
    '@{} file' => 'overload_file_as_array',
    '%{} file' => 'overload_file_as_dbm',
};

sub file {
    my $self = shift;
    bless $self, __PACKAGE__;
    $self->name(shift) if @_;
    return $self;
    return $self->_init;
}

1;
