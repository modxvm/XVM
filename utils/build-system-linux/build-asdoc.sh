#!/bin/bash

#XVM ASDoc builder for Linux
#Part of XVM build system
#Do not change anything in this file if you are not sure

#1. Detect Flex version
pushd config/ > /dev/null
flex_version=$(cat flex_version)
popd > /dev/null

#2. Define Flex SDK path
export FLEX_HOME="/opt/apache-flex-$flex_version"
export PLAYERGLOBAL_HOME="$FLEX_HOME/frameworks/libs/player"
export PATH="$PATH:$FLEX_HOME/bin"

#3. del content of doc folder
mkdir -p ../../doc/
rm -rf ../../doc/*

#4. Build swc
pushd ../../src/xvm > /dev/null
./build-swc-wg.sh
popd > /dev/null

#5. Build doc
asdoc -source-path ../../src/xvm/src -doc-sources ../../src/xvm/src -library-path+="$PLAYERGLOBAL_HOME/10.2/playerglobal.swc" -library-path+=../../src/xvm/lib -output ../../doc

#6. del lib folder
rm -rf ../../src/xvm/lib/
