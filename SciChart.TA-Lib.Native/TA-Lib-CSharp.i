// TALib: Requires unsafe modifier
%pragma(csharp) moduleclassmodifiers="public unsafe partial class"

// Requires dynamic loading of native module before any PInvoke 
// Modified from csharp.swg and remove standard static constructor using http://stackoverflow.com/questions/28718453/how-do-i-change-the-constructor-code-in-swig-generated-csharp-file
%pragma(csharp) imclasscode=%{
  static $imclassname()
  {
  	  // Dynamically load x64 x86 native library. See TA-Lib-CSharp.i for definition
	  SciChart.TA_Lib.Net.NativeDllLoader.InitNativeLibs();
  }
%}

// Require dynamic loading of native module before any PInvoke. 
// Modified from csharphead.swg


// include standard SWIG typemaps
%include "arrays_csharp.i"

// Apply typemaps from double[] in C# to fixed double* to double* in C++
%apply double FIXED[] {double* IN_ARRAY}
%apply double FIXED[] {double* OUT_ARRAY}

// Apply typemapes for out parameters common to TA-Lib
%apply int *OUTPUT { int *BEG_IDX}
%apply int *OUTPUT { int *OUT_SIZE}