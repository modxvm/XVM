#!/bin/bash

#XVM include generator for Linux
#Part of XVM build system
#Do not change anything in this file if you are not sure

pushd ../../../src/xvm/include
mono ../../../utils/build-system-linux/bin/IGen.exe -clean ../src .
popd
