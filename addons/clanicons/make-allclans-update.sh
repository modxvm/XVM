#!/bin/sh

echo "Updating icons of all clans..."
cd scripts-allclans

echo "Updating VN"
. update-vn.sh
echo "Updating KR"
. update-kr.sh
echo "Updating SG"
. update-sg.sh
echo "Updating NA"
. update-na.sh
echo "Updating EU"
. update-eu.sh
echo "Updating RU"
. update-ru.sh

cd ..
echo "Icons of all clans updated"
