@echo off

set patch_swfs=battle.swf Minimap.swf PlayersPanel.swf
set patch_swfs=%patch_swfs% StatisticForm.swf TeamBasesPanel.swf VehicleMarkersManager.swf

rem Patch SWFs
for %%i in (%patch_swfs%) do call :do_patch_swf %%~ni

goto :EOF

:do_patch_swf
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
