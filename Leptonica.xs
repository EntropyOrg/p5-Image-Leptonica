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

i_l_error
write(Image__Leptonica__Pix self, const char* filename)
	CODE:
		/* TODO uses default format */
		RETVAL = pixWrite(filename, self, IFF_DEFAULT);
	OUTPUT: RETVAL
