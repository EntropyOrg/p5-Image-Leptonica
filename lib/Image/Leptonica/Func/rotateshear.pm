package Image::Leptonica::Func::rotateshear;
$Image::Leptonica::Func::rotateshear::VERSION = '0.03';

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Image::Leptonica::Func::rotateshear

=head1 VERSION

version 0.03

=head1 C<rotateshear.c>

  rotateshear.c

      Shear rotation about arbitrary point using 2 and 3 shears

              PIX      *pixRotateShear()
              PIX      *pixRotate2Shear()
              PIX      *pixRotate3Shear()

      Shear rotation in-place about arbitrary point using 3 shears
              l_int32   pixRotateShearIP()

      Shear rotation around the image center
              PIX      *pixRotateShearCenter()    (2 or 3 shears)
              l_int32   pixRotateShearCenterIP()  (3 shears)

  Rotation is measured in radians; clockwise rotations are positive.

  Rotation by shear works on images of any depth,
  including 8 bpp color paletted images and 32 bpp
  rgb images.  It works by translating each src pixel
  value to the appropriate pixel in the rotated dest.
  For 8 bpp grayscale images, it is about 10-15x faster
  than rotation by area-mapping.

  This speed and flexibility comes at the following cost,
  relative to area-mapped rotation:

    -  Jaggies are created on edges of straight lines

    -  For large angles, where you must use 3 shears,
       there is some extra clipping from the shears.

  For small angles, typically less than 0.05 radians,
  rotation can be done with 2 orthogonal shears.
  Two such continuous shears (as opposed to the discrete
  shears on a pixel lattice that we have here) give
  a rotated image that has a distortion in the lengths
  of the two rotated and still-perpendicular axes.  The
  length/width ratio changes by a fraction

       0.5 * (angle)**2

  For an angle of 0.05 radians, this is about 1 part in
  a thousand.  This distortion is absent when you use
  3 continuous shears with the correct angles (see below).

  Of course, the image is on a discrete pixel lattice.
  Rotation by shear gives an approximation to a continuous
  rotation, leaving pixel jaggies at sharp boundaries.
  For very small rotations, rotating from a corner gives
  better sensitivity than rotating from the image center.
  Here's why.  Define the shear "center" to be the line such
  that the image is sheared in opposite directions on
  each side of and parallel to the line.  For small
  rotations there is a "dead space" on each side of the
  shear center of width equal to half the shear angle,
  in radians.  Thus, when the image is sheared about the center,
  the dead space width equals the shear angle, but when
  the image is sheared from a corner, the dead space
  width is only half the shear angle.

  All horizontal and vertical shears are implemented by
  rasterop.  The in-place rotation uses special in-place
  shears that copy rows sideways or columns vertically
  without buffering, and then rewrite old pixels that are
  no longer covered by sheared pixels.  For that rewriting,
  you have the choice of using white or black pixels.
  (Note that this may give undesirable results for colormapped
  images, where the white and black values are arbitrary
  indexes into the colormap, and may not even exist.)

  Rotation by shear is fast and depth-independent.  However, it
  does not work well for large rotation angles.  In fact, for
  rotation angles greater than about 7 degrees, more pixels are
  lost at the edges than when using pixRotationBySampling(), which
  only loses pixels because they are rotated out of the image.
  For larger rotations, use pixRotationBySampling() or, for
  more accuracy when d > 1 bpp, pixRotateAM().

  For small angles, when comparing the quality of rotation by
  sampling and by shear, you can see that rotation by sampling
  is slightly more accurate.  However, the difference in
  accuracy of rotation by sampling when compared to 3-shear and
  (for angles less than 2 degrees, when compared to 2-shear) is
  less than 1 pixel at any point.  For very small angles, rotation by
  sampling is much slower than rotation by shear.  The speed difference
  depends on the pixel depth and the rotation angle.  Rotation
  by shear is very fast for small angles and for small depth (esp. 1 bpp).
  Rotation by sampling speed is independent of angle and relatively
  more efficient for 8 and 32 bpp images.  Here are some timings
  for the ratio of rotation times: (time for sampling)/ (time for shear)

       depth (bpp)       ratio (2 deg)       ratio (10 deg)
       -----------------------------------------------------
          1                  25                  6
          8                   5                  2.6
          32                  1.6                1.0

  In summary:
    * For d == 1 and small angles, use rotation by shear.  By default
      this will use 2-shear rotations, because 3-shears cause more
      visible artifacts in straight lines and, for small angles, the
      distortion in asperity ratio is small.
    * For d > 1, shear is faster than sampling, which is faster than
      area mapping.  However, area mapping gives the best results.
  These results are used in selecting the rotation methods in
  pixRotateShear().

  There has been some work on what is called a "quasishear
  rotation" ("The Quasi-Shear Rotation, Eric Andres,
  DGCI 1996, pp. 307-314).  I believe they use a 3-shear
  approximation to the continuous rotation, exactly as
  we do here.  The approximation is due to being on
  a square pixel lattice.  They also use integers to specify
  the rotation angle and center offset, but that makes
  little sense on a machine where you have a few GFLOPS
  and only a few hundred floating point operations to do (!)
  They also allow subpixel specification of the center of
  rotation, which I haven't bothered with, and claim that
  better results are possible if each of the 4 quadrants is
  handled separately.

  But the bottom line is that you are going to see shear lines when
  you rotate 1 bpp images.  Although the 3-shear rotation is
  mathematically exact in the limit of infinitesimal pixels, artifacts
  will be evident in real images.  One might imagine using dithering
  to break up the horizontal and vertical shear lines, but this
  is hard with block shears, where you need to dither on the block
  boundaries.  Dithering (by accumulation of 'error') with sampling
  makes more sense, but I haven't tried to do this.  There is only
  so much you can do with 1 bpp images!

