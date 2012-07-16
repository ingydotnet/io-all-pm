##
# name:      IO::All::OO
# author:    Ingy döt Net
# abstract:  IO::All OO Base Class
# license:   perl
# copyright: 2012

package IO::All::OO;

# use Mo qw'default build import exporter';
#   The following line of code was produced from the previous line by
#   Mo::Inline version 0.31
no warnings;my$M=__PACKAGE__.'::';*{$M.Object::new}=sub{bless{@_[1..$#_]},$_[0]};*{$M.import}=sub{import warnings;$^H|=1538;my($P,%e,%o)=caller.'::';shift;eval"no Mo::$_",&{$M.$_.::e}($P,\%e,\%o,\@_)for@_;return if$e{M};%e=(extends,sub{eval"no $_[0]()";@{$P.ISA}=$_[0]},has,sub{my$n=shift;my$m=sub{$#_?$_[0]{$n}=$_[1]:$_[0]{$n}};$m=$o{$_}->($m,$n,@_)for sort keys%o;*{$P.$n}=$m},%e,);*{$P.$_}=$e{$_}for keys%e;@{$P.ISA}=$M.Object};*{$M.'default::e'}=sub{my($P,$e,$o)=@_;$o->{default}=sub{my($m,$n,%a)=@_;$a{default}or return$m;sub{$#_?$m->(@_):!exists$_[0]{$n}?$_[0]{$n}=$a{default}->(@_):$m->(@_)}}};*{$M.'build::e'}=sub{my($P,$e)=@_;$e->{new}=sub{$c=shift;my$s=bless{@_},$c;my@B;do{@B=($c.::BUILD,@B)}while($c)=@{$c.::ISA};exists&$_&&&$_($s)for@B;$s}};my$i=\&import;*{$M.import}=sub{(@_==2 and not $_[1])?pop@_:@_==1?push@_,grep!/import/,@f:();goto&$i};*{$M.'exporter::e'}=sub{my($P)=@_;if(defined@{$M.EXPORT}){*{$P.$_}=\&{$M.$_}for@{$M.EXPORT}}};@f=qw[default build import exporter];use strict;use warnings;

our @EXPORT = qw(chain option);

sub option {
    my $package = caller;
    my ($field, $default) = @_;
    $default ||= 0;
    field("_$field", $default);
    no strict 'refs';
    *{"${package}::$field"} =
      sub {
          my $self = shift;
          *$self->{"_$field"} = @_ ? shift(@_) : 1;
          return $self;
      };
}

sub chain {
    my $package = caller;
    my ($field, $default) = @_;
    no strict 'refs';
    *{"${package}::$field"} =
      sub {
          my $self = shift;
          if (@_) {
              *$self->{$field} = shift;
              return $self;
          }
          return $default unless exists *$self->{$field};
          return *$self->{$field};
      };
}

1;
