#!/bin/sh

[ "$GAME_VER" = "" ] && GAME_VER="0.8.5"
#[ "$GAME_VER" = "" ] && GAME_VER="0.8.5 Common Test"
[ "$WOT_DIRECTORY" = "" ] && WOT_DIRECTORY=/cygdrive/d/work/games/WoT

FILES="
  xvm.swf
  battle.swf
  battleloading.swf
  crew.swf
  FinalStatistic.swf
  lobby_messenger.swf
  Minimap.swf
  PlayersPanel.swf
  SquadMemberRenderer.swf
  StatisticForm.swf
  TeamBasesPanel.swf
  TeamMemberRenderer.swf
  TeamRenderer.swf
  UserInfo.swf
  VehicleMarkersManager.swf
  XVM.xvmconf"

DIRS="xvm"

cd $(dirname $(realpath $(cygpath --unix $0)))

RES_MODS_DIR="$WOT_DIRECTORY/res_mods"
SWF_DIR="$RES_MODS_DIR/$GAME_VER/gui/flash"

mkdir -p "$SWF_DIR"

copy_file()
{
  [ -f "$SWF_DIR/$1" ] && rm -f "$SWF_DIR/$1"
  [ -f "../bin/$1" ] && {
    echo "=> $1"
    cp -p "../bin/$1" "$SWF_DIR/${1##*/}"
  }
}

copy_dir()
{
  [ -e "$RES_MODS_DIR/$1" ] && rm -rf "$RES_MODS_DIR/$1"
  [ -d "../bin/$1" ] && {
    echo "=> $1"
    cp -rp "../bin/$1" "$RES_MODS_DIR"
  }
}

for n in $FILES; do
  copy_file $n
done

for n in $DIRS; do
  copy_dir $n
done
