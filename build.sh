#!/bin/bash

# This file is part of the XVM project.
#
# Copyright (c) 2014-2021 XVM Team.
#
# XVM is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as
# published by the Free Software Foundation, version 3.
#
# XVM is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#


##########################
#  PREPARE ENVIRONMENT   #
##########################

set -e

XVMBUILD_ROOT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$XVMBUILD_ROOT_PATH"

source ./build_lib/library.sh
source ./build/xvm-build.conf


##########################
####      CONFIG      ####
##########################

#$XVMBUILD_DEVELOPMENT
if [[ "$XVMBUILD_DEVELOPMENT" =~ ^(True|False)$ ]];
then
    echo '$XVMBUILD_DEVELOPMENT = '"$XVMBUILD_DEVELOPMENT"
else
    echo '$XVMBUILD_DEVELOPMENT ($IS_DEV_BUILD) must be exactly "True" or "False" (capitalized for Python)'
    echo 'See /build/xvm-build.conf for more info'
    exit 1
fi

# $XFW_BUILD_CLEAR
if [ "$XFW_BUILD_CLEAR" == "" ]; then
  export XFW_BUILD_CLEAR=1
fi

# $XFW_BUILD_LIBS
if [ "$XFW_BUILD_LIBS" == "" ]; then
  export XFW_BUILD_LIBS=1
fi

# $XVMBUILD_L10N_URL
if [[ "$XVMBUILD_L10N_URL" == "" ]]; then
    export XVMBUILD_L10N_URL="https://translate.modxvm.com/downloads/xvm-client/xvm-client-l10n_json.zip"
fi

# $XVMBUILD_FLAVOR
if [[ "$XVMBUILD_FLAVOR" == "" ]]; then
    export XVMBUILD_FLAVOR="wg"
fi

##########################
#### HELPER FUNCTIONS ####
##########################

#deletes temporary folders with hash calculation results
clean_sha1()
{
    pushd "$XVMBUILD_ROOT_PATH" > /dev/null
    rm -rf ~output/$XVMBUILD_FLAVOR/xvm/cmp/
    rm -rf ~output/$XVMBUILD_FLAVOR/xvm/res_mods/cmp/
    rm -rf ~output/$XVMBUILD_FLAVOR/xvm/sha1/
    rm -rf ~output/$XVMBUILD_FLAVOR/xfw/sha1/
    rm -rf ~output/$XVMBUILD_FLAVOR/xfw/cmp/
    popd > /dev/null
}

#extends PATH system environment variable
extend_path()
{
    export PATH=$PATH:"$XVMBUILD_ROOT_PATH"/build_lib/bin/java/:"$XVMBUILD_ROOT_PATH"/build_lib/bin/msil/:"$XVMBUILD_ROOT_PATH"/build_lib/bin/"$OS"_"$arch"/
}

##########################
####  BUILD FUNCTIONS ####
##########################

function build_swc_ui()
{
    echo ""
    echo "Building SWC UI"

    pushd src/swc_ui > /dev/null
    ./build.sh || exit 1
    popd > /dev/null
}

function build_xfw_actionscript()
{
    echo ""
    echo "Building XFW Actionscript"

    pushd src/xfw_actionscript > /dev/null
    ./build.sh || exit 1
    popd > /dev/null
}

