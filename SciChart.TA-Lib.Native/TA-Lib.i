/* File : TA-Lib.i Generates SWIG.org wrappers for native types */
%module "TALib"
%{
	#include "ta_libc.h"
%}

/* include standard SWIG typemaps */
%include <typemaps.i>
