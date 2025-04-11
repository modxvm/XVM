#!/bin/bash

# SPDX-License-Identifier: LGPL-3.0-or-later
# Copyright (c) 2013-2025 XVM Contributors

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

class="\$AppLinks"
build_as3_swc \
    -source-path battle_ui/frontline \
    -source-path battle_ui/ui/* \
    -external-library-path+=../swc_$XVMBUILD_FLAVOR/common-1.0-SNAPSHOT.swc \
    -external-library-path+=../swc_$XVMBUILD_FLAVOR/common_i18n_library-1.0-SNAPSHOT.swc \
    -external-library-path+=../swc_$XVMBUILD_FLAVOR/gui_base-1.0-SNAPSHOT.swc \
    -external-library-path+=../swc_$XVMBUILD_FLAVOR/gui_battle-1.0-SNAPSHOT.swc \
    -external-library-path+=../swc_$XVMBUILD_FLAVOR/frontline_common_i18n_library-1.0-SNAPSHOT.swc \
    -external-library-path+=../swc_$XVMBUILD_FLAVOR/frontline_gui_battle-1.0-SNAPSHOT.swc \
    -output ../../~output/$XVMBUILD_FLAVOR/swc/wg_battle_frontline_ui.swc \
    -include-classes $class
