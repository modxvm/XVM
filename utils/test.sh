#!/bin/sh

#############################
# CONFIG

#SAMPLE_REPLAY=test.wotreplay
#SAMPLE_REPLAY=test1.wotreplay
#SAMPLE_REPLAY=test2.wotreplay
#SAMPLE_REPLAY=test3.wotreplay
#SAMPLE_REPLAY=cw.wotreplay
#SAMPLE_REPLAY=tk.wotreplay

#############################
# INTERNAL

#no_deploy=0
#while [ ! -z "$1" ]; do
#    if [ "$1" = "--no-deploy" ]; then
#      no_deploy=1
#    fi
#    shift
#done
#
#[ "$no_deploy" = "0" ] && ./deploy.sh

pushd $(dirname $(realpath $(cygpath --unix $0))) >/dev/null

. ./deploy.sh || exit 1

[ "$SAMPLE_REPLAY" != "" ] && REPLAY=$(cygpath --windows $PWD/replays/$SAMPLE_REPLAY)

pushd "$WOT_PATH" >/dev/null
cmd /c start ./WorldOfTanks.exe $REPLAY
popd >/dev/null

popd >/dev/null
