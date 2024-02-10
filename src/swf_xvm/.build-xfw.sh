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

class="com.xfw.XfwView"
build_as3_swc \
    -inline \
    -source-path xfw \
    -external-library-path+=../swc_$XVMBUILD_FLAVOR/common-1.0-SNAPSHOT.swc \
    -external-library-path+=../swc_$XVMBUILD_FLAVOR/base_app-1.0-SNAPSHOT.swc \
    -external-library-path+=../swc_$XVMBUILD_FLAVOR/gui_base-1.0-SNAPSHOT.swc \
    -include-libraries+=../../~output/$XVMBUILD_FLAVOR/swc/xfw_shared.swc \
    -include-libraries+=../../~output/$XVMBUILD_FLAVOR/swc/xfw_access.swc \
    -output ../../~output/$XVMBUILD_FLAVOR/swc/xfw.swc \
    -include-classes $class

doc="xfw/com/xfw/XfwView.as"
build_as3_swf \
    -inline \
    -source-path xfw \
    -external-library-path+=../swc_$XVMBUILD_FLAVOR/common-1.0-SNAPSHOT.swc \
    -external-library-path+=../swc_$XVMBUILD_FLAVOR/base_app-1.0-SNAPSHOT.swc \
    -external-library-path+=../swc_$XVMBUILD_FLAVOR/gui_base-1.0-SNAPSHOT.swc \
    -include-libraries+=../../~output/$XVMBUILD_FLAVOR/swc/xfw_shared.swc \
    -include-libraries+=../../~output/$XVMBUILD_FLAVOR/swc/xfw_access.swc \
    -output ../../~output/$XVMBUILD_FLAVOR/swf/xfw.swf \
    $doc
