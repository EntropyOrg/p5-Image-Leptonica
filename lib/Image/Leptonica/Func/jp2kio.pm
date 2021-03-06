package Image::Leptonica::Func::jp2kio;

=head1 C<jp2kio.c>

  jp2kio.c

      Read header
          l_int32          readHeaderJp2k()
          l_int32          freadHeaderJp2k()
          l_int32          sreadHeaderJp2k()

=head1 FUNCTIONS

=head2 freadHeaderJp2k

l_int32 freadHeaderJp2k ( FILE *fp, l_int32 *pw, l_int32 *ph, l_int32 *pspp )

  freadHeaderJp2k()

      Input:  stream opened for read
              &w (<optional return>)
              &h (<optional return>)
              &spp (<optional return>, samples/pixel)
      Return: 0 if OK, 1 on error

=head2 readHeaderJp2k

l_int32 readHeaderJp2k ( const char *filename, l_int32 *pw, l_int32 *ph, l_int32 *pspp )

  readHeaderJp2k()

      Input:  filename
              &w (<optional return>)
              &h (<optional return>)
              &spp (<optional return>, samples/pixel)
      Return: 0 if OK, 1 on error

=head2 sreadHeaderJp2k

l_int32 sreadHeaderJp2k ( const l_uint8 *data, size_t size, l_int32 *pw, l_int32 *ph, l_int32 *pspp )

  sreadHeaderJp2k()

      Input:  data
              size
              &w (<optional return>)
              &h (<optional return>)
              &spp (<optional return>, samples/pixel)
      Return: 0 if OK, 1 on error

  Notes:
      (1) The metadata is stored as follows:
          h:    4 bytes @ 48
          w:    4 bytes @ 52
          spp:  2 bytes @ 56

=cut

1;
