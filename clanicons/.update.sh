#!/bin/sh

[ "$host" = "" ] && exit

# main
main()
{
  i=$startclan
  while [ $i -le $lastclan ]; do
    update $i
    i=$((i+1))
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
    return;
  fi
  if [ "$clan" = "<title>" ]; then
    echo "REMOVED"
    return;
  fi

  echo -n "[$clan] => $clan.png"
  wget -qc http://$host/dcont/clans/emblems/$1/emblem_64x64.png -O all/res_mods/clanicons/$dir/clan/$clan.png 2>/dev/null

  if grep -E "^$clan\$" $topfile > /dev/null; then
    echo -n " (top)"
    cp -f all/res_mods/clanicons/$dir/clan/$clan.png top/res_mods/clanicons/$dir/clan/$clan.png
  fi

  echo
}
