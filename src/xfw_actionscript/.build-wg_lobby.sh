#!/bin/bash

# XVM Team (c) https://modxvm.com 2014-2021
# XFW Framework build system

set -e

currentdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$currentdir"/../../build_lib/library.sh

detect_os
detect_actionscript_sdk

class="App"
build_as3_swc \
    -source-path wg/lobby \
    -source-path wg/lobby_links \
    -source-path wg/lobby_ui/* \
    -source-path wg/common_i18n \
    -output ../../~output/xfw/swc/wg_lobby.swc \
    -include-classes $class
