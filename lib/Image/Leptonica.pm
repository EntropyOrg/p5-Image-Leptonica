package Image::Leptonica;
{
  $Image::Leptonica::VERSION = '0.001';
}

use strict;
use warnings;

use XSLoader;
XSLoader::load( 'Image::Leptonica', $Image::Leptonica::VERSION );

sub new {
	bless {}, shift;
}

1;
# ABSTRACT: image processing library (using the Leptonica library)

__END__

=pod

=encoding UTF-8

=head1 NAME

Image::Leptonica - image processing library (using the Leptonica library)

=head1 VERSION

version 0.001

=head1 SYNOPSIS

  use Image::Leptonica;

  # TODO

=head1 DESCRIPTION

TODO

=head1 METHODS

=head2 new

Returns a new instance of L<Image::Leptonica>.

=head1 SEE ALSO

L<Leptonica|http://www.leptonica.com/>

=head1 AUTHOR

Zakariyya Mughal <zmughal@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Zakariyya Mughal.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
