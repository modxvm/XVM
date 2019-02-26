#!/bin/bash

# XVM team (c) https://modxvm.com 2014-2019
# XVM build system

set -e

currentdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$currentdir"/../../src/xfw/build/library.sh

detect_os
detect_actionscript_sdk

class="com.xvm.XvmAppBase"
build_as3_swc \
    -source-path xvm_app \
    -external-library-path+=../xfw/~output/swc/wg_shared.swc \
    -external-library-path+=../xfw/~output/swc/xfw.swc \
    -external-library-path+=../../~output/swc/xvm_shared.swc \
    -output ../../~output/swc/xvm_app.swc \
    -include-classes $class
