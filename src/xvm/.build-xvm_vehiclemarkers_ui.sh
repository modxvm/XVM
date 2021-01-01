#!/bin/bash

# XVM Team (c) https://modxvm.com 2014-2021
# XVM build system

set -e

currentdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$currentdir/../../build_lib/library.sh"

detect_os
detect_actionscript_sdk

doc="xvm_vehiclemarkers_ui/com/xvm/vehiclemarkers/ui/XvmVehicleMarkersMod.as"
build_as3_swf \
    -inline \
    -source-path xvm_vehiclemarkers_ui \
    -external-library-path+=../../~output/xfw/swc/wg_vm.swc \
    -include-libraries+=../../~output/xfw/swc/xfw_shared.swc \
    -include-libraries+=../../~output/xvm/swc/xvm_shared.swc \
    -include-libraries+=swc/greensock.swc \
    -output ../../~output/xvm/res_mods/mods/xfw_packages/xvm_battle/as_battle/xvm_vehiclemarkers_ui.swf \
    $doc
