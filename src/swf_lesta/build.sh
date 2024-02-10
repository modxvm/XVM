#!/bin/bash

# SPDX-License-Identifier: LGPL-3.0-or-later
# Copyright (c) 2013-2024 XVM Contributors

##########################
#  PREPARE ENVIRONMENT   #
##########################

currentdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$currentdir"/../../build_lib/library.sh

# $XVMBUILD_FLAVOR
if [[ "$XVMBUILD_FLAVOR" == "" ]]; then
    export XVMBUILD_FLAVOR="wg"
fi

detect_os
detect_arch

PATH="$currentdir"/../../build_lib/bin/"$OS"_"$arch"/:$PATH

detect_patch


##########################
####      CONFIG      ####
##########################

#EXTRACT_ONLY=1

files=(
  'battle'
  'battleVehicleMarkersApp'
  'lobby'
)

if [ "$XVMBUILD_ROOT_PATH" == "" ]; then
  XVMBUILD_ROOT_PATH="$currentdir/../.."
fi

if [ "$XVMBUILD_XFW_WG_OUTPUTPATH" == "" ]; then
  XVMBUILD_XFW_WG_OUTPUTPATH="~output/$XVMBUILD_FLAVOR/swf"
fi


##########################
####  BUILD PIPELINE  ####
##########################

for (( i=0; i<${#files[@]}; i++ )); do
    name=${files[$i]}
    rm -rf $name.orig-0 $name.orig-0.abc $name.orig.swf
    cp -f flash/$name.swf .
done

for file in *.swf
do
  mv "$file" "${file%.swf}.orig.swf"
done

for (( i=0; i<${#files[@]}; i++ )); do
    name=${files[$i]}
    echo "patching $name.swf"

    abcexport $name.orig.swf
    rabcdasm $name.orig-0.abc

    [ "$EXTRACT_ONLY" = "1" ] && continue

    for patch_filename in $name.*.patch; do
        echo "=> $patch_filename"
        patch --binary -p0 < $patch_filename || exit 1
    done

    rabcasm $name.orig-0/$name.orig-0.main.asasm
    abcreplace $name.orig.swf 0 $name.orig-0/$name.orig-0.main.abc

    mkdir -p "$XVMBUILD_ROOT_PATH"/"$XVMBUILD_XFW_WG_OUTPUTPATH"

    #TODO: disabled, because of the strange behavior on WoT 1.1
    #mv $name.orig.swf "$XVMBUILD_ROOT_PATH"/"$XVMBUILD_XFW_WG_OUTPUTPATH"/xfw_$name.swf
    mv $name.orig.swf "$XVMBUILD_ROOT_PATH"/"$XVMBUILD_XFW_WG_OUTPUTPATH"/$name.swf

    [ "$DONT_DELETE" = "1" ] && continue
    rm $name.orig-0.abc
    rm -rf $name.orig-0

done

echo ""
