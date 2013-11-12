#!/bin/sh

[ "$host" = "" ] && exit

# main
main()
{
  id=$startclan
  mkdir -p ../icons/$dir/res_mods/xvm/res/clanicons/$dir/clan
  echo "Started at `date +%T_%F`"
  while [ $id -le $lastclan ]; do
    update $id
    id=$((id+1))
  done
  optimize
  echo "Finished at `date +%T_%F`"
}

# update
# $1 - clanId
update()
{
  echo -n "$1 - "

  errors=0
  while [ 1 ]; do
    clan=`wget -qc -t 5 -T 10s "http://$host/community/clans/$1/" -O - 2>/dev/null | \
          grep "<title>" | \
          cut -d[ -f2 | \
          cut -d] -f1`

#Clan removed or does not exist
    if [ "$clan" = "    <title>" ]; then
      echo "REMOVED"
      return
#Error handling - server maintenance
    elif [ "$clan" = "" ]; then
      errors=$((errors+1))
      if [ $errors -lt 2 ]; then
        echo -n "EMPTY `date +%T_%F` $errors.. "
        sleep 10m
        continue
      elif [ $errors -lt 6 ]; then
        echo -n "$errors.. "
        sleep 10m
        continue
      else
        echo "ERROR"
        return
      fi
    fi
    break
  done

  echo -n "[$clan] => $clan.png"
  wget -qc -t 5 -T 10s http://clans.$host/media/clans/emblems/clans_${1:0:1}/$1/emblem_64x64.png \
       -O ../icons/$dir/res_mods/xvm/res/clanicons/$dir/clan/$clan.png 2>/dev/null

  echo " OK"
}

optimize()
{
  echo "Optimizing PNGs..."
  (
    cd ../icons/$dir/res_mods/xvm/res/clanicons/$dir/clan
    pngoptimizer -file:*.png
  )
}