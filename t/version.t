use Test::More;
use strict;

use_ok( "Image::Leptonica" );


is( Image::Leptonica->version, "leptonica-1.69" );

done_testing;
