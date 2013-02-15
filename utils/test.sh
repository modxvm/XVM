#!/bin/sh

cd $(dirname $(realpath $(cygpath --unix $0)))

./deploy.sh

[ "$WOT_DIRECTORY" = "" ] && WOT_DIRECTORY=/cygdrive/d/work/games/WoT-CT
CURRENT_DIRECTORY=`pwd`

#SAMPLE_REPLAY=observer.wotreplay
#SAMPLE_REPLAY=teff.wotreplay
#SAMPLE_REPLAY=teff2.wotreplay
#SAMPLE_REPLAY=violet.wotreplay
SAMPLE_REPLAY=markers.wotreplay
#SAMPLE_REPLAY=test.wotreplay

cd "${WOT_DIRECTORY}"
REPLAY=${CURRENT_DIRECTORY}/../test/replays/${SAMPLE_REPLAY}
#cmd /c start ./WorldOfTanks.exe `cygpath --windows $REPLAY`
cmd /c start ./xvm-stat.exe `cygpath --windows $REPLAY` &
#cmd /c start ./xvm-stat.exe /server=CT `cygpath --windows $REPLAY` &
#cmd /c start PsExec.exe -d -a 2 ./xvm-stat.exe `cygpath --windows $REPLAY` &
