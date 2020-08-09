package DB::GnuRec;

use 5.026001;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

our @EXPORT = qw( new );

our $VERSION = '0.01';

require XSLoader;
XSLoader::load('DB::GnuRec', $VERSION);

sub new {
  return DB::GnuRec::rec_db_new();
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

DB::GnuRec - Perl extension for blah blah blah

=head1 SYNOPSIS

  use DB::GnuRec;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for DB::GnuRec, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

Neil Locketz, E<lt>pitb0ss@E<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2020 by Neil Locketz

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.26.1 or,
at your option, any later version of Perl 5 you may have available.


=cut
