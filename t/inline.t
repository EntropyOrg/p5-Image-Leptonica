use Test::More;

use_ok('Image::Leptonica');

SKIP: {
	eval { require 'Inline' };

	skip "Inline not installed" if $@;

	Inline->import( with => qw(Image::Leptonica) );
	Inline->bind( C => q{ extern char * getLeptonicaVersion (  ); },
		ENABLE => AUTOWRAP => );

		use DDP; diag getLeptonicaVersion();
	like( getLeptonicaVersion(), qr/^leptonica-/);
}

done_testing;
