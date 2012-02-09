@echo off

set VER=0.7.1

diff -u battle-%VER%.xml battle.xml > battle.xml.patch
diff -u battleloading-%VER%.xml battleloading.xml > battleloading.xml.patch
diff -u PlayersPanel-%VER%.xml PlayersPanel.xml > PlayersPanel.xml.patch
diff -u StatisticForm-%VER%.xml StatisticForm.xml > StatisticForm.xml.patch
