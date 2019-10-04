#!/bin/bash

# XVM team (c) https://modxvm.com 2014-2019
# XFW Framework build system

set -e

currentdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$currentdir"/../../build/library.sh

detect_coreutils
detect_python

#setup environment
if [ "$XFW_BUILD_CLEAR" == "" ]; then
  XFW_BUILD_CLEAR=0
fi

if [ "$XFW_BUILD_LIBS" == "" ]; then
  XFW_BUILD_LIBS=0
fi

cmp_dir="../../~output/cmp"
cmp_file="$cmp_dir/python.sum"

clear()
{
  rm -rf ../../~output/python/
  rm -f "$cmp_file"
}

build()
{
  local f=${1%*/}
  local d=${f%/*}

  [ "$d" = "$f" ] && d=""

  local py_dir="../../~output/python/$d"
  local py_file="../../~output/python/$f"

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

[ "$XFW_DEVELOPMENT" != "" -a "$XFW_BUILD_CLEAR" != "0" ] && clear

#st=$(date +%s%N)

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

#echo "$(($(date +%s%N)-$st)) sec"
