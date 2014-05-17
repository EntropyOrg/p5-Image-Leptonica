package Image::Leptonica::Func::fhmtgen1;

=head1 C<fhmtgen.1.c>

      Top-level fast hit-miss transform with auto-generated sels

             PIX     *pixHMTDwa_1()
             PIX     *pixFHMTGen_1()

=head1 FUNCTIONS

=head2 pixFHMTGen_1

PIX * pixFHMTGen_1 ( PIX *pixd, PIX *pixs, char *selname )

  pixFHMTGen_1()

      Input:  pixd (usual 3 choices: null, == pixs, != pixs)
              pixs (1 bpp)
              sel name
      Return: pixd

  Notes:
      (1) This is a dwa implementation of the hit-miss transform
          on pixs by the sel.
      (2) The sel must be limited in size to not more than 31 pixels
          about the origin.  It must have at least one hit, and it
          can have any number of misses.
      (3) This handles all required setting of the border pixels
          before erosion and dilation.

=head2 pixHMTDwa_1

PIX * pixHMTDwa_1 ( PIX *pixd, PIX *pixs, char *selname )

  pixHMTDwa_1()

      Input:  pixd (usual 3 choices: null, == pixs, != pixs)
              pixs (1 bpp)
              sel name
      Return: pixd

  Notes:
      (1) This simply adds a 32 pixel border, calls the appropriate
          pixFHMTGen_*(), and removes the border.
          See notes below for that function.

=cut

1;
