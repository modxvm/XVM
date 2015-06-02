#!/bin/bash

#############################
# CONFIG

RUN_TEST=1

#############################
# INTERNAL

### Find Python executable
currentdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$currentdir"/../../build/library.sh

detect_python
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

  pyc_dir="../../~output/$2/python/$d"
  pyc_file="../../~output/$2/python/${f}c"
  sum_dir="../../~output/sha1/$2/python/$d"
  sum_file="../../~output/sha1/$2/python/$f.sha1"
  sum=$(sha1sum "$1")

  if [ -f "$pyc_file" ] && [ -f "$sum_file" ] && [ "$(cat $sum_file)" = "$sum" ]; then
    return 0
  fi

  if [ "${1##*/}" != "__version__.py" ]; then
    echo "Building: $1"
  fi
  result="$("$XVMBUILD_PYTHON_FILEPATH" -c "import py_compile; py_compile.compile('$1')" 2>&1)"
  if [ "$result" == "" ]; then
    mkdir -p "$sum_dir"
    sha1sum $1 > "$sum_file"
  else
    echo -e "$result"
  fi

  [ ! -f $1c ] && exit
  mkdir -p "$pyc_dir"
  cp $1c "$pyc_file"
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
echo 'building xvm'
for fn in $(find . -type "f" -name "*.py"); do
  f=${fn#./}
  m=${f%%/*}
  build $f mods/packages/$m
done

# generate default config from .xc files
# TODO: review and refactor
echo 'generate default_config.pyc'
dc_fn=../../~output/mods/packages/xvm_main/python/default_config.py
rm -f "${dc_fn}c"
"$XVMBUILD_PYTHON_FILEPATH" -c "
import sys
sys.path.insert(0, '../xfw/~output/python/mods/xfw/python/lib')
import JSONxLoader
cfg = JSONxLoader.load('../../release/configs/default/@xvm.xc')
en = JSONxLoader.load('../../release/l10n/en.xc')
ru = JSONxLoader.load('../../release/l10n/ru.xc')
print('DEFAULT_CONFIG={}\nLANG_EN={}\nLANG_RU={}'.format(cfg, en, ru))
" > $dc_fn 2>&1
"$XVMBUILD_PYTHON_FILEPATH" -c "import py_compile; py_compile.compile('$dc_fn')" 2>&1
[ ! -f ${dc_fn}c ] && cat "$dc_fn"
rm -f "$dc_fn"
[ ! -f ${dc_fn}c ] && exit

popd >/dev/null

# run test
if [ "$OS" = "Windows_NT" -a "$XFW_DEVELOPMENT" = "1" -a "$RUN_TEST" = "1" ]; then
  sh "$(dirname $(realpath $(cygpath --unix $0)))/../../utils/test.sh"
fi
