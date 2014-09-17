#!/bin/sh

if [ "$OS" = "Windows_NT" ]; then
    export PATH=$(pwd):$PATH
fi

echo "Updating icons of all clans..."
cd scripts-allclans

echo "Updating KR"
. update-kr.sh
echo "Updating ASIA"
. update-asia.sh
echo "Updating NA"
. update-na.sh
echo "Updating EU"
. update-eu.sh
echo "Updating RU"
. update-ru.sh

cd ..
echo "Icons of all clans updated"
