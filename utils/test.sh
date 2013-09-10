#!/bin/sh

cd $(dirname $(realpath $(cygpath --unix $0)))

no_deploy=0
while [ ! -z "$1" ]; do
    if [ "$1" = "--no-deploy" ]; then
      no_deploy=1
    fi
    shift
done

[ "$no_deploy" = "0" ] && ./deploy.sh

[ "$WOT_DIRECTORY" = "" ] && WOT_DIRECTORY=/cygdrive/d/work/games/WoT
CURRENT_DIRECTORY=`pwd`

#SAMPLE_REPLAY=test.wotreplay
#SAMPLE_REPLAY=blowup.wotreplay
#SAMPLE_REPLAY=squad.wotreplay
#SAMPLE_REPLAY=assault.wotreplay
#SAMPLE_REPLAY=domination.wotreplay
#SAMPLE_REPLAY=tk.wotreplay
#SAMPLE_REPLAY=markers.wotreplay
#SAMPLE_REPLAY=ramming.wotreplay
#SAMPLE_REPLAY=train.wotreplay

cd "${WOT_DIRECTORY}"
REPLAY=${CURRENT_DIRECTORY}/../utils/replays/${SAMPLE_REPLAY}
cmd /c start ./WorldOfTanks.exe `cygpath --windows $REPLAY`
#cmd /c start ./xvm-stat.exe `cygpath --windows $REPLAY` &
#cmd /c start ./xvm-stat.exe /server=CT `cygpath --windows $REPLAY` &
#cmd /c start ./xvm-stat.exe /debug `cygpath --windows $REPLAY` &
