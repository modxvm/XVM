#!/bin/bash

# XVM team (c) www.modxvm.com 2014-2015
# XVM nightly build system

patch_swfs="
    battle.swf
    PlayersPanel.swf
    StatisticForm.swf
    TeamBasesPanel.swf
    VehicleMarkersManager.swf
"

for swf in $patch_swfs; do
    swf=${swf%.*}
    if [ ! -f ${swf}.xml ]; then
      echo ${swf}.swf
      java -jar ../../../build/bin/java/ffdec.jar -swf2xml orig/${swf}.swf orig/${swf}.xml
      java -jar ../../../build/bin/java/ffdec.jar -swf2xml ${swf}.swf ${swf}.xml
      diff -u2 orig/${swf}.xml ${swf}.xml > ${swf}.xml.patch
      rm orig/${swf}.xml ${swf}.xml
    fi
done
