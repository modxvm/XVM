#!/bin/bash

parser=ivanerr
url="http://wotclans.net/eu/showclansrating/"
host=worldoftanks.eu
dir=EU
top_count=150
topfile=topclans-eu.txt
topfile_persist=topclans-eu.persist.txt

# Cleaning top clans file
echo -n > $topfile

. ./.update-topclans.sh
