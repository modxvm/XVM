@echo off

rem Disable sky
rem Run from res_mods\0.7.x

rem Отключить небо
rem Запускать из res_mods\0.7.x

for %%i in (..\..\res\packages\*.pkg) do call :process_package %%i

echo Done
goto :EOF

:process_package
echo.%~nx1
setlocal
rem Process each file in package
rem tokens: 1      2*
rem         Path = path and filename
for /F "tokens=1,2* delims== " %%j in ('7za l %1 -slt maps/skyboxes') do (
  if "%%j" == "Path" if not "%%k" == "%1" call :process_file %%k
)
endlocal
goto :EOF

:process_file
if not exist "%~p1" mkdir %~p1
echo.>nul 2>%1
goto :EOF
