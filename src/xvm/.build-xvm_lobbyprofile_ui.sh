#!/bin/bash

# XVM Team (c) https://modxvm.com 2014-2020
# XVM build system

set -e

currentdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$currentdir/../../build_lib/library.sh"

detect_os
detect_actionscript_sdk

doc="xvm_lobbyprofile_ui/com/xvm/lobby/ui/LobbyProfileUIMod.as"
build_as3_swf \
    -inline \
    -source-path xvm_lobbyprofile_ui \
    -external-library-path+=../wg_swc/common-1.0-SNAPSHOT.swc \
    -external-library-path+=../wg_swc/common_i18n_library-1.0-SNAPSHOT.swc \
    -external-library-path+=../wg_swc/base_app-1.0-SNAPSHOT.swc \
    -external-library-path+=../wg_swc/gui_base-1.0-SNAPSHOT.swc \
    -external-library-path+=../wg_swc/gui_lobby-1.0-SNAPSHOT.swc \
    -external-library-path+=../../~output/xfw/swc/wg_lobby_ui.swc \
    -external-library-path+=../../~output/xfw/swc/xfw.swc \
    -external-library-path+=../../~output/xvm/swc/xvm_lobby.swc \
    -output ../../~output/xvm/res_mods/mods/xfw_packages/xvm_lobby/as_lobby/xvm_lobbyprofile_ui.swf \
    $doc
