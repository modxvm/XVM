@echo off

set patch_swfs=battleloading.swf PlayersPanel.swf StatisticForm.swf FinalStatistic.swf
set patch_swfs=%patch_swfs% battle.swf TeamBasesPanel.swf Minimap.swf VehicleMarkersManager.swf
set patch_swfs=%patch_swfs% SquadMemberRenderer.swf TeamMemberRenderer.swf TeamRenderer.swf
set patch_swfs=%patch_swfs% UserInfo.swf lobby_messenger.swf crew.swf

for %%i in (%patch_swfs%) do call :do_file %%~ni

goto :EOF

:do_file
set n=%1
if not exist %n%.xml (
  echo %n%.swf
  swfmill swf2xml orig\%n%.swf orig\%n%.xml
  swfmill swf2xml %n%.swf %n%.xml
  diff -u -I "<StackDouble value=" orig\%n%.xml %n%.xml > %n%.xml.patch
  del orig\%n%.xml %n%.xml
)
goto :EOF
