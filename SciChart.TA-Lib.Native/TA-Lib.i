/* File : TA-Lib.i Generates SWIG.org wrappers for native types */

%module "TALib"
%{
	#include "ta_libc.h"
%}

// include standard SWIG typemaps 
%include "typemaps.i"

// Strip all const qualifies, they are not relevant to scripts,
// but may prevent SWIG release memory in proxy classes.
// This is safe because TA-Lib never sets returned const char pointers
// to anything in static (data) area by itself (except in ta_abstract).
// If needed, const members are made explicitly immutable.
%clear const char *;

// Include typemaps for CSharp 
%include "TA-Lib-CSharp.i"

/* Strip all const qualifies, they are not relevant to scripts,
 * but may prevent SWIG release memory in proxy classes.
 * This is safe because TA-Lib never sets returned const char pointers
 * to anything in static (data) area by itself (except in ta_abstract).
 * If needed, const members are made explicitly immutable.
 */
%clear const char *;

/* hiddenData should not be accessible for client code */
%ignore hiddenData;

/** ta_defs *****************************************************************/

/* The constants below are pulled out from <limits.h> and used by ta_defs.h 
 * to define some TA-specific constants.
 * They have to be redefined here otherwise SWIG would not be able
 * to determine the values of some TA constants and would skip them.
 * The limits.h constants themselves do not need to be exported by the module;
 * that's why they are tagged %ignore
 */

%ignore INT_MAX;
%ignore INT_MIN;
#define INT_MAX 2147483647
#define INT_MIN -INT_MAX-1


%include "ta_defs.h"


/*
 * TA_MA - Moving average
 * 
 * Input  = double
 * Output = double
 * 
 * Optional Parameters
 * -------------------
 * optInTimePeriod:(From 1 to 100000)
 *    Number of period
 * 
 * optInMAType:
 *    Type of Moving Average
 * 
 * 
 */
TA_RetCode TA_MA( int           START_IDX,
                  int           END_IDX,
                  const double *IN_ARRAY /* inReal */,
                  int           OPT_INT /* optInTimePeriod */, /* From 1 to 100000 */
                  TA_MAType     OPT_MATYPE /* optInMAType */,
                  int          *BEG_IDX,
                  int          *OUT_SIZE,
                  double       *OUT_ARRAY /* outReal */ );

int TA_MA_Lookback( int           optInTimePeriod, /* From 1 to 100000 */
                  TA_MAType     optInMAType ); 

