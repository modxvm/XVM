@echo off

rem Run from res/packages

rem Calculate number of packages (used only for logging)
set total=0
for %%i in (*.pkg) do set /a total+=1

echo Create packages tree
if not exist res\packages md res\packages
set count=0
for %%i in (*.pkg) do call :process_package %%i

echo Compressing packages
set count=0
for %%i in (*.pkg) do call :compress_package %%i

echo Cleanup
rmdir res /s /q

echo Done
goto :EOF

:process_package
set /a count+=1
echo.  %count%/%total%: %1
setlocal
set pkg=%1
set pkg=%pkg:~,-4%
rem Process each file in package
rem tokens: 1      2*
rem         Path = path and filename
for /F "tokens=1,2* delims== " %%j in ('7za l %1 -slt') do (
  if "%%j" == "Path" if not "%%k" == "%pkg%" call :process_file %pkg% %%k %%~nxk
)
endlocal
goto :EOF

:process_file
if exist "res\%2" call :move_file %1 %2 %3
goto :EOF

:move_file
setlocal
set pth=%2
call set pth=%%pth:\%3=%%
if not exist "res\packages\%1\%pth%" mkdir "res\packages\%1\%pth%"
move /Y "res\%2" "res\packages\%1\%2" > nul
endlocal
goto :EOF

:compress_package
set /a count+=1
echo.  %count%/%total%: %1
setlocal
set pkg=%1
set pkg=%pkg:~,-4%
if exist "res\packages\%pkg%" (
  7za a -tzip -mm=Deflate -mx=0 -mtc=off -r %1 "./res/packages/%pkg%/*.*" > nul
)
endlocal
goto :EOF
