#!/bin/bash

#XVM-Stat builder for Linux
#Part of XVM build system
#Do not change anything in this file if you are not sure

#1. Detect revision
pushd ../../ > /dev/null
revision=$(svnversion | head -c 4)
popd > /dev/null

#2. Build XVM-stat
pushd sh > /dev/null
./xvmstat-build.sh
popd > /dev/null

#3. Make dirs
mkdir -p ../../bin
rm -rf ../../bin/*

#4. Build zips
echo "$revision" >> ../../src/xvm-stat/bin/Release/"$revision"
pushd ../../src/xvm-stat/bin/Release/ > /dev/null && zip -9 -r -q "$revision"_xvmstat.zip ./ && popd > /dev/null

#5. Move&Clean
mv -f ../../src/xvm-stat/bin/Release/"$revision"_xvmstat.zip ../../bin/

rm -rf ../../src/xvm-stat/bin/*
rm -rf ../../src/xvm-stat/obj/*
