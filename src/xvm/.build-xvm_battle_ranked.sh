#!/bin/bash

# XVM team (c) https://modxvm.com 2014-2019
# XVM build system

set -e

currentdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$currentdir"/../../src/xfw/build/library.sh

detect_os
detect_actionscript_sdk

doc="xvm_battle/com/xvm/battle/BattleXvmApp.as"
build_as3_swf \
    -source-path xvm_battle \
    -source-path xvm_battle_ranked \
    -external-library-path+=../xfw/~output/swc/wg_battle.swc \
    -external-library-path+=../xfw/~output/swc/wg_battle_ranked_ui.swc \
    -external-library-path+=../xfw/~output/swc/xfw.swc \
    -include-libraries+=../../~output/swc/xvm_shared.swc \
    -include-libraries+=../../~output/swc/xvm_app.swc \
    -include-libraries+=swc/greensock.swc \
    -output ../../~output/res_mods/mods/xfw_packages/xvm_battle/as_battle_ranked/xvm_battle_ranked.swf \
    $doc

