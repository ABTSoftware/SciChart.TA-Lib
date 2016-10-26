// TALib: Requires unsafe modifier
%typemap(csclassmodifiers) TALib "public unsafe partial class"

// include standard SWIG typemaps
%include "arrays_csharp.i"

// Apply typemaps from double[] in C# to fixed double* to double* in C++
%apply double FIXED[] {double* IN_ARRAY}
%apply double FIXED[] {double* OUT_ARRAY}

// ABOVE csclassmodifiers does not work on generated TALib static class so must apply at the method level
// TODO: Find out how to apply this to all methods in TALib generated class
%csmethodmodifiers TA_MA "public unsafe";

%apply int *OUTPUT { int *BEG_IDX}
%apply int *OUTPUT { int *OUT_SIZE}