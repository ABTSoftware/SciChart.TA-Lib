"..\Lib\Swig\Swig.exe" -csharp -c++ -DSWIG_CSHARP_NO_IMCLASS_STATIC_CONSTRUCTOR -outfile "..\SciChart.TA-Lib.Net\TA-Lib.Interop.cs"  -I..\TA-Lib\c\include -namespace SciChart.TA_Lib.Net TA-Lib.i  

REM Add Pragma warning disable/enable around file contents 
@echo off
copy "..\SciChart.TA-Lib.Native\TA-Lib.Interop.cs" temp.txt
@echo #pragma warning disable > disable.txt 
@echo #pragma warning restore > enable.txt 
copy disable.txt + temp.txt  + enable.txt "..\SciChart.TA-Lib.Native\TA-Lib.Interop.cs" 
del disable.txt 
del enable.txt 
del temp.txt 