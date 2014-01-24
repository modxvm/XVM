#!/bin/bash

#XVM .swf builder for Linux
#Part of XVM build system
#Do not change anything in this file if you are not sure

projects=(
          'wg'
          'xvm'
          'xvm-autologin'
          'xvm-company'
          'xvm-crew'
          'xvm-hangar'
          'xvm-loginlayout'
          'xvm-ping'
          'xvm-profile'
          'xvm-squad'
          'xvm-tcarousel'
          'xvm-techtree'
         )

pushd ../../../src/xvm/ > /dev/null

#you need to "git clone git://github.com/nexussays/playerglobal.git $FLEX_HOME/frameworks/libs/player" first
export PLAYERGLOBAL_HOME=$FLEX_HOME/frameworks/libs/player 
export PATH=$PATH:../../utils/build-system-linux/bin/:$FLEX_HOME/bin/

for (( i=0; i<${#projects[@]}; i++ ));
  do
    mono ../../utils/build-system-linux/bin/fdbuild-as3.exe -compiler:"$FLEX_HOME" -cp:"" "${projects[$i]}.as3proj"
  done

rm -rf lib/*
rm -rf obj

popd > /dev/null
