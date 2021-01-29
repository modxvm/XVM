#!/bin/bash

# XVM Team (c) https://modxvm.com 2014-2021
# XVM build system

set -e

currentdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
XVMBUILD_ROOT_PATH="$currentdir/../../"

source "$XVMBUILD_ROOT_PATH/build_lib/library.sh"

detect_os
detect_actionscript_sdk

class="com.xvm.lobby.LobbyXvmApp"
build_as3_swc \
    -inline \
    -source-path xvm_lobby \
    -external-library-path+=../wg_swc/common-1.0-SNAPSHOT.swc \
    -external-library-path+=../wg_swc/common_i18n_library-1.0-SNAPSHOT.swc \
    -external-library-path+=../wg_swc/base_app-1.0-SNAPSHOT.swc \
    -external-library-path+=../wg_swc/gui_base-1.0-SNAPSHOT.swc \
    -external-library-path+=../wg_swc/gui_lobby-1.0-SNAPSHOT.swc \
    -external-library-path+=../../~output/xfw/swc/wg_lobby_ui.swc \
    -external-library-path+=../../~output/xfw/swc/xfw.swc \
    -include-libraries+=../../~output/xvm/swc/xvm_shared.swc \
    -include-libraries+=../../~output/xvm/swc/xvm_app.swc \
    -output ../../~output/xvm/swc/xvm_lobby.swc \
    -include-classes $class

doc="xvm_lobby/com/xvm/lobby/LobbyXvmApp.as"
build_as3_swf \
    -inline \
    -source-path xvm_lobby \
    -external-library-path+=../wg_swc/common-1.0-SNAPSHOT.swc \
    -external-library-path+=../wg_swc/common_i18n_library-1.0-SNAPSHOT.swc \
    -external-library-path+=../wg_swc/base_app-1.0-SNAPSHOT.swc \
    -external-library-path+=../wg_swc/gui_base-1.0-SNAPSHOT.swc \
    -external-library-path+=../wg_swc/gui_lobby-1.0-SNAPSHOT.swc \
    -external-library-path+=../../~output/xfw/swc/wg_lobby_ui.swc \
    -external-library-path+=../../~output/xfw/swc/xfw.swc \
    -include-libraries+=../../~output/xvm/swc/xvm_shared.swc \
    -include-libraries+=../../~output/xvm/swc/xvm_app.swc \
    -output ../../~output/xvm/res_mods/mods/xfw_packages/xvm_lobby/as_lobby/xvm_lobby.swf \
    $doc
