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

class="com.xvm.XvmAppBase"
build_as3_swc \
    -inline \
    -source-path xvm_app \
    -external-library-path+=../swc_$XVMBUILD_FLAVOR/common-1.0-SNAPSHOT.swc \
    -external-library-path+=../swc_$XVMBUILD_FLAVOR/base_app-1.0-SNAPSHOT.swc \
    -external-library-path+=../swc_$XVMBUILD_FLAVOR/gui_base-1.0-SNAPSHOT.swc \
    -external-library-path+=../../~output/$XVMBUILD_FLAVOR/swc/xfw.swc \
    -external-library-path+=../../~output/$XVMBUILD_FLAVOR/swc/xvm_shared.swc \
    -output ../../~output/$XVMBUILD_FLAVOR/swc/xvm_app.swc \
    -include-classes $class
