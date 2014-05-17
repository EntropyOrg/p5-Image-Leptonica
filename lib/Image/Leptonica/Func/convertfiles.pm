package Image::Leptonica::Func::convertfiles;

=head1 C<convertfiles.c>

  convertfiles.c

      Conversion to 1 bpp
          l_int32    convertFilesTo1bpp()

  These are utility functions that will perform depth conversion
  on selected files, writing the results to a specified directory.
  We start with conversion to 1 bpp.

=head1 FUNCTIONS

=head2 convertFilesTo1bpp

l_int32 convertFilesTo1bpp ( const char *dirin, const char *substr, l_int32 upscaling, l_int32 thresh, l_int32 firstpage, l_int32 npages, const char *dirout, l_int32 outformat )

  convertFilesTo1bpp()

      Input:  dirin
              substr (<optional> substring filter on filenames; can be NULL)
              upscaling (1, 2 or 4; only for input color or grayscale)
              thresh  (global threshold for binarization; use 0 for default)
              firstpage
              npages (use 0 to do all from @firstpage to the end)
              dirout
              outformat (IFF_PNG, IFF_TIFF_G4)
      Return: 0 if OK, 1 on error

  Notes:
      (1) Images are sorted lexicographically, and the names in the
          output directory are retained except for the extension.

=cut

1;