=head1 FUNCTIONS

=head2 pixRotate2Shear

PIX * pixRotate2Shear ( PIX *pixs, l_int32 xcen, l_int32 ycen, l_float32 angle, l_int32 incolor )

  pixRotate2Shear()

      Input:  pixs
              xcen, ycen (center of rotation)
              angle (radians)
              incolor (L_BRING_IN_WHITE, L_BRING_IN_BLACK);
      Return: pixd, or null on error.

  Notes:
      (1) This rotates the image about the given point, using the 2-shear
          method.  It should only be used for angles smaller than
          MAX_2_SHEAR_ANGLE.  For larger angles, a warning is issued.
      (2) A positive angle gives a clockwise rotation.
      (3) 2-shear rotation by a specified angle is equivalent
          to the sequential transformations
             x' = x + tan(angle) * (y - ycen)     for x-shear
             y' = y + tan(angle) * (x - xcen)     for y-shear
      (4) Computation of tan(angle) is performed within the shear operation.
      (5) This brings in 'incolor' pixels from outside the image.
      (6) If the image has an alpha layer, it is rotated separately by
          two shears.

=head2 pixRotate3Shear

PIX * pixRotate3Shear ( PIX *pixs, l_int32 xcen, l_int32 ycen, l_float32 angle, l_int32 incolor )

  pixRotate3Shear()

      Input:  pixs
              xcen, ycen (center of rotation)
              angle (radians)
              incolor (L_BRING_IN_WHITE, L_BRING_IN_BLACK);
      Return: pixd, or null on error.

  Notes:
      (1) This rotates the image about the given point, using the 3-shear
          method.  It should only be used for angles smaller than
          LIMIT_SHEAR_ANGLE.  For larger angles, a warning is issued.
      (2) A positive angle gives a clockwise rotation.
      (3) 3-shear rotation by a specified angle is equivalent
          to the sequential transformations
            y' = y + tan(angle/2) * (x - xcen)     for first y-shear
            x' = x + sin(angle) * (y - ycen)       for x-shear
            y' = y + tan(angle/2) * (x - xcen)     for second y-shear
      (4) Computation of tan(angle) is performed in the shear operations.
      (5) This brings in 'incolor' pixels from outside the image.
      (6) If the image has an alpha layer, it is rotated separately by
          two shears.
      (7) The algorithm was published by Alan Paeth: "A Fast Algorithm
          for General Raster Rotation," Graphics Interface '86,
          pp. 77-81, May 1986.  A description of the method, along with
          an implementation, can be found in Graphics Gems, p. 179,
          edited by Andrew Glassner, published by Academic Press, 1990.

=head2 pixRotateShear

PIX * pixRotateShear ( PIX *pixs, l_int32 xcen, l_int32 ycen, l_float32 angle, l_int32 incolor )

  pixRotateShear()

      Input:  pixs
              xcen (x value for which there is no horizontal shear)
              ycen (y value for which there is no vertical shear)
              angle (radians)
              incolor (L_BRING_IN_WHITE, L_BRING_IN_BLACK);
      Return: pixd, or null on error.

  Notes:
      (1) This rotates an image about the given point, using
          either 2 or 3 shears.
      (2) A positive angle gives a clockwise rotation.
      (3) This brings in 'incolor' pixels from outside the image.
      (4) For rotation angles larger than about 0.35 radians, we issue
          a warning because you should probably be using another method
          (either sampling or area mapping)

=head2 pixRotateShearCenter

PIX * pixRotateShearCenter ( PIX *pixs, l_float32 angle, l_int32 incolor )

  pixRotateShearCenter()

      Input:  pixs
              angle (radians)
              incolor (L_BRING_IN_WHITE, L_BRING_IN_BLACK)
      Return: pixd, or null on error

=head2 pixRotateShearCenterIP

l_int32 pixRotateShearCenterIP ( PIX *pixs, l_float32 angle, l_int32 incolor )

  pixRotateShearCenterIP()

      Input:  pixs
              angle (radians)
              incolor (L_BRING_IN_WHITE, L_BRING_IN_BLACK)
      Return: 0 if OK, 1 on error

=head2 pixRotateShearIP

l_int32 pixRotateShearIP ( PIX *pixs, l_int32 xcen, l_int32 ycen, l_float32 angle, l_int32 incolor )

  pixRotateShearIP()

      Input:  pixs (any depth; not colormapped)
              xcen, ycen (center of rotation)
              angle (radians)
              incolor (L_BRING_IN_WHITE, L_BRING_IN_BLACK)
      Return: 0 if OK; 1 on error

  Notes:
      (1) This does an in-place rotation of the image about the
          specified point, using the 3-shear method.  It should only
          be used for angles smaller than LIMIT_SHEAR_ANGLE.
          For larger angles, a warning is issued.
      (2) A positive angle gives a clockwise rotation.
      (3) 3-shear rotation by a specified angle is equivalent
          to the sequential transformations
            y' = y + tan(angle/2) * (x - xcen)      for first y-shear
            x' = x + sin(angle) * (y - ycen)        for x-shear
            y' = y + tan(angle/2) * (x - xcen)      for second y-shear
      (4) Computation of tan(angle) is performed in the shear operations.
      (5) This brings in 'incolor' pixels from outside the image.
      (6) The pix cannot be colormapped, because the in-place operation
          only blits in 0 or 1 bits, not an arbitrary colormap index.

=head1 AUTHOR

Zakariyya Mughal <zmughal@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Zakariyya Mughal.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
