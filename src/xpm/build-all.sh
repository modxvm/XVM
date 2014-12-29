#!/bin/sh

CLEAR=0
BUILD_LIBS=0

### Path vars can be assigned at .bashrc
[ "$WOT_DIRECTORY" = "" ] && WOT_DIRECTORY=/cygdrive/d/work/games/WoT

cd $(dirname $0)

[ "$GAME_VER" = "" ] && GAME_VER=$(<../../build/target_version)
GAME_VER=`echo $GAME_VER | tr -d '\n\r'`

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

build_xfw()
  {
    export xfw_path_root="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    export xfw_output_python_path="../../bin/xpm"
    pushd ../xfw/src/python/ >/dev/null
    ./build.sh
    popd >/dev/null
  }

build()
{
  echo "Build: $1"
  f=${1#*/}
  d=${f%/*}

  [ "$d" = "$f" ] && d=""

  "$PY_EXEC" -c "import py_compile; py_compile.compile('$1')"
  [ ! -f $1c ] && exit

  mkdir -p "../../bin/xpm/scripts/client/gui/$2/$d"
  cp $1c "../../bin/xpm/scripts/client/gui/$2/${f}c"
  rm -f $1c
}

[ "$XPM_DEVELOPMENT" != "" -a "$CLEAR" != "0" ] && clear

build_xfw

for dir in $(find . -maxdepth 1 -type "d" ! -path "."); do
  echo "# This file was created automatically from build script" > $dir/__version__.py
  echo "__revision__ = '`cd $dir && hg parent --template "{rev}"`'" >> $dir/__version__.py
  echo "__branch__ = '`cd $dir && hg parent --template "{branch}"`'" >> $dir/__version__.py
done

for fn in $(find . -type "f" -name "*.py"); do
  f=${fn#./}
  m=${f%%/*}

  if [ "$XPM_DEVELOPMENT" != "" -a "$BUILD_LIBS" = "0" ]; then
    if [[ $f = xvm_waiting_fix/* ]]; then continue; fi
  fi
  build $f mods/$m

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
