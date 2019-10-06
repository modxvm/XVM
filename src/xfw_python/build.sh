#!/bin/bash

# This file is part of the XVM Framework project.
#
# Copyright (c) 2013-2019 XVM Team.
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

set -e

currentdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$currentdir"/../../build_lib/library.sh

detect_coreutils
detect_python

##########################
####      CONFIG      ####
##########################

if [ "$XFW_BUILD_CLEAR" == "" ]; then
  XFW_BUILD_CLEAR=0
fi

if [ "$XFW_BUILD_LIBS" == "" ]; then
  XFW_BUILD_LIBS=0
fi

cmp_dir="../../~output/xfw/cmp"
cmp_file="$cmp_dir/python.sum"
py_rootdir="../../~output/xfw/python"

##########################
####  BUILD FUNCTIONS ####
##########################

clear()
{
  rm -rf "$py_rootdir"
  rm -f "$cmp_file"
}

build()
{
  local f=${1%*/}
  local d=${f%/*}

  [ "$d" = "$f" ] && d=""

  local py_dir="$py_rootdir/$d"
  local py_file="$py_rootdir/$f"

  local cmp=$(cksum "$1")
  cmp=${cmp% *}

  if [ -f "$py_file" -o -f "${py_file}c" ] && [ "$cmp" = "${cmp_data[$1]}" ]; then
    return 0
  fi

  echo "building $1"
  result="$("$XVMBUILD_PYTHON_FILEPATH" -c "import py_compile; py_compile.compile('$1')" 2>&1)"
  if [ "$result" == "" ]; then
    cmp_data[$1]=$cmp
    # save cmp
    mkdir -p "$cmp_dir"
    declare -p cmp_data > "$cmp_file"
  else
    echo -e "$result"
  fi

  [ ! -f $1c ] && exit 1
  mkdir -p "$py_dir"
  # uncompiled
  cp $1 "$py_file"
  # compiled
  cp $1c "${py_file}c"
  rm -f $1c
}

##########################
####  BUILD PIPELINE  ####
##########################

[ "$XFW_DEVELOPMENT" != "" -a "$XFW_BUILD_CLEAR" != "0" ] && clear

# load cmp
if [ -f "$cmp_file" ]; then
  source "$cmp_file"
else
  declare -A cmp_data
fi

for fn in $(find . -type "f" -name "*.py" ! -path "./output*"); do
  f=${fn#./}
  if [ "$XFW_DEVELOPMENT" != "" -a "$XFW_BUILD_LIBS" = "0" ]; then
    if [[ $f = mods/xfw/python/lib/* ]]; then
      continue;
    fi
  fi

  build $f
done
