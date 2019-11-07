#!/bin/bash

# XVM Team (c) https://modxvm.com 2014-2019
# XVM build system

set -e

currentdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$currentdir/../../build_lib/library.sh"

detect_os
detect_actionscript_sdk

class="com.xvm.Xvm"
build_as3_swc \
    -inline \
    -source-path xvm_shared \
    -external-library-path+=../../~output/xfw/swc/wg_shared.swc \
    -external-library-path+=../../~output/xfw/swc/xfw_shared.swc \
    -include-libraries+=swc/greensock.swc \
    -output ../../~output/xvm/swc/xvm_shared.swc \
    -include-classes $class
