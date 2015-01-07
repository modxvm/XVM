#!/bin/bash

#############################
# CONFIG

RUN_TEST=0

#############################
# INTERNAL

cd $(dirname $0)

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
}

make_dirs()
{
  mkdir -p ../../~output/~ver/gui/flash/
  mkdir -p ../../~output/~ver/scripts
  mkdir -p ../../~output/mods/xfw/actionscript/
  mkdir -p ../../~output/mods/xfw/python/
  mkdir -p ../../~output/mods/xfw/resources/
}

build_xfw()
{
  pushd ../xfw/src/python/ >/dev/null
  ./build.sh
  popd >/dev/null

  cp -a ../xfw/~output/swf_wg/* ../../~output/~ver/gui/flash/
  cp -a ../xfw/~output/swf/* ../../~output/mods/xfw/actionscript/
  cp -a ../xfw/~output/python/scripts/* ../../~output/~ver/scripts/
  cp -a ../xfw/~output/python/mods/* ../../~output/mods/
}

build()
{
  echo "Build: $1"
  f=${1#*/}
  d=${f%/*}

  [ "$d" = "$f" ] && d=""

  "$PY_EXEC" -c "import py_compile; py_compile.compile('$1')"
  [ ! -f $1c ] && exit

  mkdir -p "../../~output/$2/python/$d"
  cp $1c "../../~output/$2/python/${f}c"
  rm -f $1c
}

# MAIN

clear

make_dirs

build_xfw

# create __version__.py files
for dir in $(find . -maxdepth 1 -type "d" ! -path "."); do
  echo "# This file was created automatically from build script" > $dir/__version__.py
  echo "__revision__ = '`cd $dir && hg parent --template "{rev}"`'" >> $dir/__version__.py
  echo "__branch__ = '`cd $dir && hg parent --template "{branch}"`'" >> $dir/__version__.py
done

# build *.py files
for fn in $(find . -type "f" -name "*.py"); do
  f=${fn#./}
  m=${f%%/*}
  build $f mods/packages/$m
done

# run test
if [ "$OS" = "Windows_NT" -a "$RUN_TEST" = "1" ]; then
  sh "../../utils/test.sh"
fi
