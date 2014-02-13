package IO::All::String;
use strict;
use warnings;
use IO::All -base;

const type => 'string';


sub string_ref {
   my ($self, $ref) = @_;

   no strict 'refs';
   *$self->{ref} = $ref if exists $_[1];

   return *$self->{ref}
}

sub string {
    my $self = shift;
    bless $self, __PACKAGE__;
    $self->_init;
}

sub open {
    my $self = shift;
    my $str = '';
    my $ref = \$str;
    $self->string_ref($ref);
    open my $fh, '+<', $ref;
    $self->io_handle($fh);
    $self->set_binmode;
    $self->is_open(1);
}

=encoding utf8

=head1 NAME

IO::All::String - String IO Support for IO::All

=head1 SYNOPSIS

See L<IO::All>.

=head1 DESCRIPTION

=head1 AUTHOR

Ingy döt Net <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2004. Brian Ingerson. All rights reserved.

Copyright (c) 2006, 2008. Ingy döt Net. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut

1;
