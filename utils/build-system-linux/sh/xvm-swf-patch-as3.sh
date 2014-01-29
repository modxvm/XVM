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

for file in *.swf
do
 mv "$file" "${file%.swf}.orig.swf"
done

echo "Patching AS3 files"
for (( i=0; i<${#files[@]}; i++ ));
  do
    echo "patching ${files[$i]}.swf"

    abcexport ${files[$i]}.orig.swf
    rabcdasm ${files[$i]}.orig-0.abc

    for j in ${files[$i]}.*.patch;
      do
        patch --binary -p0 -s < $j
      done

    rabcasm ${files[$i]}.orig-0/${files[$i]}.orig-0.main.asasm
    abcreplace ${files[$i]}.orig.swf 0 ${files[$i]}.orig-0/${files[$i]}.orig-0.main.abc
    rm ${files[$i]}.orig-0.abc
    rm -rf ${files[$i]}.orig-0
  done

for file in *.swf
do
 mv "$file" "${file%.orig.swf}.swf"
done

mkdir -p ../../../bin/as3
cp -f *.swf ../../../bin/as3

rm -f *.swf
rm -f *.orig
rm -f *.rej

echo ""

popd > /dev/null

