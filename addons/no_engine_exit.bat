@echo off

rem Disable engine exit
rem Run from res_mods\0.7.x

rem Отключить выхлоп двигателя
rem Запускать из res_mods\0.7.x

if not exist particles\Tank mkdir particles\Tank
echo x >particles\Tank\engine_exit_diesel.xml
echo x >particles\Tank\engine_exit_gass.xml
