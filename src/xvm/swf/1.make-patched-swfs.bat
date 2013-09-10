@echo off

set as3_swfs=Application.swf
::set as3_swfs=%as3_swfs% gameloading.swf

rem Patch SWFs
for %%i in (%as3_swfs%) do call :do_patch_as3 %%~ni

goto :EOF

:do_patch_as3
set n=%1
echo %1.swf
copy /Y flash\%n%.swf %n%.swf > nul
abcexport.exe %n%.swf
rabcdasm %n%-0.abc
set ok=failed
patch -p0 < %n%.patch && set ok=ok
echo patch result: %ok% (%n%.swf)
if "%ok%" == "ok" (
  rabcasm %n%-0/%n%-0.main.asasm
  abcreplace %n%.swf 0 %n%-0/%n%-0.main.abc
  del %n%-0.abc
  rmdir /S /Q %n%-0
)
goto :EOF
