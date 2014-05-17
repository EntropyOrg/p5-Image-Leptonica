package Image::Leptonica::Func::fmorphgenlow1;

=head1 C<fmorphgenlow.1.c>

     Low-level fast binary morphology with auto-generated sels

      Dispatcher:
             l_int32    fmorphopgen_low_1()

      Static Low-level:
             void       fdilate_1_*()
             void       ferode_1_*()

=head1 FUNCTIONS

=head2 fmorphopgen_low_1

l_int32 fmorphopgen_low_1 ( l_uint32 *datad, l_int32 w, l_int32 h, l_int32 wpld, l_uint32 *datas, l_int32 wpls, l_int32 index )

  fmorphopgen_low_1()

       a dispatcher to appropriate low-level code

=cut

1;
