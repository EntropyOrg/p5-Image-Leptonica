use Test::More;
use Module::Load;

use_ok('Image::Leptonica');

SKIP: {
	eval { load 'Inline' } or do {
		my $error = $@;
		skip "Inline not installed", 1 if $error;
	};

	Inline->import( with => qw(Image::Leptonica) );
	Inline->bind( C => q{ extern char * getLeptonicaVersion (  ); },
		ENABLE => AUTOWRAP => );

	like( getLeptonicaVersion(), qr/^leptonica-/);
}

done_testing;
