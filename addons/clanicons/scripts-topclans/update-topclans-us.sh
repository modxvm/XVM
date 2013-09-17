#!/bin/sh

parser=ivanerr
url="http://wotclans.net/na/showclansrating/"
host=worldoftanks.com
dir=US
top_count=150
topfile=topclans-us.txt
topfile_persist=topclans-us.persist.txt

# Cleaning top clans file
echo -n > $topfile

. .update-topclans.sh
