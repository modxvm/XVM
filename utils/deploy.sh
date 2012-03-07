#!/bin/sh

GAME_VER=0.7.1.1

cd $(dirname $(realpath $(cygpath --unix $0)))

[ "$WOT_DIRECTORY" = "" ] && WOT_DIRECTORY=/cygdrive/d/home/games/WoT
SWF_DIR=$WOT_DIRECTORY/res_mods/$GAME_VER/gui/flash
[ -f "../bin/*.swf" ] && cp ../bin/*.swf $SWF_DIR
[ -f "../bin/XVM.xvmconf" ] && cp ../bin/XVM.xvmconf $SWF_DIR/XVM.xvmconf
[ -f "../bin/OTMData.xml" ] && cp ../bin/OTMData.xml $SWF_DIR/OTMData.xml
