@echo off

set swfs=battle.swf battleloading.swf PlayersPanel.swf StatisticForm.swf VehicleMarkersManager.swf

for %%i in (%swfs%) do call :do_file %%~ni

goto :EOF

:do_file
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
