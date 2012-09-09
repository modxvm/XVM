@echo off

set swfs=battle.swf battleloading.swf PlayersPanel.swf StatisticForm.swf VehicleMarkersManager.swf

for %%i in (%swfs%) do call :do_file %%~ni

goto :EOF

:do_file
set n=%1
swfmill swf2xml orig\%n%.swf orig\%n%.xml
copy /Y orig\%n%.xml %n%.xml > nul
patch < %n%.xml.patch && del %n%.xml orig\%n%.xml
del %n%.xml.orig
swfmill xml2swf %n%.xml %n%.swf
goto :EOF
