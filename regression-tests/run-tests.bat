REM This is intended to be run in the /test-results directory
REM A copy is in the parent directory just for convenience in case of accidental deletion.
REM
@echo off
del *.cpp *.output
copy ..\*.cpp2 .
set count=0
for %%f in (mixed-*.cpp2) do (
    echo Starting cppfront.exe %%f
    C:\GitHub\cppfront\x64\Debug\cppfront.exe -n -s %%f > %%f.output 2>&1
    del %%f
    set /a count+=1
)
for %%f in (pure2-*.cpp2) do (
    echo Starting cppfront.exe %%f -p
    C:\GitHub\cppfront\x64\Debug\cppfront.exe -n -s -p %%f > %%f.output 2>&1
    del %%f
    set /a count+=1
)
set cpp_count=0
for %%A in (*.cpp) do set /a cpp_count+=1
set err_count=0
for %%A in (..\*error.cpp2) do set /a err_count+=1
set /a "total_count=%cpp_count%+%err_count%"
echo.
echo Done: %count% .cpp2 tests compiled
echo.
echo.      %cpp_count% .cpp files generated
echo.       %err_count% error test cases (should not generate .cpp)
echo.      %total_count% total
if %total_count% NEQ %count% (
    echo.      *** MISMATCH: should equal total tests run
)