package Image::Leptonica::Func::binreduce;

=head1 C<binreduce.c>

  binreduce.c

      Subsampled 2x reduction
           PIX      *pixReduceBinary2()

      Rank filtered 2x reductions
           PIX      *pixReduceRankBinaryCascade()
           PIX      *pixReduceRankBinary2()

      Permutation table for 2x rank binary reduction
           l_uint8  *makeSubsampleTab2x(void)

=head1 FUNCTIONS

=head2 makeSubsampleTab2x

l_uint8 * makeSubsampleTab2x ( void )

  makeSubsampleTab2x()

  This table permutes the bits in a byte, from
      0 4 1 5 2 6 3 7
  to
      0 1 2 3 4 5 6 7

=head2 pixReduceBinary2

PIX * pixReduceBinary2 ( PIX *pixs, l_uint8 *intab )

  pixReduceBinary2()

      Input:  pixs
              tab (<optional>; if null, a table is made here
                   and destroyed before exit)
      Return: pixd (2x subsampled), or null on error

  Notes:
      (1) After folding, the data is in bytes 0 and 2 of the word,
          and the bits in each byte are in the following order
          (with 0 being the leftmost originating pair and 7 being
          the rightmost originating pair):
               0 4 1 5 2 6 3 7
          These need to be permuted to
               0 1 2 3 4 5 6 7
          which is done with an 8-bit table generated by makeSubsampleTab2x().

=head2 pixReduceRankBinary2

PIX * pixReduceRankBinary2 ( PIX *pixs, l_int32 level, l_uint8 *intab )

  pixReduceRankBinary2()

      Input:  pixs (1 bpp)
              level (rank threshold: 1, 2, 3, 4)
              intab (<optional>; if null, a table is made here
                     and destroyed before exit)
      Return: pixd (1 bpp, 2x rank threshold reduced), or null on error

  Notes:
      (1) pixd is downscaled by 2x from pixs.
      (2) The rank threshold specifies the minimum number of ON
          pixels in each 2x2 region of pixs that are required to
          set the corresponding pixel ON in pixd.
      (3) Rank filtering is done to the UL corner of each 2x2 pixel block,
          using only logical operations.  Then these pixels are chosen
          in the 2x subsampling process, subsampled, as described
          above in pixReduceBinary2().

=head2 pixReduceRankBinaryCascade

PIX * pixReduceRankBinaryCascade ( PIX *pixs, l_int32 level1, l_int32 level2, l_int32 level3, l_int32 level4 )

  pixReduceRankBinaryCascade()

      Input:  pixs (1 bpp)
              level1, ... level 4 (thresholds, in the set {0, 1, 2, 3, 4})
      Return: pixd, or null on error

  Notes:
      (1) This performs up to four cascaded 2x rank reductions.
      (2) Use level = 0 to truncate the cascade.

=cut

1;