package Image::Leptonica::Raw;
$Image::Leptonica::Raw::VERSION = '0.01';
use strict;
use warnings;

use Inline C => './leptonica.h'
	ENABLE => AUTOWRAP =>
	AUTO_INCLUDE => '#include "allheaders.h"';

__END__

=pod

=encoding UTF-8

=head1 NAME

Image::Leptonica::Raw

=head1 VERSION

version 0.01

=head1 AUTHOR

Zakariyya Mughal <zmughal@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Zakariyya Mughal.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
