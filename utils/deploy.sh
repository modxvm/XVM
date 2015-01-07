#!/bin/sh

#############################
# CONFIG

XVM_DIRS="res/icons"
XVM_FILES="l10n/en.xc l10n/ru.xc"

#############################
# INTERNAL

err()
{
  echo "ERROR: $*"
  exit 1
}

check_config()
{
  [ "$WOT_PATH" != "" ] || err "WOT_PATH is not set in the build/xvm-build.conf"
  [ -d "$WOT_PATH" ] || err "WOT_PATH is invalid in the build/xvm-build.conf\n  WOT_PATH=$WOT_PATH"
  [ "$TARGET_VERSION" != "" ] || err "TARGET_VERSION is not set in the build/xvm-build.conf"
  [ -d "$WOT_PATH/res_mods/$TARGET_VERSION" ] || {
    err "TARGET_VERSION is invalid in the build/xvm-build.conf\n  TARGET_VERSION=$TARGET_VERSION"
  }
}

clear()
{
  rm -rf "$WOT_PATH/res_mods/mods/packages" || err "clear"
  rm -rf "$WOT_PATH/res_mods/mods/xfw" || err "clear"
  rm -rf "$WOT_PATH/res_mods/$TARGET_VERSION/gui/flash" || err "clear"
  rm -rf "$WOT_PATH/res_mods/$TARGET_VERSION/gui/scaleform" || err "clear"
  rm -rf "$WOT_PATH/res_mods/$TARGET_VERSION/scripts/client/gui/scaleform/locale" || err "clear"
}

make_dirs()
{
  mkdir -p "$WOT_PATH/res_mods/configs" || err "make_dirs"
  mkdir -p "$WOT_PATH/res_mods/mods" || err "make_dirs"
  mkdir -p "$WOT_PATH/res_mods/$TARGET_VERSION" || err "make_dirs"
}

copy_output()
{
  echo "=> res_mods/$TARGET_VERSION"
  cp -a ../~output/~ver/* "$WOT_PATH/res_mods/$TARGET_VERSION" || err "copy_output"

  echo "=> res_mods/mods"
  cp -a ../~output/mods/* "$WOT_PATH/res_mods/mods" || err "copy_output"
}

copy_configs()
{
  echo "=> res_mods/configs"
  cp -a ../release/configs/* "$WOT_PATH/res_mods/configs" || err "copy_configs"

  echo "=> res_mods/configs/xvm.xc"
  if [ -f "test/configs/xvm.xc" ]; then
    cp -a "test/configs/xvm.xc" "$WOT_PATH/res_mods/configs/xvm.xc" || err "copy_configs"
  else
    rm -f "$WOT_PATH/res_mods/configs/xvm.xc" || err "copy_configs"
  fi
}

copy_xvm_dir()
{
  [ -e "$SHARED_RESOURCES_PATH/$1" ] && rm -rf "$SHARED_RESOURCES_PATH/$1"
  [ -d "../release/$1" ] && {
    echo "=> $1"
    mkdir -p $(dirname "$SHARED_RESOURCES_PATH/$1") || err "copy_xvm_dir"
    cp -a "../release/$1" "$SHARED_RESOURCES_PATH/$1" || err "copy_xvm_dir"
  }
}

copy_xvm_file()
{
  [ -f "$SHARED_RESOURCES_PATH/$1" ] && rm -f "$SHARED_RESOURCES_PATH/$1"
  [ -f "../release/$1" ] && {
    echo "=> $1"
    mkdir -p $(dirname "$SHARED_RESOURCES_PATH/$1") || err "copy_xvm_file"
    cp -a "../release/$1" "$SHARED_RESOURCES_PATH/$1" || err "copy_xvm_file"
  }
}

# MAIN

cd $(dirname $0)

# load config
. ../build/xvm-build.conf

SHARED_RESOURCES_PATH=$WOT_PATH/res_mods/mods/shared_resources

# check config
check_config

# deploy
clear

make_dirs

copy_output

copy_configs

for n in $XVM_DIRS; do
  copy_xvm_dir $n
done

for n in $XVM_FILES; do
  copy_xvm_file $n
done
