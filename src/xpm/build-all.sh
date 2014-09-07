#!/bin/sh

### Path vars can be assigned at .bashrc
#[ "$GAME_VER" = "" ] && GAME_VER="0.9.2"
[ "$GAME_VER" = "" ] && GAME_VER="0.9.3 Common Test"
[ "$WOT_DIRECTORY" = "" ] && WOT_DIRECTORY=/cygdrive/d/work/games/WoT-CT

cd $(dirname $0)

### Find Python executable
  PY_EXEC="/cygdrive/c/Python27/python.exe"
  if [ ! -f $PY_EXEC ]; then
    PY_EXEC="python2.7" # Installed by cygwin or *nix
  fi
###

clear()
{
  rm -rf "../../bin/xpm"
}

build()
{
  echo "Build: $1"
  f=${1#*/}
  d=${f%/*}
  [ "$d" = "$f" ] && d=""

  "$PY_EXEC" -c "import py_compile; py_compile.compile('$1')"
  [ ! -f $1c ] && exit

  if [ -z "$2" ]; then
    mkdir -p "../../bin/xpm/scripts/client/gui/$d"
    cp $1c "../../bin/xpm/scripts/client/gui/${f}c"
  else
    mkdir -p "../../bin/xpm/scripts/client/gui/$2/$d"
    cp $1c "../../bin/xpm/scripts/client/gui/$2/${f}c"
  fi
  rm -f $1c
}

clear

for dir in $(find . -maxdepth 1 -type "d" ! -path "./xpm*" ! -path "."); do
  echo "# This file was created automatically from build script" > $dir/__version__.py
  echo "__revision__ = '`cd $dir && hg parent --template "{rev}"`'" >> $dir/__version__.py
  echo "__branch__ = '`cd $dir && hg parent --template "{branch}"`'" >> $dir/__version__.py
done

for fn in $(find . -type "f" -name "*.py"); do
  f=${fn#./}
  m=${f%%/*}
  if [ "$m" = "xpm" ]; then
    build $f
  else
    build $f mods/$m
  fi
done

if [ "$OS" = "Windows_NT" ]; then
  run()
  {
    rm -rf "$WOT_DIRECTORY/res_mods/$GAME_VER/scripts"
    cp -R ../../bin/xpm/scripts "$WOT_DIRECTORY/res_mods/$GAME_VER"
    sh "../../utils/test.sh" --no-deploy
  }

  run
fi
