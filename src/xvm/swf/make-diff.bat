@echo off

set swfs=battle.swf battleloading.swf PlayersPanel.swf StatisticForm.swf VehicleMarkersManager.swf

for %%i in (%swfs%) do call :do_file %%~ni

goto :EOF

:do_file
set n=%1
if exist %n%.xml. (
  diff -u orig\%n%.xml %n%.xml > %n%.xml.patch
)
goto :EOF
