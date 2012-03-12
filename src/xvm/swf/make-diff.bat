@echo off

set VER=0.7.2-test1

diff -u battle-%VER%.xml battle.xml > battle.xml.patch
diff -u battleloading-%VER%.xml battleloading.xml > battleloading.xml.patch
diff -u PlayersPanel-%VER%.xml PlayersPanel.xml > PlayersPanel.xml.patch
rem diff -u StatisticForm-%VER%.xml StatisticForm.xml > StatisticForm.xml.patch
diff -u VehicleMarkersManager-%VER%.xml VehicleMarkersManager.xml > VehicleMarkersManager.xml.patch
