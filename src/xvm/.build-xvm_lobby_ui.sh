#!/bin/bash

# XVM Team (c) https://modxvm.com 2014-2019
# XVM build system

set -e

currentdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$currentdir/../../build_lib/library.sh"

detect_os
detect_actionscript_sdk

doc="xvm_lobby_ui/com/xvm/lobby/ui/LobbyUIMod.as"
build_as3_swf \
    -inline \
    -source-path xvm_lobby_ui \
    -external-library-path+=../../~output/xfw/swc/wg_lobby.swc \
    -external-library-path+=../../~output/xfw/swc/xfw.swc \
    -external-library-path+=../../~output/xvm/swc/xvm_lobby.swc \
    -output ../../~output/xvm/res_mods/mods/xfw_packages/xvm_lobby/as_lobby/xvm_lobby_ui.swf \
    $doc

