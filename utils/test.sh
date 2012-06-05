#!/bin/sh

cd $(dirname $(realpath $(cygpath --unix $0)))

./deploy.sh

[ "$WOT_DIRECTORY" = "" ] && WOT_DIRECTORY=/cygdrive/d/home/games/WoT-test
CURRENT_DIRECTORY=`pwd`

#SAMPLE_REPLAY=squad.wotreplay
#SAMPLE_REPLAY=tk.wotreplay
#SAMPLE_REPLAY=bk.wotreplay
#SAMPLE_REPLAY=7x7.wotreplay
#SAMPLE_REPLAY=fogofwar.wotreplay
SAMPLE_REPLAY=markers.wotreplay
#SAMPLE_REPLAY=test.wotreplay

cd ${WOT_DIRECTORY}
REPLAY=${CURRENT_DIRECTORY}/../test/replays/${SAMPLE_REPLAY}
#cmd /c start ./WorldOfTanks.exe `cygpath --windows $REPLAY`
cmd /c start ./wot-xvm-proxy.exe `cygpath --windows $REPLAY` &
#cmd /c start ./wot-xvm-proxy.exe /debug `cygpath --windows $REPLAY`
#cmd /c start PsExec.exe -d -a 0 ./wot-xvm-proxy.exe `cygpath --windows $REPLAY` &
