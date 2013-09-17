#!/bin/sh

echo "Updating icons of all clans..."
cd scripts-allclans

echo "Updating RU"
update-ru.sh
echo "Updating EU"
update-eu.sh
echo "Updating US"
update-us.sh
echo "Updating SEA"
update-sea.sh
echo "Updating KR"
update-kr.sh

echo "Icons of all clans updated"
