#!/bin/sh

echo "Updating icons of top clans..."
cd scripts-topclans

echo "Updating RU"
update-topclans-ru.sh
echo "Updating EU"
update-topclans-eu.sh
echo "Updating US"
update-topclans-us.sh

echo "Icons of top clans updated"
