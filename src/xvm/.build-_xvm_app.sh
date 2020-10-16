#!/bin/bash

# XVM Team (c) https://modxvm.com 2014-2020
# XVM build system

set -e

currentdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$currentdir/../../build_lib/library.sh"

detect_os
detect_actionscript_sdk

class="com.xvm.XvmAppBase"
build_as3_swc \
    -inline \
    -source-path xvm_app \
    -external-library-path+=../wg_swc/common-1.0-SNAPSHOT.swc \
    -external-library-path+=../wg_swc/base_app-1.0-SNAPSHOT.swc \
    -external-library-path+=../wg_swc/gui_base-1.0-SNAPSHOT.swc \
    -external-library-path+=../../~output/xfw/swc/xfw.swc \
    -external-library-path+=../../~output/xvm/swc/xvm_shared.swc \
    -output ../../~output/xvm/swc/xvm_app.swc \
    -include-classes $class
