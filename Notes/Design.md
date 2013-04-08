# Introduction

This is a design document for an upcoming version of IO::All.

IO::All is a Perl module that attempts to make all Input/Output operations in
Perl, as simple and normal as possible. IO::All has been in existence since
2005. It is useful and somewhat extensible, but has a number of
inconsistencies, flaws and misgivings.

This document will propose a better way to do it, and will also discuss how to
move the current API forward to the new API.

# Basic Principles of how IO::All should work

* IO::All provides a single entry point function called `io`.
* `use IO::All` should make this function available in a lexical scope.
  * Currently this scope is 'package' scope.
  * Would be nice, but maybe not possible to have true lexical scope.
* The `io` function is custom to its scope
  * The behavior it provides depends on the state of the scope
  * The behavior it provides also depends on the arguments passed to `use
    IO::All`
* `io` returns an IO::All object
  * The IO::All object has no I/O capabilities
  * Further method calls invoke a context, causing the IO::All object to
    rebless itself it something useful like IO::All::File.
* Certain methods force a rebless
  * `file(...), dir(...), socket(...), etc
  * These methods are more or less hard-coded currently
* Options to `use IO::All` that begin with a `-`, cause a method to be called
  on each new IO::All object.
  * use IO::All -encoding => 'big5';   # causes:
  * io('foo')->print('hi');                     # to mean:
  * io('foo')->encoding('big5')->print('hi');
* IO::All operations generally return other IO::All objects
  * Often they return themselves ($self) for chaining
* IO::All needs to be completely and consistently extensible
  * The extensions that ship with IO-All should be the same as third party
    extensions
  * Extensions register capabilities with IO::All (tied to a scope)
* IO::All operations can be strict or loose. Strict always throws errors on
  any possible error condition. Strict or loose should be determined by the
  presence of `use strict` in the scope (possibly).
* IO::All currently uses a big set of overloaded operations by default. This
  is loved by some and hated by others. It should probably be off by default
  for 2.0.

# IO::All Extensions

Currently the extension API is fairly muddy. I would like the new API to
require something like this:

    {
        use strict;
        use IO::All -overload;
        use IO::All::PrintingPress;

        my $io = io('path:to:printing:press#1');
        # is ref($io), 'IO::All';
        $io->print('IO::All');        # calls IO::All::PrintingPress::print
        # is ref($io), 'IO::All::PrintingPress';
    }
        
So you need to load any extensions that you want to use, within the scope that
you want them in. Exceptions are IO::All::File and IO::All::Dir, which are
automatically loaded, unless you say:

    use IO::All -none;

Extensions can register 2 things:

1. Register a method (or methods) that will force a rebless in that class.
2. Register a regexp (or function) that will cause a rebless when the input
   to io(...) matches.

These things are register according to the scope of the IO::All, so that the
`io` function will do the right things.

# Transition to the new API

It needs to be determined if the changes that need to be made are too
destructive to coexist with the current IO::All. That determination obviously
cannot be made until the new design is complete.

If it is not too destructive, IO::All and its extensions can be brought
forward.

If it is too destructive, here is one proposed solution:

Support IO::All 2 <options>;

The version '2' will load IO::All2 (or something) and no version will load the
old code.

It is important to assure that the old and new interfaces can coexist in the
same process space.

In the IO::All2 scenario, we would need to figure out if the current IO::All
extensions also needed forwarding.

