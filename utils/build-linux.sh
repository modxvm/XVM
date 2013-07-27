#!/bin/bash

projects=(
        'battle'
        'battleloading'
        'crew'
        'FinalStatistic'
        'gameloading'
        'LangBarPanel'
        'Minimap'
        'PlayersPanel'
        'SquadMemberRenderer'
        'StatisticForm'
        'TeamBasesPanel'
        'TeamMemberRenderer'
        'TeamRenderer'
	'UserInfo'
        'VehicleMarkersManager'
        'xvm'
       )
pushd ../src/xvm/include && ./gen-include.sh 
popd
pushd ../src/xvm/swf     && ./1.make-patched-swfs.sh 
popd

pushd ../src/xvm

for (( i=0; i<${#projects[@]}; i++ ));
  do
    mono ../../addons/build-linux/fdbuild.exe ${projects[$i]}.as2proj -version "1.14" -notrace
  done

popd
