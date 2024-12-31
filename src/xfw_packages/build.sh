#!/bin/bash

# SPDX-License-Identifier: LGPL-3.0-or-later
# Copyright (c) 2013-2025 XVM Contributors

##########################
#  PREPARE ENVIRONMENT   #
##########################

currentdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source "$currentdir/../../build_lib/library.sh"
source "$currentdir/../../build/xvm-build.conf"


##########################
####      CONFIG      ####
##########################

# $XVMBUILD_FLAVOR
if [[ "$XVMBUILD_FLAVOR" == "" ]]; then
    export XVMBUILD_FLAVOR="wg"
fi

if [ "$XVMBUILD_ROOT_PATH" == "" ]; then
  XVMBUILD_ROOT_PATH="$currentdir/../.."
fi

if [ "$XVMBUILD_XFW_PACKAGES_OUTPUTPATH" == "" ]; then
  XVMBUILD_XFW_PACKAGES_OUTPUTPATH="~output/$XVMBUILD_FLAVOR/packages/"
fi

if [ "$XVMBUILD_XFW_WOTMOD_OUTPUTPATH" == "" ]; then
  XVMBUILD_XFW_WOTMOD_OUTPUTPATH="~output/$XVMBUILD_FLAVOR/wotmod/"
fi

if [ "$XVMBUILD_XFW_WOTMOD_OUTPUTPATH_OPENWG" == "" ]; then
  XVMBUILD_XFW_WOTMOD_OUTPUTPATH_OPENWG="~output/$XVMBUILD_FLAVOR/wotmod_openwg/"
fi

WOT_VERSION=$(echo '$XVMBUILD_WOT_VERSION_'"${XVMBUILD_FLAVOR}" | envsubst)

outputpath="$XVMBUILD_ROOT_PATH/$XVMBUILD_XFW_PACKAGES_OUTPUTPATH"
wotmodpath="$XVMBUILD_ROOT_PATH/$XVMBUILD_XFW_WOTMOD_OUTPUTPATH"
wotmodpath_openwg="$XVMBUILD_ROOT_PATH/$XVMBUILD_XFW_WOTMOD_OUTPUTPATH_OPENWG"

libraries=(
  'xfw_actionscript'
  'xfw_libraries'
)


##########################
####  BUILD FUNCTIONS ####
##########################

copy_binaries()
{
  if [ -d "$currentdir/_binaries/$1/" ]; then
    mkdir -p "$2/native/"
    cp -rf "$currentdir/_binaries/$1/." "$2/"
  fi
}

copy_fonts()
{
  if [ -d "$currentdir/$1/fonts/" ]; then
    mkdir -p "$2/fonts/"
    cp -rf "$currentdir/$1/fonts/." "$2/fonts/"
  fi
}

copy_swf()
{
  mkdir -p "$1/res/gui/flash/"
  cp -rf "$XVMBUILD_ROOT_PATH/~output/$XVMBUILD_FLAVOR/swf/." "$1/res/gui/flash"
}

copy_license()
{
  mkdir -p "$1"
  cp -rf "$XVMBUILD_ROOT_PATH/LICENSE.txt" "$1/"
}

build_python()
{
  if [ -d "$1/" ]; then
    mkdir -p "$2"

    pushd "$1" > /dev/null

    for fn in $(find "./" -type "f" -name "*.py"); do

      echo "building $1/$fn"

      #build
      _="$("$XVMBUILD_PYTHON_FILEPATH" -c "import py_compile; py_compile.compile('$fn')")"
      if [ $? -ne 0 ]; then
        echo "Failed to build $1/$fn"
        exit 1
      fi

      #copy to output
      out_py_file="$2/$fn"
      out_py_dir=$(dirname "${out_py_file}")

      mkdir -p "$out_py_dir"
      mv "$fn"c "${out_py_file}c"
    done

    popd > /dev/null
  fi
}

