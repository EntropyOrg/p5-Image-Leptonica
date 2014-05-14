use Test::More;
use Module::Load;

use_ok('Image::Leptonica');

Inline->import( with => qw(Image::Leptonica) );
Inline->bind( C => q{
extern PIX * pixRead ( const char *filename );
},
	ENABLE => AUTOWRAP => );

my $pix = pixRead( '/tmp/4.2.03.tiff' );
use DDP; p $pix;

done_testing;
