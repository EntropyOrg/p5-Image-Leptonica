use Test::More;
use strict;

use_ok( "Image::Leptonica" );
use_ok( "Image::Leptonica::Pix" );

use Path::Class;
#my $filename = file("$ENV{HOME}/sw_projects/p5-Image-Leptonica/leptonica-1.69/prog/1555-3.jpg");
my $filename = file("$ENV{HOME}/sw_projects/p5-Image-Leptonica/leptonica-1.69/prog/test1.bmp");
my $pix = Image::Leptonica::Pix->read($filename);

#use DDP; p $pix;

my $morph = $pix->apply_morph;

use DDP; p $morph;

#my $filename_out = "/tmp/test-image" . ($filename =~ /(\.[^.]*)$/)[0];
my $filename_out = "/tmp/test-image" . ".gif";
$morph->write( $filename_out );

isa_ok( $pix, "Image::Leptonica::Pix" );
isa_ok( $morph, "Image::Leptonica::Pix" );
ok( -r $filename_out  );

done_testing;
