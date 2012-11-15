@echo off

set copy_files=
set patch_swfs=battle.swf battleloading.swf PlayersPanel.swf StatisticForm.swf TeamBasesPanel.swf VehicleMarkersManager.swf Minimap.swf FinalStatistic.swf
set patch_xmls=gui_sounds_new.xml

rem Copy files without patching
for %%i in (%copy_files%) do call :do_copy_file %%i

rem Patch SWFs
for %%i in (%patch_swfs%) do call :do_patch_swf %%~ni

rem Patch XMLs
for %%i in (%patch_xmls%) do call :do_patch_xml %%~ni

goto :EOF

:do_copy_file
echo copying file %1
copy /Y orig\%1 %1 > nul
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

:do_patch_xml
set n=%1
copy /Y orig\%n%.xml %n%.xml > nul
set ok=failed
patch < %n%.xml.patch && set ok=ok
echo patch result: %ok% (%n%.xml)
if exist %n%.xml.orig del %n%.xml.orig
goto :EOF
