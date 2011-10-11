package IO::All::Mo;
# use Mo qw'default chain option exporter xxx import';
#   The following line of code was produced from the previous line by
#   Mo::Inline version 0.27
no warnings;my$M=__PACKAGE__.::;*{$M.Object::new}=sub{bless{@_[1..$#_]},$_[0]};*{$M.import}=sub{import warnings;$^H|=1538;my($P,%e,%o)=caller.::;shift;eval"no Mo::$_",&{$M.$_.::e}($P,\%e,\%o)for@_;return if$e{M};%e=(extends,sub{eval"no $_[0]()";@{$P.ISA}=$_[0]},has,sub{my$n=shift;my$m=sub{$#_?$_[0]{$n}=$_[1]:$_[0]{$n}};$m=$o{$_}->($m,$n,@_)for sort keys%o;*{$P.$n}=$m},%e,);*{$P.$_}=$e{$_}for keys%e;@{$P.ISA}=$M.Object};*{$M.'default::e'}=sub{my($P,$e,$o)=@_;$o->{default}=sub{my($m,$n,%a)=@_;$a{default}or return$m;sub{$#_?$m->(@_):!exists$_[0]{$n}?$_[0]{$n}=$a{default}->(@_):$m->(@_)}}};*{$M.'chain::e'}=sub{my($P,$e,$o)=@_;$o->{chain}=sub{my($m,$n,%a)=@_;$a{chain}or return$m;sub{$#_?($m->(@_),return$_[0]):$m->(@_)}}};*{$M.'option::e'}=sub{my($P,$e,$o)=@_;$o->{option}=sub{my($m,$n,%a)=@_;$a{option}or return$m;my$n2=$n;*{$P."read_$n2"}=sub{$_[0]->{$n2}};sub{$#_?$m->(@_):$m->(@_,1);$_[0]}}};*{$M.'exporter::e'}=sub{my($P)=@_;if(defined@{$M.EXPORT}){*{$P.$_}=\&{$M.$_}for@{$M.EXPORT}}};use constant XXX_skip=>1;${$M.'::DumpModule'}='YAML::XS';*{$M.'xxx::e'}=sub{my($P,$e)=@_;$e->{WWW}=sub{require XXX;local$XXX::DumpModule=${$M.DumpModule};XXX::WWW(@_)};$e->{XXX}=sub{require XXX;local$XXX::DumpModule=${$M.DumpModule};XXX::XXX(@_)};$e->{YYY}=sub{require XXX;local$XXX::DumpModule=${$M.DumpModule};XXX::YYY(@_)};$e->{ZZZ}=sub{require XXX;local$XXX::DumpModule=${$M.DumpModule};XXX::ZZZ(@_)}};my$i=\&import;*{$M.import}=sub{(@_==2 and not $_[1])?pop@_:@_==1?push@_,grep!/import/,@f:();goto&$i};@f=qw[default chain option exporter xxx import];use strict;use warnings;

$IO::All::Mo::DumpModule = 'Data::Dumper';
our @EXPORT = qw'proxy proxy_open';
# $YAML::DumpCode = 1;

sub proxy {
    my $package = caller;
    my ($proxy) = @_;
    no strict 'refs';
    return if defined &{"${package}::$proxy"};
    *{"${package}::$proxy"} =
      sub {
          my $self = shift;
          my @return = $self->io_handle->$proxy(@_);
          $self->error_check;
          wantarray ? @return : $return[0];
      };
}

sub proxy_open {
    my $package = caller;
    my ($proxy, @args) = @_;
    no strict 'refs';
    return if defined &{"${package}::$proxy"};
    my $method = sub {
        my $self = shift;
        $self->assert_open(@args);
        my @return = $self->io_handle->$proxy(@_);
        $self->error_check;
        wantarray ? @return : $return[0];
    };
    *{"$package\::$proxy"} =
    (@args and $args[0] eq '>') ?
    sub {
        my $self = shift;
        $self->$method(@_);
        return $self;
    }
    : $method;
}

1;
