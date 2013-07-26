#!/bin/bash

files=(
        'battle'
        'battleloading'
        'crew'
        'FinalStatistic'
        'gameloading'
        'LangBarPanel'
        'Minimap'
        'PlayersPanel'
        'StatisticForm'
        'VehicleMarkersManager'
        'SquadMemberRenderer'
        'TeamBasesPanel'
        'TeamMemberRenderer'
        'TeamRenderer'
        'UserInfo'
       )
mkdir temp

for (( i=0; i<${#files[@]}; i++ ));
  do
    swfmill swf2xml orig/${files[$i]}.swf temp/${files[$i]}.xml
    patch temp/${files[$i]}.xml ${files[$i]}.xml.patch
    swfmill xml2swf temp/${files[$i]}.xml ${files[$i]}.swf
  done

rm -f *.xml.orig
cp -f temp/*.rej . 2>/dev/null
rm -rf temp
