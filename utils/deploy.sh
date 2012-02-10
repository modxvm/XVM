#!/bin/sh

cd $(dirname $(realpath $0))

[ "$WOT_DIRECTORY" = "" ] && WOT_DIRECTORY=/cygdrive/d/home/games/WoT
WOT_DIRECTORY=/cygdrive/d/home/games/WoT
cp ../bin/*.swf ${WOT_DIRECTORY}/res/gui/flash
cp ../bin/XVM.xvmconf ${WOT_DIRECTORY}/res/gui/flash/XVM.xvmconf
cp ../bin/OTMData.xml ${WOT_DIRECTORY}/res/gui/flash/OTMData.xml
