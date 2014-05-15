use Test::More;
use Module::Load;

use_ok('Image::Leptonica');

use Path::Class;

#Inline->import( with => qw(Image::Leptonica) );
my $d = Image::Leptonica::Inline('C');
#unshift @{ $d->{TYPEMAPS} }, file(__FILE__)->dir->file('typemap.test')->absolute->stringify;
@{ $d->{TYPEMAPS} } = ( file(__FILE__)->dir->file('typemap.test')->absolute->stringify );
use DDP; p $d;
Inline->bind( C => q{
extern PIX * pixRead ( const char *filename );
extern char * getLeptonicaVersion (  );
},
	%$d,
	ENABLE => AUTOWRAP =>
	);

#my $l = file(__FILE__)->dir->file('typemap.test')->slurp(); use DDP; p $l;
my $pix = pixRead( '/tmp/4.2.03.tiff' );
use DDP; p $pix;

done_testing;
