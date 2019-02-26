#!/bin/bash

# XVM team (c) https://modxvm.com 2014-2019
# XVM build system

set -e

currentdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$currentdir"/../../src/xfw/build/library.sh

detect_os
detect_actionscript_sdk

doc="xvm_vehiclemarkers_ui/com/xvm/vehiclemarkers/ui/XvmVehicleMarkersMod.as"
build_as3_swf \
    -source-path xvm_vehiclemarkers_ui \
    -external-library-path+=../xfw/~output/swc/wg_vm.swc \
    -include-libraries+=../xfw/~output/swc/xfw_shared.swc \
    -include-libraries+=../../~output/swc/xvm_shared.swc \
    -include-libraries+=swc/greensock.swc \
    -output ../../~output/res_mods/mods/xfw_packages/xvm_battle/as_battle/xvm_vehiclemarkers_ui.swf \
    $doc

