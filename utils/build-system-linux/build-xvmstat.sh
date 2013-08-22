#!/bin/bash

#XVM-Stat builder for Linux
#Part of XVM build system
#Do not change anything in this file if you are not sure

#1. Detect revision
pushd ../../ > /dev/null
revision=$(svnversion | head -c 4)
popd > /dev/null

#2. Make dirs
mkdir -p ../../bin
rm -rf ../../bin/*

#3. Set target frameworks
targetver=(
        'v3.5'
        'v4.0'
       )
#3. Build XVM-stat
pushd sh > /dev/null
for (( i=0; i<${#targetver[@]}; i++ ));
  do
    ./xvmstat-build.sh ${targetver[$i]}
    echo "$revision" >> ../../../src/xvm-stat/bin/Release/"$revision"
    pushd ../../../src/xvm-stat/bin/Release/ > /dev/null && zip -9 -r -q "$revision"_xvmstat_${targetver[$i]}.zip ./ && popd > /dev/null
    mv -f ../../../src/xvm-stat/bin/Release/*.zip ../../../bin/
    rm -rf ../../../src/xvm-stat/bin/*
    rm -rf ../../../src/xvm-stat/obj/
  done
popd > /dev/null
