use Test::More;
use strict;

use_ok( "Image::Leptonica::Raw" );


my $lept_version = "leptonica-1.70";
is( Image::Leptonica->version, $lept_version );
is( Image::Leptonica->new->version, $lept_version );

done_testing;
