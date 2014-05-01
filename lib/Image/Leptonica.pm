package Image::Leptonica;
# ABSTRACT: bindings to the Leptonica image processing library

use strict;
use warnings;

use File::Spec::Functions qw(catfile);
use Path::Class;
use Alien::Leptonica;
use Inline;

our $alien = Alien::Leptonica->new;

my $leptonica_h = file(__FILE__)->dir
	->file('leptonica.h')
	->slurp();

Inline->bind( C => $leptonica_h =>
	NAME => 'Image::Leptonica' =>
	VERSION => $Image::Leptonica::VERSION =>
	INC => $alien->cflags, LIBS => $alien->libs =>
	ENABLE => AUTOWRAP =>
	AUTO_INCLUDE => '#include "allheaders.h"' =>
	BOOT => <<'END_BOOT_C'
		HV *stash = gv_stashpvn ("Image::Leptonica::FileFormat", strlen("Image::Leptonica::FileFormat"), TRUE);
		newCONSTSUB(stash, "IFF_PNM", newSViv (IFF_PNM));
		newCONSTSUB(stash, "IFF_PNG", newSViv (IFF_PNG));
END_BOOT_C
	);

1;

=pod

=head1 SYNOPSIS

  use Image::Leptonica;

  # TODO

=head1 DESCRIPTION

This module binds to all the functions in the Leptonica image processing
library. It provides a very raw interface to the C functions.

=head1 SEE ALSO

L<Leptonica|http://www.leptonica.com/>

=cut
