#!/bin/bash

#XVM-Stat builder for Linux
#Part of XVM build system
#Do not change anything in this file if you are not sure

#1. Detect revision
pushd ../../
revision=$(svnversion | head -c 4)
popd

#2. Build XVM-stat
pushd sh
./xvmstat-build.sh
popd

#3. Make dirs
mkdir -p ../../bin
rm -rf ../../bin/*

#4. Build zips
pushd ../../src/xvm-stat/bin/Release/ && zip -9 -r "$revision".zip ./ && popd

#5. Move&Clean
mv -f ../../src/xvm-stat/bin/Release/"$revision".zip ../../bin/

rm -rf ../../src/xvm-stat/bin/*
rm -rf ../../src/xvm-stat/obj/*
