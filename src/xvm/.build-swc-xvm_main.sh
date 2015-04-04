#!/bin/bash

# XVM team (c) www.modxvm.com 2014-2015
# XFW Framework build system

# detect OS
if [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ] || [ "$OS" == "Windows_NT" ]; then
  xfw_OS=Windows
elif [ "$(expr substr $(uname -s) 1 4)" == "MSYS" ]; then
  xfw_OS=Windows
fi
#

# add Flex to PATH
if [ "$xfw_OS" = "Windows" ]; then
  if [ "$FLEX_HOME" = "" ]; then
    FLEX_HOME="$LOCALAPPDATA/FlashDevelop/Apps/flexsdk/4.6.0"
  fi
fi
if [ "$PLAYERGLOBAL_HOME" = "" ]; then
  export PLAYERGLOBAL_HOME=$FLEX_HOME/frameworks/libs/player 
fi
compc="$FLEX_HOME/bin/compc"
PATH=$FLEX_HOME/bin:$PATH
#

#xfw.swc
frswc="$FLEX_HOME/frameworks/libs/framework.swc"
class="com.xvm.Xvm"
"$compc" \
    -framework="$FLEX_HOME/frameworks" \
    -source-path xvm_main \
    -external-library-path+="$frswc" \
    -external-library-path+=../xfw/~output/swc/wg.swc \
    -external-library-path+=../xfw/~output/swc/xfw.swc \
    -output ../../~output/swc/xvm_main.swc \
    -include-classes $class
