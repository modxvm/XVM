#!/bin/bash

# SPDX-License-Identifier: LGPL-3.0-or-later
# Copyright (c) 2013-2024 XVM Contributors

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

doc="xvm_battle/com/xvm/battle/BattleXvmApp.as"
build_as3_swf \
    -inline \
    -source-path xvm_battle \
    -source-path xvm_battle_event_special \
    -external-library-path+=../swc_$XVMBUILD_FLAVOR/common-1.0-SNAPSHOT.swc \
    -external-library-path+=../swc_$XVMBUILD_FLAVOR/common_i18n_library-1.0-SNAPSHOT.swc \
    -external-library-path+=../swc_$XVMBUILD_FLAVOR/base_app-1.0-SNAPSHOT.swc \
    -external-library-path+=../swc_$XVMBUILD_FLAVOR/gui_base-1.0-SNAPSHOT.swc \
    -external-library-path+=../swc_$XVMBUILD_FLAVOR/gui_battle-1.0-SNAPSHOT.swc \
    -external-library-path+=../../~output/$XVMBUILD_FLAVOR/swc/xfw.swc \
    -include-libraries+=../../~output/$XVMBUILD_FLAVOR/swc/xvm_shared.swc \
    -include-libraries+=../../~output/$XVMBUILD_FLAVOR/swc/xvm_app.swc \
    -output ../../~output/$XVMBUILD_FLAVOR/xvm/res_mods/mods/xfw_packages/xvm_battle/as_battle_event_special/xvm_battle_event_special.swf \
    $doc
