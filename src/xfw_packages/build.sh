#!/bin/bash

# This file is part of the XVM Framework project.
#
# Copyright (c) 2013-2021 XVM Team.
#
# XVM Framework is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as
# published by the Free Software Foundation, version 3.
#
# XVM Framework is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#


##########################
#  PREPARE ENVIRONMENT   #
##########################

currentdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source "$currentdir/../../build_lib/library.sh"
source "$currentdir/../../build/xvm-build.conf"


##########################
####      CONFIG      ####
##########################

if [ "$XVMBUILD_ROOT_PATH" == "" ]; then
  XVMBUILD_ROOT_PATH="$currentdir/../.."
fi

if [ "$XVMBUILD_XFW_PACKAGES_OUTPUTPATH" == "" ]; then
  XVMBUILD_XFW_PACKAGES_OUTPUTPATH="~output/xfw/packages/"
fi

if [ "$XVMBUILD_XFW_WOTMOD_OUTPUTPATH" == "" ]; then
  XVMBUILD_XFW_WOTMOD_OUTPUTPATH="~output/xfw/wotmod/"
fi

outputpath="$XVMBUILD_ROOT_PATH/$XVMBUILD_XFW_PACKAGES_OUTPUTPATH"
wotmodpath="$XVMBUILD_ROOT_PATH/$XVMBUILD_XFW_WOTMOD_OUTPUTPATH"

libraries=(
  'xfw_actionscript'
  'xfw_filewatcher'
  'xfw_fonts'
  'xfw_libraries'
  'xfw_loader'
  'xfw_mutex'
  'xfw_ping'
  'xfw_wotfix_crashes'
  'xfw_wotfix_hidpi'
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
  cp -rf "$XVMBUILD_ROOT_PATH/~output/xfw/swf_wg/." "$1/res/gui/flash"
  cp -rf "$XVMBUILD_ROOT_PATH/~output/xfw/swf/." "$1/res/gui/flash"
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
      _="$("$XVMBUILD_PYTHON_FILEPATH" -c "import py_compile; py_compile.compile('$fn')" 2>&1)"

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
    #create empty file
    echo "" > "$1/__init__.py"
    _="$("$XVMBUILD_PYTHON_FILEPATH" -c "import py_compile; py_compile.compile('$1/__init__.py')" 2>&1)"
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
    sed -i "s/WOT_VERSION/$XVMBUILD_WOT_VERSION/g" "$2"
    sed -i "s/XVMBUILD_DEVELOPMENT/$XVMBUILD_DEVELOPMENT/g" "$2"
  fi
}

prepare_metaxml()
{
  cp "$1" "$2"
  sed -i s/XFW_VERSION/$XVMBUILD_XVM_VERSION.$REPOSITORY_COMMITS_NUMBER$REPOSITORY_BRANCH_FORFILE/g "$2"
}

install_wotmod()
{
    mkdir -p "$wotmodpath/"
    cp -rf "$currentdir/_wotmod/." "$wotmodpath/"
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

mkdir -p "$outputpath"
mkdir -p "$wotmodpath"

for (( i=0; i<${#libraries[@]}; i++ )); do
  build_package ${libraries[$i]}
done

install_wotmod
