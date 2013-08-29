#!/bin/bash

#XVM .swf builder for Linux
#Part of XVM build system
#Do not change anything in this file if you are not sure

projects=(
        'battle'
        'battleloading'
        'Minimap'
        'PlayersPanel'
        'TeamBasesPanel'
        'VehicleMarkersManager'
        'xvm'
       )

pushd ../../../src/xvm/ > /dev/null
PATH=$PATH:../../utils/build-system-linux/bin/

for (( i=0; i<${#projects[@]}; i++ ));
  do
    mono ../../utils/build-system-linux/bin/fdbuild.exe ${projects[$i]}.as2proj -version "1.14" -notrace
  done

popd > /dev/null
