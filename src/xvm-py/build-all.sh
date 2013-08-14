#!/bin/sh

cd $(dirname $0)

WOT_ROOT=/cygdrive/d/work/games/WoT
VER=0.8.7

clear()
{
  rm -rf "../../bin/xpm"
}

build()
{
  echo "Build: $1"
  /cygdrive/c/Python26/python.exe -c "import py_compile; py_compile.compile('$1')"
  if [ ! -f $1c ]; then
    exit
  fi
  f=${1#*/}
  d=${f%/*}
  mkdir -p "../../bin/xpm/scripts/client/gui/$d"
  cp $1c "../../bin/xpm/scripts/client/gui/${f}c"
  rm -f $1c
}

run()
{
  #rm -rf "$WOT_ROOT/res_mods/$VER/scripts"
  cp -R ../../bin/xpm/scripts "$WOT_ROOT/res_mods/$VER"
  sh "../../utils/test.sh"
}

clear                       

opwd=$PWD

for fn in $(find . -name "*.py"); do
  f=${fn#./}
  build $f
done

run
