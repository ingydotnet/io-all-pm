use TestML -run, -bridge => 'main';

sub setup {
    shift;
    my $cmd = (shift)->value;
    `$cmd`;
}
sub eval_perl {
    shift;
    my $perl = (shift)->value;
    # eval $perl;
    my $expect = (shift)->value;
    die $expect;
}

__DATA__
%TestML 1.0

Plan = 4;

setup(*setup).eval_perl(*perl, *expect).Catch == *expect;

setup('rm -f foo');

=== foo doesn't exist
--- setup: rm -f foo
--- perl: io('foo')->appends
--- expect: throws exception

=== foo does exist
--- setup: touch foo
--- perl: io('foo')->create
--- expect: throws exception

# maybe require ->strict for those two:

=== foo doesn't exist
--- setup: rm foo
--- perl: io('foo')->strict->append
--- expect: definitely dies

=== foo does exist
--- setup: touch foo
--- perl: io('foo')->strict->create
--- expect: definitely dies

