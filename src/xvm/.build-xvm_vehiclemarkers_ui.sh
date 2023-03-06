#!/bin/bash

# XVM Team (c) https://modxvm.com 2014-2021
# XVM build system

set -e

currentdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
XVMBUILD_ROOT_PATH="$currentdir/../../"

# $XVMBUILD_FLAVOR
if [[ "$XVMBUILD_FLAVOR" == "" ]]; then
    export XVMBUILD_FLAVOR="wg"
fi

source "$XVMBUILD_ROOT_PATH/build_lib/library.sh"

detect_os
detect_actionscript_sdk

doc="xvm_vehiclemarkers_ui/com/xvm/vehiclemarkers/ui/XvmVehicleMarkersMod.as"
build_as3_swf \
    -inline \
    -source-path xvm_vehiclemarkers_ui \
    -external-library-path+=../swc_$XVMBUILD_FLAVOR/common-1.0-SNAPSHOT.swc \
    -external-library-path+=../swc_$XVMBUILD_FLAVOR/gui_base-1.0-SNAPSHOT.swc \
    -external-library-path+=../swc_$XVMBUILD_FLAVOR/gui_battle-1.0-SNAPSHOT.swc \
    -external-library-path+=../../~output/$XVMBUILD_FLAVOR/xfw/swc/wg_vm_ui.swc \
    -include-libraries+=../../~output/$XVMBUILD_FLAVOR/xfw/swc/xfw_shared.swc \
    -include-libraries+=../../~output/$XVMBUILD_FLAVOR/xvm/swc/xvm_shared.swc \
    -output ../../~output/$XVMBUILD_FLAVOR/xvm/res_mods/mods/xfw_packages/xvm_battle/as_battle/xvm_vehiclemarkers_ui.swf \
    $doc