build_python_empty()
{
    #push to directory
    if [ ! -d "$1/" ]; then
      echo "Failed to found $1"
      exit 1
    fi
    pushd "$1" > /dev/null

    #create empty file
    echo "" > "./__init__.py"
    _="$("$XVMBUILD_PYTHON_FILEPATH" -c "import py_compile; py_compile.compile('./__init__.py')" )"
    if [ $? -ne 0 ]; then
      echo "Failed to build $1/__init__.py"
      exit 1
    fi
    rm -f "./__init__.py"

    popd > /dev/null
}

copy_files()
{
  if [ -d "$1/" ]; then
    pushd "$1" > /dev/null
    find . -name "$3" -exec cp --parents \{\} "$2" \;
    popd > /dev/null
  fi
}

prepare_json()
{
  if [[ -f "$1" ]]; then
    cp "$1" "$2"
    sed -i s/XFW_VERSION/$XVMBUILD_XVM_VERSION.$REPOSITORY_COMMITS_NUMBER$REPOSITORY_BRANCH_FORFILE/g "$2"
    sed -i "s/WOT_VERSION/$WOT_VERSION/g" "$2"
  fi
}

prepare_metaxml()
{
  cp "$1" "$2"
  sed -i s/XFW_VERSION/$XVMBUILD_XVM_VERSION.$REPOSITORY_COMMITS_NUMBER$REPOSITORY_BRANCH_FORFILE/g "$2"
}

install_wotmod_xfw()
{
    mkdir -p "$wotmodpath/"
    cp -rf "$currentdir/_wotmod_xfw/." "$wotmodpath/"
}

install_wotmod_openwg()
{
    mkdir -p "$wotmodpat_openwg/"
    cp -rf "$currentdir/_wotmod_openwg/." "$wotmodpath_openwg/"
}

pack_package()
{
    pushd $1 > /dev/null
    zip -0 -X -q -r "$2" ./*
    popd > /dev/null
}


build_package()
{
  package_name="$1"
  package_dir="./$1"
  wotmod_filename="com.modxvm.${package_name//_/.}_$XVMBUILD_XVM_VERSION.$REPOSITORY_COMMITS_NUMBER$REPOSITORY_BRANCH_FORFILE.wotmod"
  output_dir="$outputpath/$package_name"
  mkdir -p "$output_dir"

  output_dir_xfwlibraries="$output_dir/res/mods/xfw_libraries"
  output_dir_guimods="$output_dir/res/scripts/client/gui/mods"
  output_dir_xfwpackage="$output_dir/res/mods/xfw_packages/$package_name"
  mkdir -p "$output_dir_xfwpackage"

  prepare_metaxml "$package_dir/meta.xml" "$output_dir/meta.xml"
  prepare_json  "$package_dir/xfw_package.json" "$output_dir_xfwpackage/xfw_package.json"

  copy_license  "$output_dir"
  copy_binaries $package_name "$output_dir_xfwpackage"
  copy_fonts    $package_name "$output_dir_xfwpackage"
  if [ $package_name == "xfw_actionscript" ]; then
    copy_swf "$output_dir"
  fi

  build_python  "$package_dir/python_libraries" "$output_dir_xfwlibraries"
  build_python  "$package_dir/python_guimods" "$output_dir_guimods"
  build_python  "$package_dir/python" "$output_dir_xfwpackage/python"
  build_python_empty "$output_dir_xfwpackage"
  copy_files "$package_dir/python_libraries" "$output_dir_xfwlibraries" "*.pem"

  pack_package  "$output_dir" "$wotmodpath/$wotmod_filename"

}


##########################
####  BUILD PIPELINE  ####
##########################

detect_coreutils
detect_os
detect_python
detect_git

git_get_repostats "$XVMBUILD_ROOT_PATH"

rm -rf "$outputpath"
rm -rf "$wotmodpath"
rm -rf "$wotmodpath_openwg"


mkdir -p "$outputpath"
mkdir -p "$wotmodpath"
mkdir -p "$wotmodpath_openwg"

for (( i=0; i<${#libraries[@]}; i++ )); do
  build_package ${libraries[$i]}
done

install_wotmod_xfw
install_wotmod_openwg
