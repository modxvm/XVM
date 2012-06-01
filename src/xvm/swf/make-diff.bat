@echo off

diff -u orig\battle.xml battle.xml > battle.xml.patch
diff -u orig\battleloading.xml battleloading.xml > battleloading.xml.patch
diff -u orig\PlayersPanel.xml PlayersPanel.xml > PlayersPanel.xml.patch
diff -u orig\StatisticForm.xml StatisticForm.xml > StatisticForm.xml.patch
rem diff -u orig\FinalStatisticForm.xml FinalStatisticForm.xml > FinalStatisticForm.xml.patch
::diff -u orig\VehicleMarkersManager.xml VehicleMarkersManager.xml > VehicleMarkersManager.xml.patch
