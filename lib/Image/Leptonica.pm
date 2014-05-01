package Image::Leptonica;
# ABSTRACT: image processing library (using the Leptonica library)

use strict;
use warnings;

use File::Spec::Functions qw(catfile);
use Path::Class;
use Alien::Leptonica;
use Inline;

our $alien = Alien::Leptonica->new;

Inline->bind( C => file(__FILE__)->dir->file('leptonica.h') =>
        INC => $alien->cflags, LIBS => $alien->libs,
	ENABLE => AUTOWRAP =>
        AUTO_INCLUDE => '#include "allheaders.h"');

1;

=pod

=head1 SYNOPSIS

  use Image::Leptonica;

  # TODO

=head1 DESCRIPTION

TODO


=head1 SEE ALSO

L<Leptonica|http://www.leptonica.com/>

=cut
