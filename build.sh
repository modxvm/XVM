#!/bin/bash

# This file is part of the XVM project.
#
# Copyright (c) 2014-2023 XVM Team.
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

WOT_VERSION=$(echo '$XVMBUILD_WOT_VERSION_'"${XVMBUILD_FLAVOR}" | envsubst)

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

function build_swf_vendor()
{
    echo ""
    echo "Building SWF Vendor"

    pushd src/swf_$XVMBUILD_FLAVOR > /dev/null
    ./build.sh || exit 1
    popd > /dev/null
}

function build_swc_ui()
{
    echo ""
    echo "Building SWC UI"
    
    detect_actionscript_sdk

    pushd src/swc_ui > /dev/null
    ./build.sh || exit 1
    popd > /dev/null
}

function build_swf_xvm()
{
    echo ""
    echo "Building SWF XVM"
    
    

    pushd src/swf_xvm > /dev/null
    ./build.sh || exit 1
    popd > /dev/null

    mkdir -p  "$XVMBUILD_ROOT_PATH/~output/$XVMBUILD_FLAVOR/deploy/res_mods/mods/xfw_packages/"
    cp -rf $XVMBUILD_ROOT_PATH/~output/$XVMBUILD_FLAVOR/xvm/res_mods/mods/xfw_packages/* "$XVMBUILD_ROOT_PATH/~output/$XVMBUILD_FLAVOR/deploy/res_mods/mods/xfw_packages/"
}

function build_xfw_packages()
{
    echo ""
    echo "Building XFW Packages"

    pushd src/xfw_packages > /dev/null
    ./build.sh || exit 1
    popd > /dev/null

    mkdir -p "~output/$XVMBUILD_FLAVOR/deploy/mods/$WOT_VERSION/com.modxvm.xfw/"
    cp -rf ~output/$XVMBUILD_FLAVOR/wotmod/*.wotmod "~output/$XVMBUILD_FLAVOR/deploy/mods/$WOT_VERSION/com.modxvm.xfw/"
}

function build_python()
{
    echo ""
    echo "Building XVM Python"

    pushd src/python > /dev/null

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
    mkdir -p "$XVMBUILD_ROOT_PATH/~output/$XVMBUILD_FLAVOR/deploy/res_mods/$WOT_VERSION"
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
args="${args:=swf_vendor swc_ui swf_xvm xfw_packages python pack}" # default - build all

if [[ " $args " =~ " swf_vendor " ]]; then
    build_swf_vendor
fi

if [[ " $args " =~ " swc_ui " ]]; then
    build_swc_ui
fi

if [[ " $args " =~ " swf_xvm " ]]; then
    build_swf_xvm
fi

if [[ " $args " =~ " xfw_packages " ]]; then
    build_xfw_packages
fi

if [[ " $args " =~ " python " ]]; then
    build_python
fi

if [[ " $args " =~ " pack " && "$XFW_DEVELOPMENT" == "" ]]; then
    clean_sha1
    download_translations
    copy_files
    calc_hash_for_xvm_integrity
fi

popd >/dev/null
