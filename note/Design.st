^ Introduction

Perl provides all the foundational functionality for Input/Output in all its
myriad forms.

Unforatunately using all these primitives is unnecessarily tedious. IO::All
was introduced in 2005 as a proof of concept that IO operations could all be
pleasantly simple and consistent.

While IO::All is off to a good start, it is not completely polished. It is
time for a rewrite. It makes sense to have a solid plan/specification, before
writing the code. This document is intended to be just that.

^ Current Design Concepts

* Export one function, `io`, that acts constructs an IO::All object.

^ Current Deficiencies
