use Test::More;
use strict;

use_ok( "Image::Leptonica" );
use_ok( "Image::Leptonica::Pix" );

my $filename = "/home/zaki/sw_projects/p5-Image-Leptonica/leptonica-1.69/prog/1555-3.jpg";
my $pix = Image::Leptonica::Pix->read($filename);

isa_ok( $pix, "Image::Leptonica::Pix" );

done_testing;
