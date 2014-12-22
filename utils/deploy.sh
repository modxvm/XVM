#!/bin/sh

# TODO - refactor

[ "$WOT_DIRECTORY" = "" ] && WOT_DIRECTORY=/cygdrive/d/work/games/WoT

###

[ "$GAME_VER" = "" ] && GAME_VER=$(<../build/target_version)
GAME_VER=`echo $GAME_VER | tr -d '\n\r'`

FILES_FLASH="
  Application.swf
"

FILES_SCALEFORM="
  battle.swf
  Minimap.swf
  PlayersPanel.swf
  StatisticForm.swf
  TeamBasesPanel.swf
  VehicleMarkersManager.swf
  xvm.swf"

CUSTOM_TESTER_FILES="configs/xvm.xc"
XVM_DIRS="configs mods l10n res/icons"
XVM_FILES=""

cd $(dirname $(realpath $(cygpath --unix $0)))

RES_MODS_DIR="$WOT_DIRECTORY/res_mods"
SWF_DIR="$RES_MODS_DIR/$GAME_VER/gui"

mkdir -p "$RES_MODS_DIR/xvm/res"

copy_file_flash()
{
  [ -f "$SWF_DIR/flash/$1" ] && rm -f "$SWF_DIR/flash/$1"
  [ -f "../src/xvm/swf/$1" ] && {
    echo "=> $1"
    mkdir -p "$SWF_DIR/flash"
    cp -p "../src/xvm/swf/$1" "$SWF_DIR/flash/${1##*/}"
  }
}

copy_file_scaleform()
{
  [ -f "$SWF_DIR/scaleform/$1" ] && rm -f "$SWF_DIR/scaleform/$1"
  [ -f "../bin/$1" ] && {
    echo "=> $1"
    mkdir -p "$SWF_DIR/scaleform"
    cp -p "../bin/$1" "$SWF_DIR/scaleform/${1##*/}"
  }
}

copy_custom_tester_files()
{
  [ -f "$RES_MODS_DIR/xvm/$1" ] && rm -f "$RES_MODS_DIR/xvm/$1"
  [ -f "../bin/$1" ] && {
    echo "=> $1"
    cp -p "../bin/$1" "$RES_MODS_DIR/xvm/$1"
  }
}

copy_xvm_dir()
{
  [ -e "$RES_MODS_DIR/xvm/$1" ] && rm -rf "$RES_MODS_DIR/xvm/$1"
  [ -d "../release/$1" ] && {
    echo "=> $1"
    cp -rp "../release/$1" "$RES_MODS_DIR/xvm/$1"
  }
}

copy_xvm_file()
{
  [ -f "$RES_MODS_DIR/xvm/$1" ] && rm -f "$RES_MODS_DIR/xvm/$1"
  [ -f "../release/$1" ] && {
    echo "=> $1"
    cp -p "../release/$1" "$RES_MODS_DIR/xvm/$1"
  }
}

for n in $FILES_FLASH; do
  copy_file_flash $n
done

for n in $FILES_SCALEFORM; do
  copy_file_scaleform $n
done

for n in $XVM_DIRS; do
  copy_xvm_dir $n
done

for n in $XVM_FILES; do
  copy_xvm_file $n
done

if [ "$KEEP_OLD_CUSTOM_FILES" = "" ]; then
  for n in $CUSTOM_TESTER_FILES; do
    copy_custom_tester_files $n
  done
fi
