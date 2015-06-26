#!/bin/bash

# XVM team (c) www.modxvm.com 2014-2015
# XVM nightly build system

patch_swfs="
    battle.swf
    Minimap.swf
    PlayersPanel.swf
    StatisticForm.swf
    TeamBasesPanel.swf
    VehicleMarkersManager.swf
"

for swf in $patch_swfs; do
    swf=${swf%.*}
    if [ ! -f ${swf}.xml ]; then
      echo ${swf}.swf
      swfmill swf2xml orig/${swf}.swf orig/${swf}.xml
      swfmill swf2xml ${swf}.swf ${swf}.xml
      diff -u2 -I "<StackDouble value=" orig/${swf}.xml ${swf}.xml > ${swf}.xml.patch
      rm orig/${swf}.xml ${swf}.xml
    fi
done
