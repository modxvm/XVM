#!/bin/bash

#XVM .swf patcher for Linux
#Part of XVM build system
#Do not change anything in this file if you are not sure

files=(
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
       )

pushd ../../../src/xvm/swf/
mkdir temp

for (( i=0; i<${#files[@]}; i++ ));
  do
    swfmill swf2xml orig/${files[$i]}.swf temp/${files[$i]}.xml
    patch temp/${files[$i]}.xml ${files[$i]}.xml.patch
    swfmill xml2swf temp/${files[$i]}.xml ${files[$i]}.swf
  done

rm -f *.xml.orig
cp -f temp/*.rej . 2>/dev/null
rm -rf temp/
