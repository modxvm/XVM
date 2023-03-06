#!/bin/bash

#############################
# CONFIG

XVM_DIRS="res/icons res/locker audioww"
XVM_FILES="l10n/en.xc l10n/ru.xc"
XVMBUILD_FLAVOR="wg"

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
  [ -d "$WOT_PATH" ] || err "WOT_PATH is invalid in the build/xvm-build.conf  WOT_PATH=$WOT_PATH"
  [ "$XVMBUILD_WOT_VERSION" != "" ] || err "XVMBUILD_WOT_VERSION is not set in the build/xvm-build.conf"
  [ -d "$WOT_PATH/mods/$XVMBUILD_WOT_VERSION" -a -d "$WOT_PATH/res_mods/$XVMBUILD_WOT_VERSION" ] || {
    err "XVMBUILD_WOT_VERSION is invalid in the build/xvm-build.conf  XVMBUILD_WOT_VERSION=$XVMBUILD_WOT_VERSION"
  }
}

install_xfw()
{
  echo "=> xfw"
  rm -f "$WOT_PATH/mods/$XVMBUILD_WOT_VERSION"/com.modxvm.*.wotmod || err "[install_xfw]"
  cp -a ../~output/$XVMBUILD_FLAVOR/xfw/wotmod/com.modxvm.*.wotmod "$WOT_PATH/mods/$XVMBUILD_WOT_VERSION/" || err "[install_xfw]"
  # for debug only
  mkdir -p "$WOT_PATH/res_mods/$XVMBUILD_WOT_VERSION/gui/flash/" || err "[install_xfw]"
  cp -a ../~output/$XVMBUILD_FLAVOR/xfw/swf/*.swf "$WOT_PATH/res_mods/$XVMBUILD_WOT_VERSION/gui/flash/" || err "[install_xfw]"
}

install_xvm()
{
  echo "=> xvm"
  rm -rf "$WOT_PATH/res_mods/mods/xfw_packages" || err "[install_xvm] rm"
  mkdir -p "$WOT_PATH/res_mods/mods/xfw_packages" || err "[install_xvm] mkdir"
  cp -a ../~output/$XVMBUILD_FLAVOR/xvm/res_mods/mods/xfw_packages/xvm_* "$WOT_PATH/res_mods/mods/xfw_packages/" || err "[install_xvm] cp"
}

copy_configs()
{
  echo "=> res_mods/configs/xvm"
  rm -rf "$WOT_PATH/res_mods/configs/xvm/py_macro/xvm" || err "[copy_xvm_dir] rm"
  mkdir -p "$WOT_PATH/res_mods/configs/xvm" || err "[copy_configs] mkdir"
  cp -a ../release/configs/* "$WOT_PATH/res_mods/configs/xvm" || err "[copy_configs] cp configs"

  echo "=> res_mods/configs/xvm/xvm.xc"
  if [ -f "test/configs/xvm.xc" ]; then
    cp -a "test/configs/xvm.xc" "$WOT_PATH/res_mods/configs/xvm/xvm.xc" || err "[copy_configs] cp xvm.xc"
  else
    rm -f "$WOT_PATH/res_mods/configs/xvm/xvm.xc" || err "[copy_configs] rm xvm.xc"
  fi
}

copy_xvm_dir()
{
  [ -e "$SHARED_RESOURCES_PATH/$1" ] && rm -rf "$SHARED_RESOURCES_PATH/$1"
  [ -d "../release/$1" ] && {
    echo "=> $1"
    mkdir -p $(dirname "$SHARED_RESOURCES_PATH/$1") || err "[copy_xvm_dir] mkdir"
    cp -a "../release/$1" "$SHARED_RESOURCES_PATH/$1" || err "[copy_xvm_dir] cp"
  }
}

copy_xvm_file()
{
  [ -f "$SHARED_RESOURCES_PATH/$1" ] && rm -f "$SHARED_RESOURCES_PATH/$1"
  [ -f "../release/$1" ] && {
    echo "=> $1"
    mkdir -p $(dirname "$SHARED_RESOURCES_PATH/$1") || err "[copy_xvm_file]"
    cp -a "../release/$1" "$SHARED_RESOURCES_PATH/$1" || err "[copy_xvm_file]"
  }
}

# MAIN
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd "$CURRENT_DIR" >/dev/null

# load config
. ../build/xvm-build.conf

SHARED_RESOURCES_PATH=$WOT_PATH/res_mods/mods/shared_resources/xvm

# check config
check_config

# deploy

install_xfw

install_xvm

copy_configs

for n in $XVM_DIRS; do
  copy_xvm_dir $n
done

for n in $XVM_FILES; do
  copy_xvm_file $n
done

popd >/dev/null
