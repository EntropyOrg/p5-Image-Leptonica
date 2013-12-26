package Image::Leptonica;

use strict;
use warnings;

use XSLoader;
XSLoader::load( 'Image::Leptonica', $Image::Leptonica::VERSION );

=method new

Returns a new instance of L<Image::Leptonica>.

=cut
sub new {
	bless {}, shift;
}

1;
# ABSTRACT: image processing library (using the Leptonica library)

=pod

=head1 SYNOPSIS

  use Image::Leptonica;

  # TODO

=head1 DESCRIPTION

TODO


=head1 SEE ALSO

L<Leptonica|http://www.leptonica.com/>

=cut
