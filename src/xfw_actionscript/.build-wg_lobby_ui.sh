#!/bin/bash

# XVM Team (c) https://modxvm.com 2014-2020
# XFW Framework build system

set -e

currentdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
XVMBUILD_ROOT_PATH="$currentdir/../../"

source "$XVMBUILD_ROOT_PATH/build_lib/library.sh"

detect_os
detect_actionscript_sdk

class="\$AppLinks"
build_as3_swc \
    -source-path wg/lobby_links \
    -source-path wg/lobby_ui/* \
    -external-library-path+=../wg_swc/common-1.0-SNAPSHOT.swc \
    -external-library-path+=../wg_swc/common_i18n_library-1.0-SNAPSHOT.swc \
    -external-library-path+=../wg_swc/base_app-1.0-SNAPSHOT.swc \
    -external-library-path+=../wg_swc/gui_base-1.0-SNAPSHOT.swc \
    -external-library-path+=../wg_swc/gui_lobby-1.0-SNAPSHOT.swc \
    -output ../../~output/xfw/swc/wg_lobby_ui.swc \
    -include-classes $class
