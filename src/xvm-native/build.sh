#!/bin/bash

currentdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$currentdir"/../../build/library.sh

copy()
{
    mkdir -p "$currentdir/../../~output/mods/packages/"
    cp -rf "$currentdir/binaries/packages/" "$currentdir/../../~output/mods/"
}

copy