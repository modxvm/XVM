#!/bin/bash

# XVM team (c) https://modxvm.com 2014-2019
# XVM build system

set -e

currentdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$currentdir"/../../src/xfw/build/library.sh

detect_os
detect_actionscript_sdk

doc="xvm_lobby_ui/com/xvm/lobby/ui/LobbyUIMod.as"
build_as3_swf \
    -target-player $SWC_PLAYER_VERSION \
    -swf-version $SWC_SWF_VERSION \
    -source-path xvm_lobby_ui \
    -external-library-path+=../xfw/~output/swc/wg_lobby.swc \
    -external-library-path+=../xfw/~output/swc/xfw.swc \
    -external-library-path+=../../~output/swc/xvm_lobby.swc \
    -output ../../~output/res_mods/mods/xfw_packages/xvm_lobby/as_lobby/xvm_lobby_ui.swf \
    $doc

