package Image::Leptonica::Pix;

use strict;
use warnings;

sub new {
	my $class = shift;
	if( @_ == 1 ) {
		if( ref $_[0] eq 'Imager' ) {

		} elsif( ref $_[0] eq 'PDL' ) {

		}
	}
}


1;
# ABSTRACT: one line description TODO

=pod

=head1 SYNOPSIS

  use My::Package; # TODO

  print My::Package->new;

=head1 DESCRIPTION

TODO

=cut
