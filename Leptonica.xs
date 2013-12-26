/* vim: ts=4 sw=4
 */
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"


#include "allheaders.h"


typedef HV* Image__Leptonica;          /* Image::Leptonica */
typedef PIX* Image__Leptonica__Pix;    /* Image::Leptonica::Pix */

MODULE = Image::Leptonica      PACKAGE = Image::Leptonica

PROTOTYPES: ENABLE

const char*
version(SV* self)
	CODE:
		RETVAL = getLeptonicaVersion();
	OUTPUT: RETVAL

MODULE = Image::Leptonica      PACKAGE = Image::Leptonica::IO

Image::Leptonica::Pix
read(SV* self, const char* filename)
	INIT:
	CODE:
		RETVAL = pixRead(filename);
	OUTPUT: RETVAL
