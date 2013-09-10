#!/bin/bash

#XVM .swf builder for Linux
#Part of XVM build system
#Do not change anything in this file if you are not sure

projects=(
        'battle'
        'Minimap'
        'PlayersPanel'
        'StatisticForm'
        'TeamBasesPanel'
        'VehicleMarkersManager'
        'xvm'
       )

pushd ../../../src/xvm-as2/ > /dev/null
PATH=$PATH:../../utils/build-system-linux/bin/

for (( i=0; i<${#projects[@]}; i++ ));
  do
    mono ../../utils/build-system-linux/bin/fdbuild.exe ${projects[$i]}.as2proj -version "1.14" -notrace
    rm -f swf/${projects[$i]}.swf
  done
rm -rf include
popd > /dev/null
