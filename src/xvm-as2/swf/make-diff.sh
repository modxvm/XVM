#!/bin/bash

# XVM team (c) www.modxvm.com 2014-2016
# XVM nightly build system

patch_swfs="
    battle.swf
    Minimap.swf
    PlayersPanel.swf
    StatisticForm.swf
    TeamBasesPanel.swf
    VehicleMarkersManager.swf
"

currentdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$currentdir"
source ../../../build/library.sh

extend_path()
{
  PATH="$currentdir"/../../../build/bin/"$OS"_"$arch"/:$PATH
}

make_diff_as2(){
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
}

detect_os
detect_arch
extend_path
detect_swfmill

make_diff_as2