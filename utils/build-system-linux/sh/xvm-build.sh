#!/bin/bash

#XVM builder for Linux
#Part of XVM build system
#Do not change anything in this file if you are not sure

rm -rf ../../../bin/*
rm -rf ../../../temp/*

rm -rf ../../../src/xvm/lib/*
rm -rf ../../../src/xvm/obj/
rm -rf ../../../src/xvm-as2/include/
rm -rf ../../../src/xvm-as2/swf/*.swf

./xvm-swf-build-as3.sh
#./xvm-swf-patch-as3.sh

./xvm-swf-patch-as2.sh
./xvm-swf-build-as2.sh

rm -rf ../../../src/xvm/lib/*
rm -rf ../../../src/xvm/obj/
rm -rf ../../../src/xvm-as2/include/
rm -rf ../../../src/xvm-as2/swf/*.swf