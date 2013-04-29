#!/bin/sh

url="http://ivanerr.ru/lt/showclansrating/"
host=worldoftanks.ru
dir=RU
top_count=150
topfile=topclans-ru.txt
topfile_persist=topclans-ru.persist.txt

# Cleaning top clans file
echo -n > $topfile

. .update-topclans.sh
