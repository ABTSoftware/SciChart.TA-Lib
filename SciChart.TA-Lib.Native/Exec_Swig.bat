"..\Lib\Swig\Swig.exe" -csharp -c++ -DSWIG_CSHARP_NO_IMCLASS_STATIC_CONSTRUCTOR -outfile "..\SciChart.TA-Lib.Net\TA-Lib.Interop.cs"  -I..\TA-Lib\c\include -namespace SciChart.TA_Lib.Net TA-Lib.i  

REM Add Pragma warning disable/enable around file contents 
@echo off
copy "..\SciChart.TA-Lib.Net\TA-Lib.Interop.cs" temp.txt
@echo // ReSharper disable RedundantNameQualifier > disable.txt
@echo // ReSharper disable InconsistentNaming >> disable.txt 
@echo // ReSharper disable RedundantDefaultMemberInitializer >> disable.txt
@echo // ReSharper disable PartialTypeWithSinglePart >> disable.txt
@echo // ReSharper disable RedundantDelegateCreation >> disable.txt
@echo // ReSharper disable ThreadStaticFieldHasInitializer >> disable.txt
@echo // ReSharper disable RedundantToStringCall >> disable.txt
@echo #pragma warning disable >> disable.txt 
@echo #pragma warning restore > enable.txt
copy disable.txt + temp.txt  + enable.txt "..\SciChart.TA-Lib.Net\TA-Lib.Interop.cs" 
del disable.txt 
del enable.txt 
del temp.txt 