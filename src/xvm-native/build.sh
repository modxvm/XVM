#!/bin/bash

# XVM Native ping module

currentdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$currentdir"/../../build/library.sh

copy()
{
    mkdir -p "$currentdir/../../~output/mods/packages/"
    cp -rf "$currentdir/release/packages/" "$currentdir/../../~output/mods/"

    mkdir -p "$currentdir/../../~output/mods/xfw/"
    cp -rf "$currentdir/release/xfw/" "$currentdir/../../~output/mods/"

    cp -rf "$currentdir/libpython/release/libpython/bin/python27.pyd" "$currentdir/../../~output/mods/xfw/native/python27.pyd"
    cp -rf "$currentdir/libpython/release/modules/bin/_ctypes.pyd" "$currentdir/../../~output/mods/xfw/native/_ctypes.pyd"
}

copy