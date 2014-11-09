#!/bin/bash

parser=ivanerr
url="http://wotclans.net/kr/showclansrating/"
host=worldoftanks.kr
dir=KR
top_count=50
topfile=topclans-kr.txt
topfile_persist=topclans-kr.persist.txt

# Cleaning top clans file
echo -n > $topfile

. ./.update-topclans.sh
