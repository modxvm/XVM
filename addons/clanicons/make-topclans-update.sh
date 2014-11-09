#!/bin/bash

if [ "$OS" = "Windows_NT" ]; then
    export PATH=$(pwd):$PATH
fi

echo "Updating icons of top clans..."
cd scripts-topclans

echo "Updating RU"
. ./update-topclans-ru.sh
echo "Updating EU"
. ./update-topclans-eu.sh
echo "Updating NA"
. ./update-topclans-na.sh
echo "Updating ASIA"
. ./update-topclans-asia.sh
echo "Updating KR"
. ./update-topclans-kr.sh

cd ..
echo "Icons of top clans updated"
