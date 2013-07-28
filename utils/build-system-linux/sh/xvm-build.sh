#!/bin/bash

#XVM builder for Linux
#Part of XVM build system
#Do not change anything in this file if you are not sure

rm -rf ../../../bin/*

./xvm-gen-include.sh  
./xvm-swf-patch.sh
./xvm-swf-build.sh

rm -rf ../../../src/xvm/include/com/
rm -rf ../../../src/xvm/include/wot/
rm -rf ../../../src/xvm/swf/*.swf
