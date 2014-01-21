#!/bin/bash

echo "Updating icons of top clans..."
cd scripts-topclans

echo "Updating RU"
. ./update-topclans-ru.sh
echo "Updating EU"
. ./update-topclans-eu.sh
echo "Updating NA"
. ./update-topclans-na.sh

cd ..
echo "Icons of top clans updated"
