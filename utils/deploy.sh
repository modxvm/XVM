#!/bin/sh

GAME_VER="0.7.2 Common Test"

cd $(dirname $(realpath $(cygpath --unix $0)))

[ "$WOT_DIRECTORY" = "" ] && WOT_DIRECTORY=/cygdrive/d/home/games/WoT-test
SWF_DIR="$WOT_DIRECTORY/res_mods/$GAME_VER/gui/flash"
cp ../bin/*.swf "$SWF_DIR" 2>/dev/null
[ -f "$SWF_DIR/XVM.xvmconf" ] && rm -f "$SWF_DIR/XVM.xvmconf"
[ -f "../bin/XVM.xvmconf" ] && cp ../bin/XVM.xvmconf "$SWF_DIR/XVM.xvmconf"
[ -f "$SWF_DIR/OTMData.xml" ] && rm -f "$SWF_DIR/OTMData.xml"
[ -f "../bin/OTMData.xml" ] && cp ../bin/OTMData.xml "$SWF_DIR/OTMData.xml"
