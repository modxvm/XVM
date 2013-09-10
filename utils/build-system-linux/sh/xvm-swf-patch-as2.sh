#!/bin/bash

#XVM .swf patcher for Linux
#Part of XVM build system
#Do not change anything in this file if you are not sure

files=(
        'battle'
        'Minimap'
        'PlayersPanel'
        'StatisticForm'
        'TeamBasesPanel'
        'VehicleMarkersManager'
       )

pushd ../../../src/xvm-as2/swf/ > /dev/null
mkdir -p temp

for (( i=0; i<${#files[@]}; i++ ));
  do
    swfmill swf2xml orig/${files[$i]}.swf temp/${files[$i]}.xml
    patch temp/${files[$i]}.xml ${files[$i]}.xml.patch
    swfmill xml2swf temp/${files[$i]}.xml ${files[$i]}.swf
  done

rm -rf temp/

popd > /dev/null
