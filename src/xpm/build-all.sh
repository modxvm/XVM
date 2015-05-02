#!/bin/bash

#############################
# CONFIG

RUN_TEST=1

#############################
# INTERNAL

### Find Python executable
PY_EXEC="/cygdrive/c/Python27/python.exe"
if [ ! -f $PY_EXEC ]; then
  PY_EXEC="python2.7" # Installed by cygwin or *nix
fi
###

clear()
{
  rm -rf "../../~output/~ver/gui/flash"
  rm -rf "../../~output/~ver/scripts"
  rm -rf "../../~output/mods/xfw"

  # remove _version_.py files
  for dir in $(find . -maxdepth 1 -type "d" ! -path "."); do
    rm -f $dir/__version__.py
  done

  find . -depth -empty -delete -type d
}

make_dirs()
{
  mkdir -p ../../~output/~ver/gui/flash/
  mkdir -p ../../~output/~ver/scripts
  mkdir -p ../../~output/configs/
  mkdir -p ../../~output/mods/shared_resources/
  mkdir -p ../../~output/mods/xfw/actionscript/
  mkdir -p ../../~output/mods/xfw/python/
  mkdir -p ../../~output/mods/xfw/resources/
}

build_xfw()
{
  pushd ../xfw/src/python/ >/dev/null
  ./build.sh
  popd >/dev/null
}

build()
{
  f=${1#*/}
  d=${f%/*}

  [ "$d" = "$f" ] && d=""

  if [ -f "../../~output/sha1/$2/python/$f.sha1" ] && [ "$(cat ../../~output/sha1/$2/python/$f.sha1)" = "$(sha1sum "$1")" ]; then
    return 0
  fi

  echo "Building: $1"
  result="$("$PY_EXEC" -c "import py_compile; py_compile.compile('$1')" 2>&1)"
  if [ "$result" == "" ]; then
    mkdir -p "../../~output/sha1/$2/python/$d"
    sha1sum $1 > "../../~output/sha1/$2/python/$f.sha1"
  else
    echo $result
  fi  

  [ ! -f $1c ] && exit
  mkdir -p "../../~output/$2/python/$d"
  cp $1c "../../~output/$2/python/${f}c"
  rm -f $1c
}

# MAIN

pushd $(dirname $0) >/dev/null

clear

make_dirs

echo 'building xfw'
build_xfw

# create __version__.py files
for dir in $(find . -maxdepth 1 -type "d" ! -path "."); do
  echo "# This file was created automatically from build script" > $dir/__version__.py
  echo "__revision__ = '`cd $dir && hg parent --template "{rev}"`'" >> $dir/__version__.py
  echo "__branch__ = '`cd $dir && hg parent --template "{branch}"`'" >> $dir/__version__.py
done

# build *.py files
echo 'building .py files'
for fn in $(find . -type "f" -name "*.py"); do
  f=${fn#./}
  m=${f%%/*}
  build $f mods/packages/$m
done

popd >/dev/null

# run test
if [ "$OS" = "Windows_NT" -a "$XFW_DEVELOPMENT" = "1" -a "$RUN_TEST" = "1" ]; then
  sh "$(dirname $(realpath $(cygpath --unix $0)))/../../utils/test.sh"
fi
