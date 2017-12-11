#!/bin/bash

#############################
# CONFIG

XPM_CLEAR=${XPM_CLEAR:=0}
XPM_RUN_TEST=${XPM_RUN_TEST:=1}

#############################
# INTERNAL

currentdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$currentdir"/../../src/xfw/build/library.sh
source "$currentdir"/../../build/xvm-build.conf

detect_coreutils
detect_python
detect_mercurial

XVMBUILD_XVM_REVISION=$(hg parent --template "{rev}")

clear()
{
  rm -rf "../../~output/res_mods/~ver/gui/flash"
  rm -rf "../../~output/res_mods/~ver/scripts"
  rm -rf "../../~output/res_mods/mods/xfw"

  # remove _version_.py files
  for dir in $(find . -maxdepth 1 -type "d" ! -path "."); do
    rm -f $dir/__version__.py
  done

  find . -depth -empty -delete -type d
}

make_dirs()
{
  mkdir -p ../../~output/res_mods/configs/xvm/
  mkdir -p ../../~output/res_mods/mods/shared_resources/
}

build_xfw()
{
  pushd ../xfw/ >/dev/null
  export XFW_BUILD_CLEAR=0
  export XFW_BUILD_LIBS=0
  ./build.sh python || exit 1
  unset XFW_BUILD_CLEAR
  unset XFW_BUILD_LIBS
  popd >/dev/null
}

build()
{
  f=${1#*/}
  d=${f%/*}

  [ "$d" = "$f" ] && d=""

  py_dir="../../~output/res_mods/$2/python/$d"
  py_file="../../~output/res_mods/$2/python/$f"
  cmp_dir="../../~output/res_mods/cmp/$2/python/$d"
  cmp_file="../../~output/res_mods/cmp/$2/python/$f.tmp"

  if [ -f "$py_file" ] && [ -f "$cmp_file" ] && cmp "$1" "$cmp_file" >/dev/null 2>&1; then
    return 0
  fi

  if [[ $1 != */__version__.py ]]; then
    echo "Building: $1"
  fi
  result="$("$XVMBUILD_PYTHON_FILEPATH" -c "import py_compile; py_compile.compile('$1')" 2>&1)"
  if [ "$result" == "" ]; then
    mkdir -p "$cmp_dir"
    cp -f "$1" "$cmp_file"
  else
    echo -e "$result"
  fi

  [ ! -f $1c ] && exit 1
  mkdir -p "$py_dir"
  cp $1 "$py_file"
  rm -f $1c
}

# MAIN

pushd $(dirname $0) >/dev/null

if [ "$XPM_CLEAR" = "1" ]; then
    clear
fi

make_dirs

echo 'building xfw'
build_xfw

echo 'updating versions'
#st=$(date +%s%N)
version_template=$(hg parent --template "__revision__ = '{rev}'\n__branch__ = '{branch}'\n__node__ = '{node}'")
# create __version__.py files
for dir in $(find . -maxdepth 1 -type "d" ! -path "."); do
  echo "# This file was created automatically from build script" > $dir/__version__.py
  echo "__xvm_version__ = '$XVMBUILD_XVM_VERSION'" >> $dir/__version__.py
  echo "$version_template" >> $dir/__version__.py
done
#echo "$(($(date +%s%N)-$st))"

# build *.py files
echo 'building xvm'
#st=$(date +%s%N)
for fn in $(find . -type "f" -name "*.py"); do
  f=${fn#./}
  m=${f%%/*}
  build $f mods/xfw_packages/$m
  if [[ $fn = */__version__.py ]]; then
      rm -f "$fn"
  fi
done

# build *.json file
for fn in $(find . -type "f" -name "*xfw_package.json"); do
  f=${fn#./}
  m=${f%%/*}

  echo "$f"

  outpath="../../~output/res_mods/mods/xfw_packages/$m/xfw_package.json"
  cp "$fn" "$outpath"
  sed -i "s/XVM_VERSION/$XVMBUILD_XVM_VERSION.$XVMBUILD_XVM_REVISION/g" "$outpath"
  sed -i "s/WOT_VERSION/$XVMBUILD_WOT_VERSION/g" "$outpath"
done

#echo "$(($(date +%s%N)-$st))"

# generate default config from .xc files and xvm.xc.sample
echo 'generate default_config.py and xvm.xc.sample'
dc_fn=../../~output/res_mods/mods/xfw_packages/xvm_main/python/default_config.py
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
[ ! -f ${dc_fn}c ] && { cat "$dc_fn"; rm -f "$dc_fn"; }
rm -f "${dc_fn}c"
[ ! -f ${dc_fn} ] && exit

xvm_xc_sample_src=../../release/configs/xvm.xc.sample
xvm_xc_sample_trgt=../../~output/res_mods/mods/xfw_packages/xvm_main/python/default_xvm_xc.py
echo -e -n "# -*- coding: utf-8 -*-\n''' Generated automatically by XVM builder '''\nDEFAULT_XVM_XC = '''" > $xvm_xc_sample_trgt
cat $xvm_xc_sample_src >> $xvm_xc_sample_trgt
echo "'''" >> $xvm_xc_sample_trgt
"$XVMBUILD_PYTHON_FILEPATH" -c "import py_compile; py_compile.compile('$xvm_xc_sample_trgt')"
[ ! -f ${xvm_xc_sample_trgt}c ] && { rm -f "$xvm_xc_sample_trgt"; exit; }
rm -f "${xvm_xc_sample_trgt}c"

popd >/dev/null

# run test
if [ "$OS" = "Windows_NT" -a "$XFW_DEVELOPMENT" = "1" -a "$XPM_RUN_TEST" = "1" ]; then
  sh "$(dirname $(realpath $(cygpath --unix $0)))/../../utils/test.sh"
fi
