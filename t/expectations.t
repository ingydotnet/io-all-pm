use TestML -run;

__DATA__
%TestML 1.0

Plan = 1; 1 == 1; # Just pass for now.

=== foo doesn't exist
--- setup: rm foo
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

