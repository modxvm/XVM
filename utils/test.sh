#!/bin/sh

cd $(dirname $(realpath $(cygpath --unix $0)))

./deploy.sh

[ "$WOT_DIRECTORY" = "" ] && WOT_DIRECTORY=/cygdrive/d/home/games/WoT
CURRENT_DIRECTORY=`pwd`

#SAMPLE_REPLAY=squad_tk.wotreplay
#SAMPLE_REPLAY=6thsence.wotreplay
SAMPLE_REPLAY=fireAt_10-30.wotreplay
#-SAMPLE_REPLAY=bk.wotreplay
#-SAMPLE_REPLAY=7x7.wotreplay
#-SAMPLE_REPLAY=fogofwar.wotreplay
#-SAMPLE_REPLAY=markers.wotreplay
#-SAMPLE_REPLAY=test.wotreplay

cd "${WOT_DIRECTORY}"
REPLAY=${CURRENT_DIRECTORY}/../test/replays/${SAMPLE_REPLAY}
#cmd /c start ./WorldOfTanks.exe `cygpath --windows $REPLAY`
cmd /c start ./xvm-stat.exe `cygpath --windows $REPLAY` &
#cmd /c start ./xvm-stat.exe /server=CT `cygpath --windows $REPLAY` &
#cmd /c start PsExec.exe -d -a 2 ./xvm-stat.exe `cygpath --windows $REPLAY` &
