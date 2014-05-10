use Test::More;

use_ok('Image::Leptonica');

SKIP: {
	eval { require 'Inline' } or do {
		my $error = $@;
		die $error;
		skip "Inline not installed", 1 if $error;
	};

	Inline->import( with => qw(Image::Leptonica) );
	Inline->bind( C => q{ extern char * getLeptonicaVersion (  ); },
		ENABLE => AUTOWRAP => );

		use DDP; diag getLeptonicaVersion();
	like( getLeptonicaVersion(), qr/^leptonica-/);
}

done_testing;
