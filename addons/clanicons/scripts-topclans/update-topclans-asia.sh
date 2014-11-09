#!/bin/bash

parser=ivanerr
url="http://wotclans.net/asia/showclansrating/"
host=worldoftanks.asia
dir=ASIA
top_count=150
topfile=topclans-asia.txt
topfile_persist=topclans-asia.persist.txt

# Cleaning top clans file
echo -n > $topfile

. ./.update-topclans.sh
