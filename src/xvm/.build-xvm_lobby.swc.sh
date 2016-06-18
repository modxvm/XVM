#!/bin/bash

# XVM team (c) www.modxvm.com 2014-2016
# XVM build system

currentdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$currentdir"/../../build/library.sh

detect_os
detect_flex

#xfw.swc
frswc="$FLEX_HOME/frameworks/libs/framework.swc"
class="com.xvm.lobby.LobbyXvmMod"
"$XVMBUILD_COMPC_FILEPATH" \
    -framework="$FLEX_HOME/frameworks" \
    -source-path xvm_lobby \
    -external-library-path+="$frswc" \
    -external-library-path+=../xfw/~output/swc/wg_lobby.swc \
    -external-library-path+=../xfw/~output/swc/xfw.swc \
    -external-library-path+=../../~output/swc/xvm_main.swc \
    -output ../../~output/swc/xvm_lobby.swc \
    -include-classes $class
