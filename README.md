
# SciChart.TA-Lib

Extensions to TA-Lib to allow compilation and inclusion in the .NET Platform with AnyCPU

####WORK IN PROGRESS

 - Compiles in Debug | x86 only at the moment
 - Requires VS2015 and Visual Studio C++ 2015 Runtime on target PC 
 - Working on Swig wrappers for TA-Lib and some basic tests to ensure / assert behaviour 
 - TODO: Generate x64 and handle AnyCPU by dynamically loading the correct framework 
 - TODO: Nice .NET Wrapper around TA-Lib to give sensible syntax e.g. LINQ? or Reactive? Pushing from ticks/quotes into dataseries
 - TODO: Create NuGet package and publish as open source library 
