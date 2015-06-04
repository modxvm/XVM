#!/bin/bash

# XVM team (c) www.modxvm.com 2014-2015
# XVM nightly build system

currentdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$currentdir"
source ../../../build/library.sh

extend_path()
{
	PATH="$currentdir"/../../../build/bin/"$OS"_"$arch"/:$PATH
}

patch_as2(){
    echo ""
    echo "Patching AS2 files"

    mkdir -p temp
    for proj in *.patch
        do
            proj="${proj%%.*}"
            echo "Patching $proj"
            patch_as2_h $proj
        done
    rm -r temp
}

detect_os
detect_arch
extend_path
detect_patch
detect_swfmill

patch_as2
