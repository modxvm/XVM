#!/bin/sh

url="http://ivanerr.ru/lt/showclansrating/"
tmpfn=".top-ru.html.~"

host=worldoftanks.ru
dir=RU
topfile=topclans-ru.txt

get()
{
  rm -f "$tmpfn"
  wget -qc "$url" -O "$tmpfn"
}

parse()
{
  echo "Searching new top clans..."
  i=0
  cat $1 | grep -E "^\s+<td><a " | while read line; do
    clan=`echo $line | cut -d\> -f3 | cut -d\< -f1`
    id=`echo $line | cut -d/ -f4 | cut -d\" -f1`
    l="$clan $id"

    i=$((i+1))
    if [ $i -gt 150 ]; then
      return
    fi

    if ! grep -E "^$l\$" $topfile > /dev/null; then
      echo
      echo "$i: $l"
      echo "$l" >> $topfile
    else
      echo -n .
      [ "$((i%10))" -eq 0 ] && echo -n $i
    fi
  done
  echo

  echo "Sorting..."
  cat $topfile | sort | uniq > $topfile

  echo "Updating icons..."
  rm -f top/res_mods/clanicons/$dir/clan/*
  i=0
  cat $topfile | while read line; do
    i=$((i+1))
    clan=`echo $line | cut -d' ' -f1`
    id=`echo $line | cut -d' ' -f2`
    echo "$i: $clan $id"
    wget -qc http://$host/dcont/clans/emblems/$id/emblem_64x64.png -O top/res_mods/clanicons/$dir/clan/$clan.png 2>/dev/null
  done
}

load()
{
  i=0
  cat cat topclans-ru.txt | while read line; do
    echo $line
  done
}

get
parse "$tmpfn"
rm -f "$tmpfn"
