@echo off

set patch_swfs=battleloading.swf PlayersPanel.swf StatisticForm.swf TeamBasesPanel.swf VehicleMarkersManager.swf
set copy_swfs=battle.swf

rem Copy SWFs without patching
for %%i in (%copy_swfs%) do call :do_copy_file %%~ni

rem Patch SWFs
for %%i in (%patch_swfs%) do call :do_patch_file %%~ni

goto :EOF

:do_patch_file
set n=%1
swfmill swf2xml orig\%n%.swf orig\%n%.xml
copy /Y orig\%n%.xml %n%.xml > nul
set ok=failed
patch < %n%.xml.patch && set ok=ok
echo patch result: %ok% (%n%.swf)
if exist %n%.xml.orig del %n%.xml.orig
if "%ok%" == "ok" (
  swfmill xml2swf %n%.xml %n%.swf
  del %n%.xml orig\%n%.xml
)
goto :EOF

:do_copy_file
echo copying file %1.swf
copy /Y orig\%1.swf %1.swf > nul
goto :EOF
