package Image::Leptonica;
# ABSTRACT: image processing library (using the Leptonica library)
$Image::Leptonica::VERSION = '0.01';
use strict;
use warnings;

use File::Spec::Functions qw(catfile);
use Path::Class;
use Alien::Leptonica;
use Inline;

our $alien = Alien::Leptonica->new;

my $leptonica_h = file(__FILE__)->dir
	->file('Leptonica', 'leptonica.h')
	->slurp();

Inline->bind( C => $leptonica_h =>
	NAME => 'Image::Leptonica' =>
	VERSION => $Image::Leptonica::VERSION =>
	INC => $alien->cflags, LIBS => $alien->libs =>
	ENABLE => AUTOWRAP =>
	AUTO_INCLUDE => '#include "allheaders.h"');

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Image::Leptonica - image processing library (using the Leptonica library)

=head1 VERSION

version 0.01

=head1 SYNOPSIS

  use Image::Leptonica;

  # TODO

=head1 DESCRIPTION

TODO

=head1 SEE ALSO

L<Leptonica|http://www.leptonica.com/>

=head1 AUTHOR

Zakariyya Mughal <zmughal@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Zakariyya Mughal.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
