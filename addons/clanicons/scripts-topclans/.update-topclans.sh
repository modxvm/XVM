#!/bin/bash

[ "$host" = "" ] && exit

tmpfn=".top.$host.html.~"

get()
{
  echo "Loading ratings page..."
  rm -f "$tmpfn"
  wget -qc "$url" -O "$tmpfn"
}

parse_ivanerr()
{
  echo "Searching new top clans..."
  eflg=0
  i=0
  cat "$tmpfn" | grep -E "^\s+<td><a " | while read line; do
    clan=`echo $line | cut -d\> -f3 | cut -d\< -f1`
    id=`echo $line | cut -d/ -f4 | cut -d\" -f1`
    l="$clan $id"

    i=$((i+1))
    [ $i -gt $top_count ] && return

    if ! grep -E "^$l\$" $topfile $topfile_persist > /dev/null; then
      [ $eflg -eq 1 ] && echo
      eflg=0
      echo "$i: $l"
      echo "$l" >> $topfile
    else
      eflg=1
      echo -n .
      [ "$((i%10))" -eq 0 ] && echo -n $i
    fi
  done
  echo
}

parse_null()
{
  echo "Searching clans ids..."
  rm -f "$tmpfn"
  i=0
  cat $topfile $topfile_persist | while read line; do
    i=$((i+1))
    clan=`echo $line | cut -d' ' -f1`
    id=`echo "$line " | cut -d' ' -f2`

    [ "$((i%10))" -eq 0 ] && echo -n "$i "
    if [ "$id" = "" ]; then
      echo
      echo -n "$clan "
      args="type=table&offset=0&limit=100&search=$clan"
      id=`wget -qc "http://${host}/community/clans/?$args" -O - \
        --header="X-Requested-With: XMLHttpRequest" \
        --header="X-CSRFToken: e5966ca14a5e9c11961483fd636d548d" \
        --header="Referer: http://${host}/community/clans/" | \
        sed 's/"abbreviation": /\n/g' | grep -- "\"$clan\"" | \
        sed 's/.*"id": //g' | cut -d, -f1`
      echo $id
    fi
    echo "$clan $id" >> "$tmpfn"
  done

  mv -f "$tmpfn" $topfile
  echo
}

sort_topfile()
{
  echo "Sorting..."
  cat $topfile | sort | uniq > $topfile
}

update()
{
  echo "Updating icons..."
  rm -f ../../../release/res/clanicons/$dir/clan/*
  i=0
  cat $topfile $topfile_persist | while read line; do
    i=$((i+1))
    clan=`echo $line | cut -d' ' -f1`
    id=`echo $line | cut -d' ' -f2`
    echo "$i: $clan $id"
    wget -qc http://clans.$host/media/clans/emblems/clans_${id:0:1}/$id/emblem_64x64.png -O ../../../release/res/clanicons/$dir/clan/$clan.png 2>/dev/null
  done
}

optimize_pngoptimizer()
{
  echo "Optimizing PNGs..."
  (
    cd ../../../release/res/clanicons/$dir/clan
    pngoptimizer -file:*.png
  )
}

#############
# main

[ "$url" != "" ] && get
parse_$parser
sort_topfile
update
if [ "$OS" = "Windows_NT" ]; then
    optimize_pngoptimizer
fi
rm -f "$tmpfn"
