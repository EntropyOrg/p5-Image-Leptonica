/* vim: ts=4 sw=4
 */
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"


#include "allheaders.h"


typedef HV* Image__Leptonica;          /* Image::Leptonica */
typedef PIX* Image__Leptonica__Pix;    /* Image::Leptonica::Pix */

typedef int i_l_error;

MODULE = Image::Leptonica      PACKAGE = Image::Leptonica

PROTOTYPES: ENABLE

const char*
version(SV* self)
	CODE:
		RETVAL = getLeptonicaVersion();
	OUTPUT: RETVAL

MODULE = Image::Leptonica      PACKAGE = Image::Leptonica::Pix

Image::Leptonica::Pix
read(SV* self, const char* filename)
	CODE:
		RETVAL = pixRead(filename);
	OUTPUT: RETVAL

Image::Leptonica::Pix
apply_morph(Image::Leptonica::Pix self)
	INIT:
		SEL         *sel;
		SELA        *sela;
		U32         index;
		Image__Leptonica__Pix pixd;
		l_int32 ret;
	CODE:
		sela = selaAddBasic(NULL);
		selaFindSelByName(sela, "sel_9h", &index, &sel);
		/*selWriteStream(stderr, sel);*/
		ret = pixOtsuAdaptiveThreshold(self, 20, 20, 0, 0, 0.0, "", "");
		if(!ret) croak("noooooo... not that threshold!");
		pixd  = pixCreateTemplate(self);
		ret = pixDilate(pixd, self, sel);
		if(!ret) croak("dilation?");
		/* NOTE: since this came from the selaFindSelByName(), we can not call selDestroy(&sel); */
		/*selaDestroy(sela);*/
		RETVAL = SvREFCNT_inc(pixd);
	OUTPUT: RETVAL

i_l_error
write(Image::Leptonica::Pix self, const char* filename)
	CODE:
		/* TODO uses default format */
		RETVAL = pixWrite(filename, self, IFF_DEFAULT);
	OUTPUT: RETVAL

void
DESTROY(Image::Leptonica::Pix self)
	CODE:
		pixDestroy(&self);
