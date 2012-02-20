#!/bin/sh

cd $(dirname $(realpath $(cygpath --unix $0)))

./deploy.sh

[ "$WOT_DIRECTORY" = "" ] && WOT_DIRECTORY=/cygdrive/d/home/games/WoT
CURRENT_DIRECTORY=`pwd`
#SAMPLE_REPLAY=1.wotreplay
SAMPLE_REPLAY=blowup.wotreplay
#SAMPLE_REPLAY=tk.wotreplay
#SAMPLE_REPLAY=squad.wotreplay
cd ${WOT_DIRECTORY}
#cmd /c start ./WorldOfTanks.exe `cygpath --windows ${CURRENT_DIRECTORY}/../test/replays/${SAMPLE_REPLAY}`
cmd /c start ./wot-xvm-proxy.exe /debug `cygpath --windows ${CURRENT_DIRECTORY}/../test/replays/${SAMPLE_REPLAY}`
