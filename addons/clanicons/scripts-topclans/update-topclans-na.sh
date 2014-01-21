#!/bin/bash

parser=ivanerr
url="http://wotclans.net/na/showclansrating/"
host=worldoftanks.com
dir=NA
top_count=150
topfile=topclans-na.txt
topfile_persist=topclans-na.persist.txt

# Cleaning top clans file
echo -n > $topfile

. ./.update-topclans.sh
