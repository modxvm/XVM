@echo off

set WOT=D:\home\games\WoT

copy /Y login.swf %WOT%\res_mods\0.8.1\gui\flash\login.swf
cd %WOT%
rem start WorldOfTanks.exe
start xvm-stat.exe
