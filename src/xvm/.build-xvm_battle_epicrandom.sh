#!/bin/bash

# XVM Team (c) https://modxvm.com 2014-2019
# XVM build system

set -e

currentdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$currentdir/../../build_lib/library.sh"

detect_os
detect_actionscript_sdk

doc="xvm_battle/com/xvm/battle/BattleXvmApp.as"
build_as3_swf \
    -inline \
    -source-path xvm_battle \
    -source-path xvm_battle_epicrandom \
    -external-library-path+=../../~output/xfw/swc/wg_battle.swc \
    -external-library-path+=../../~output/xfw/swc/wg_battle_epicrandom_ui.swc \
    -external-library-path+=../../~output/xfw/swc/xfw.swc \
    -include-libraries+=../../~output/xvm/swc/xvm_shared.swc \
    -include-libraries+=../../~output/xvm/swc/xvm_app.swc \
    -include-libraries+=swc/greensock.swc \
    -output ../../~output/xvm/res_mods/mods/xfw_packages/xvm_battle/as_battle_epicrandom/xvm_battle_epicrandom.swf \
    $doc

