package Image::Leptonica::Func::binexpand;

=head1 C<binexpand.c>

  binexpand.c

      Replicated expansion (integer scaling)
         PIX     *pixExpandBinaryReplicate()

      Special case: power of 2 replicated expansion
         PIX     *pixExpandBinaryPower2()

      Expansion tables for power of 2 expansion
         static l_uint16    *makeExpandTab2x()
         static l_uint32    *makeExpandTab4x()
         static l_uint32    *makeExpandTab8x()

=head1 FUNCTIONS

=head2 pixExpandBinaryPower2

PIX * pixExpandBinaryPower2 ( PIX *pixs, l_int32 factor )

  pixExpandBinaryPower2()

      Input:  pixs (1 bpp)
              factor (expansion factor: 1, 2, 4, 8, 16)
      Return: pixd (expanded 1 bpp by replication), or null on error

=head2 pixExpandBinaryReplicate

PIX * pixExpandBinaryReplicate ( PIX *pixs, l_int32 factor )

  pixExpandBinaryReplicate()

      Input:  pixs (1 bpp)
              factor (integer scale factor for replicative expansion)
      Return: pixd (scaled up), or null on error

=cut

1;
