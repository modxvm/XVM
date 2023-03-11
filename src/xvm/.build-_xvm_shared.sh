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

class="com.xvm.Xvm"
build_as3_swc \
    -inline \
    -source-path xvm_shared \
    -external-library-path+=../swc_$XVMBUILD_FLAVOR/common-1.0-SNAPSHOT.swc \
    -external-library-path+=../../~output/$XVMBUILD_FLAVOR/swc/xfw_shared.swc \
    -output ../../~output/$XVMBUILD_FLAVOR/swc/xvm_shared.swc \
    -include-classes $class
