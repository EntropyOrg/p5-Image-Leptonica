package Image::Leptonica::Func::libversions;

=head1 C<libversions.c>

  libversions.c

       Image library version number
           char      *getImagelibVersions()

=head1 FUNCTIONS

=head2 getImagelibVersions

char * getImagelibVersions (  )

  getImagelibVersions()

      Return: string of version numbers (e.g.,
               libgif 5.0.3
               libjpeg 8b
               libpng 1.4.3
               libtiff 3.9.5
               zlib 1.2.5
               webp 0.3.0

  Notes:
      (1) The caller has responsibility to free the memory.

=cut

1;
