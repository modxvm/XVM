#!/bin/bash

#XVM .swf patcher for Linux
#Part of XVM build system
#Do not change anything in this file if you are not sure

files=(
        'Application'
       )

pushd ../../../src/xvm/swf/ > /dev/null
export PATH=$PATH:../../../utils/build-system-linux/bin/rabcdasm/

cp flash/* ./

for (( i=0; i<${#files[@]}; i++ ));
  do
    abcexport ${files[$i]}.swf
    rabcdasm ${files[$i]}-0.abc
    patch --binary -p0 -s < ${files[$i]}.patch
    rabcasm ${files[$i]}-0/${files[$i]}-0.main.asasm
    abcreplace ${files[$i]}.swf 0 ${files[$i]}-0/${files[$i]}-0.main.abc
    rm ${files[$i]}-0.abc
    rm -rf ${files[$i]}-0
  done

mkdir -p ../../../bin/as3
cp -f *.swf ../../../bin/as3

rm -f *.swf
rm -f *.orig
rm -f *.rej

popd > /dev/null
