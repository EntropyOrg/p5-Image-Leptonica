/* vim: ts=4 sw=4
 */
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"

typedef HV* Image__Leptonica;          /* Image::Leptonica */

MODULE = Image::Leptonica      PACKAGE = Image::Leptonica

PROTOTYPES: ENABLE

const char*
version(SV* self)
	CODE:
		RETVAL = uninum_version();
	OUTPUT: RETVAL
