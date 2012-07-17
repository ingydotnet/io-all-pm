use TestML -run;


__END__
%TestML 1.0

Plan = 1;

1 == 1;

# *perl.eval.manifest == *with;

=== No plugin modules asked for
--- perl
package Foo;
use IO::All;
--- with
Foo
IO::All::File
IO::All::Dir

=== Declare plugins to work with
--- perl
package Bar;
use IO::All with => [qw'File Socket'];
--- with
Bar
IO::All::File
IO::All::Socket

=== Declare plugins in reverse order
--- perl
package Baz;
use IO::All with => [qw'Socket File'];
--- with
Baz
IO::All::Socket
IO::All::File


