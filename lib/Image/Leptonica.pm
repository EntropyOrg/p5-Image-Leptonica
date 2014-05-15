package Image::Leptonica;
# ABSTRACT: bindings to the Leptonica image processing library

use strict;
use warnings;

use File::Spec::Functions qw(catfile);
use Path::Class;
use Alien::Leptonica;
use Inline;
use ExtUtils::Depends;

our $leptonica_h = file(__FILE__)->dir
	->subdir('Leptonica')
	->file('leptonica.h')
	->slurp();

Inline->bind( C => $leptonica_h =>
	NAME => 'Image::Leptonica' =>
	VERSION => $Image::Leptonica::VERSION =>
	%{ Image::Leptonica::Inline('C') },
	ENABLE => AUTOWRAP =>
	BOOT => <<'END_BOOT_C'
		HV *stash = gv_stashpvn ("Image::Leptonica::FileFormat", strlen("Image::Leptonica::FileFormat"), TRUE);
		newCONSTSUB(stash, "IFF_PNM", newSViv (IFF_PNM));
		newCONSTSUB(stash, "IFF_PNG", newSViv (IFF_PNG));
END_BOOT_C
	);

sub Alien {
	our $alien = Alien::Leptonica->new;
	Alien::Leptonica::Inline(@_);
}

=pod

=head1 SYNOPSIS

  use Image::Leptonica;

  # TODO

=head1 DESCRIPTION

This module binds to all the functions in the Leptonica image processing
library. It provides a very raw interface to the C functions.

=head1 Inline support

This module supports L<Inline's with functionality|Inline/"Playing 'with' Others">.

=cut

sub Inline {
	return unless $_[0] eq 'C';
	our $info = ExtUtils::Depends::load('Image::Leptonica');
	+{
		%{ Image::Leptonica::Alien(@_) },
		TYPEMAPS  => $info->{typemaps},
	};
}

=head1 SEE ALSO

L<Leptonica|http://www.leptonica.com/>

=cut

1;