function build_xfw_packages()
{
    echo ""
    echo "Building XFW Packages"

    pushd src/xfw_packages > /dev/null
    ./build.sh || exit 1
    popd > /dev/null

    mkdir -p "~output/$XVMBUILD_FLAVOR/deploy/mods/$XVMBUILD_WOT_VERSION/com.modxvm.xfw/"
    cp -rf ~output/$XVMBUILD_FLAVOR/xfw/wotmod/*.wotmod "~output/$XVMBUILD_FLAVOR/deploy/mods/$XVMBUILD_WOT_VERSION/com.modxvm.xfw/"
}

function build_xfw_swf()
{
    echo ""
    echo "Building XFW SWF"

    pushd src/swf_$XVMBUILD_FLAVOR > /dev/null
    ./build.sh || exit 1
    popd > /dev/null
}

function build_xvm_actionscript(){
    echo ""
    echo "Building XVM actionscript"

    pushd src/xvm/ > /dev/null

    top="
        _xvm_shared
        _xvm_app
        xvm_lobby
    "

    for proj in $top; do
        echo "Building $proj"
        # shellcheck source=/dev/null
        . ".build-${proj}.sh"
    done

    for proj in *.as3proj; do
        exists=0
        proj=${proj%.*}
        for e in $top; do [[ "$e" == "$proj" ]] && { exists=1; break; } done
        if [ $exists -eq 0 ]; then
            echo "Building $proj"
            # shellcheck source=/dev/null
            . ".build-${proj}.sh"
        fi
    done

    mkdir -p  "$XVMBUILD_ROOT_PATH/~output/$XVMBUILD_FLAVOR/deploy/res_mods/mods/xfw_packages/"
    cp -rf $XVMBUILD_ROOT_PATH/~output/$XVMBUILD_FLAVOR/xvm/res_mods/mods/xfw_packages/* "$XVMBUILD_ROOT_PATH/~output/$XVMBUILD_FLAVOR/deploy/res_mods/mods/xfw_packages/"

    popd > /dev/null
}

function build_xvm_python()
{
    echo ""
    echo "Building XVM Python"

    pushd src/xpm > /dev/null

    export XPM_CLEAR=0
    export XPM_RUN_TEST=0

    ./build.sh

    unset XPM_CLEAR
    unset XPM_RUN_TEST

    mkdir -p  "$XVMBUILD_ROOT_PATH/~output/$XVMBUILD_FLAVOR/deploy/res_mods/mods/xfw_packages/"
    cp -rf $XVMBUILD_ROOT_PATH/~output/$XVMBUILD_FLAVOR/xvm/res_mods/mods/xfw_packages/* "$XVMBUILD_ROOT_PATH/~output/$XVMBUILD_FLAVOR/deploy/res_mods/mods/xfw_packages/"

    popd >/dev/null
}

function download_translations()
{
    echo ""
    echo "Download translations..."

    mkdir -p "$XVMBUILD_ROOT_PATH/~output/$XVMBUILD_FLAVOR/deploy/res_mods/mods/shared_resources/xvm/l10n/"
    pushd "$XVMBUILD_ROOT_PATH/~output/$XVMBUILD_FLAVOR/deploy/res_mods/mods/shared_resources/xvm/l10n/" >/dev/null
    mkdir -p temp
    cd temp
    wget --output-document=l10n.zip "$XVMBUILD_L10N_URL"
    unzip -o l10n.zip >/dev/null
    rm l10n.zip ru.xc
    rm -f en.xc
    cd ..
    mv temp/* ./
    rm -rf temp/
    popd >/dev/null
}

#calculates hashes for XVM files
calc_hash_for_xvm_integrity()
{
    echo ""
    echo "Calculating hashes for xvm_integrity"

    pushd ~output/$XVMBUILD_FLAVOR/deploy > /dev/null

    hash_dir='res_mods/mods/xfw_packages/xvm_integrity/python'
    hash_file="$hash_dir/hash_table.py"
    rm -rf "$hash_file"
    mkdir -p "$hash_dir"

    echo -e '""" Generated automatically by XVM builder """\nHASH_DATA = {' > $hash_file
    find res_mods -name '*.py' -print0 -o -name '*.pyc' -print0 -o -name '*.swf' -print0 | while read -d $'\0' file
    do
        sha1sum "$file" | sed -r "s/(\S+)\s+\*?(.+)/'\2': '\1',/" >> $hash_file
    done
    echo "}" >> $hash_file
    popd >/dev/null
}

#copies non-binary files and fix directory layout
copy_files()
{
    echo ""
    echo "Copy files..."

    # rename version-dependent folder
    mkdir -p "$XVMBUILD_ROOT_PATH/~output/$XVMBUILD_FLAVOR/deploy/res_mods/$XVMBUILD_WOT_VERSION"
    mkdir -p  "$XVMBUILD_ROOT_PATH/~output/$XVMBUILD_FLAVOR/deploy/res_mods/mods/shared_resources/xvm/"

    # cp non-binary files
    cp -rf "$XVMBUILD_ROOT_PATH"/release/* "$XVMBUILD_ROOT_PATH/~output/$XVMBUILD_FLAVOR/deploy/res_mods/mods/shared_resources/xvm/"

    #move config
    rm -rf "$XVMBUILD_ROOT_PATH/~output/$XVMBUILD_FLAVOR/deploy/res_mods/configs/xvm/"
    mkdir -p  "$XVMBUILD_ROOT_PATH/~output/$XVMBUILD_FLAVOR/deploy/res_mods/configs/xvm/"
    mv $XVMBUILD_ROOT_PATH/~output/$XVMBUILD_FLAVOR/deploy/res_mods/mods/shared_resources/xvm/configs/* "$XVMBUILD_ROOT_PATH/~output/$XVMBUILD_FLAVOR/deploy/res_mods/configs/xvm/"
    rm -r "$XVMBUILD_ROOT_PATH/~output/$XVMBUILD_FLAVOR/deploy/res_mods/mods/shared_resources/xvm/configs/"

    # put readmes on root
    pushd "$XVMBUILD_ROOT_PATH/~output/$XVMBUILD_FLAVOR/deploy/res_mods/mods/shared_resources/xvm/doc/" > /dev/null
    find . -name "readme-*.txt" -exec cp {} ../../../../../ \;
    popd > /dev/null
}

##########################
####  BUILD PIPELINE  ####
##########################

pushd "$XVMBUILD_ROOT_PATH" >/dev/null

#detect OS and dependencies
detect_os
detect_arch

extend_path

detect_git
detect_java
detect_zip
detect_patch
detect_python
detect_unzip
detect_wget
detect_ffdec

#build components
args="$*"
args="${args:=swc_ui xfw_actionscript xfw_swf xfw_packages xvm_actionscript xvm_python pack}" # default - build all

if [[ " $args " =~ " swc_ui " ]]; then
    detect_actionscript_sdk
    build_swc_ui
fi

if [[ " $args " =~ " xfw_actionscript " ]]; then
    detect_actionscript_sdk
    build_xfw_actionscript
fi

if [[ " $args " =~ " xfw_swf " ]]; then
    build_xfw_swf
fi

if [[ " $args " =~ " xfw_packages " ]]; then
    build_xfw_packages
fi

if [[ " $args " =~ " xvm_python " ]]; then
    build_xvm_python
fi

if [[ " $args " =~ " xvm_actionscript " ]]; then
    detect_actionscript_sdk
    build_xvm_actionscript
fi

if [[ " $args " =~ " pack " && "$XFW_DEVELOPMENT" == "" ]]; then
    clean_sha1
    download_translations
    copy_files
    calc_hash_for_xvm_integrity
fi

popd >/dev/null
