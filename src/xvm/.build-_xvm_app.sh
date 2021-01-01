#!/bin/bash

# XVM Team (c) https://modxvm.com 2014-2021
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
    -external-library-path+=../../~output/xfw/swc/wg_shared.swc \
    -external-library-path+=../../~output/xfw/swc/xfw.swc \
    -external-library-path+=../../~output/xvm/swc/xvm_shared.swc \
    -output ../../~output/xvm/swc/xvm_app.swc \
    -include-classes $class
