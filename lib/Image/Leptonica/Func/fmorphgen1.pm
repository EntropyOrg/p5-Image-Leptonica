package Image::Leptonica::Func::fmorphgen1;

=head1 C<fmorphgen.1.c>

      Top-level fast binary morphology with auto-generated sels

             PIX     *pixMorphDwa_1()
             PIX     *pixFMorphopGen_1()

=head1 FUNCTIONS

=head2 pixFMorphopGen_1

PIX * pixFMorphopGen_1 ( PIX *pixd, PIX *pixs, l_int32 operation, char *selname )

  pixFMorphopGen_1()

      Input:  pixd (usual 3 choices: null, == pixs, != pixs)
              pixs (1 bpp)
              operation  (L_MORPH_DILATE, L_MORPH_ERODE,
                          L_MORPH_OPEN, L_MORPH_CLOSE)
              sel name
      Return: pixd

  Notes:
      (1) This is a dwa operation, and the Sels must be limited in
          size to not more than 31 pixels about the origin.
      (2) A border of appropriate size (32 pixels, or 64 pixels
          for safe closing with asymmetric b.c.) must be added before
          this function is called.
      (3) This handles all required setting of the border pixels
          before erosion and dilation.
      (4) The closing operation is safe; no pixels can be removed
          near the boundary.

=head2 pixMorphDwa_1

PIX * pixMorphDwa_1 ( PIX *pixd, PIX *pixs, l_int32 operation, char *selname )

  pixMorphDwa_1()

      Input:  pixd (usual 3 choices: null, == pixs, != pixs)
              pixs (1 bpp)
              operation  (L_MORPH_DILATE, L_MORPH_ERODE,
                          L_MORPH_OPEN, L_MORPH_CLOSE)
              sel name
      Return: pixd

  Notes:
      (1) This simply adds a border, calls the appropriate
          pixFMorphopGen_*(), and removes the border.
          See the notes for that function.
      (2) The size of the border depends on the operation
          and the boundary conditions.

=cut

1;
