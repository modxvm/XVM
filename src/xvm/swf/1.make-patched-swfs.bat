@echo off

set as3_swfs=Application.swf
::set as3_swfs=%as3_swfs% gameloading.swf

rem Patch SWFs
for %%i in (%as3_swfs%) do call :do_patch_as3 %%~ni

goto :EOF

:do_patch_as3
set n=%1
echo %1.swf
copy /Y flash\%n%.swf %n%.orig.swf > nul
abcexport.exe %n%.orig.swf
rabcdasm %n%.orig-0.abc
set ok=failed
rem exit
patch --binary -p0 < %n%.patch && set ok=ok
echo patch result: %ok% (%n%.swf)
if "%ok%" == "ok" (
  rabcasm %n%.orig-0/%n%.orig-0.main.asasm
  abcreplace %n%.orig.swf 0 %n%.orig-0/%n%.orig-0.main.abc
  del %n%.orig-0.abc
  move /Y %n%.orig.swf %n%.swf
  del %n%.orig-0\%n%.orig-0.main.abc 
  rmdir /S /Q %n%.orig-0
) else (
  echo.
  echo Operation failed.
  echo Temporary files will be removed. If you want keep them - please manually close this window.
  pause
  del %n%.orig-0.abc
  del %n%.orig.swf
  rmdir /S /Q %n%.orig-0
)

goto :EOF

