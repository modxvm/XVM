#!/bin/sh

[ "$host" = "" ] && exit

# main
main()
{
  id=$startclan
  mkdir -p clanicons/$dir/clan
  while [ $id -le $lastclan ]; do
    update $id
    id=$((id+1))
  done
}

# update
# $1 - clanId
update()
{
  echo -n "$1 - "

  clan=`wget -q "http://$host/uc/clans/$1/" -O - 2>/dev/null | \
    grep "<title>" | \
    cut -d[ -f2 | \
    cut -d] -f1`
  if [ "$clan" = "" ]; then
    echo "EMPTY"
    return
  fi
  if [ "$clan" = "    <title>" ]; then
    echo "REMOVED"
    return
  fi

  echo -n "[$clan] => $clan.png"
  #wget -qc http://$host/dcont/clans/emblems/$1/emblem_64x64.png -O clanicons/$dir/clan/$clan.png 2>/dev/null
  wget -qc http://cw.$host/media/clans/emblems/clans_${1:0:1}/$1/emblem_64x64.png -O clanicons/$dir/clan/$clan.png 2>/dev/null

  echo " OK"
}
