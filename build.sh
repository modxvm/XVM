#!/bin/bash

# This file is part of the XVM project.
#
# Copyright (c) 2014-2020 XVM Team.
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

# $XVMBUILD_L10N_URL
if [[ "$XVMBUILD_L10N_URL" == "" ]]; then
    export XVMBUILD_L10N_URL="http://translate.modxvm.com/download/xvm-client/xvm-client-l10n_json.zip"
fi

##########################
#### HELPER FUNCTIONS ####
##########################

#deletes temporary folders with hash calculation results
clean_sha1()
{
    pushd "$XVMBUILD_ROOT_PATH" > /dev/null
    rm -rf ~output/xvm/cmp/
    rm -rf ~output/xvm/res_mods/cmp/
    rm -rf ~output/xvm/sha1/
    rm -rf ~output/xfw/sha1/
    rm -rf ~output/xfw/cmp/
    popd > /dev/null
}

#creates all needed directories
create_directories()
{
    pushd "$XVMBUILD_ROOT_PATH" > /dev/null
    mkdir -p ~output/xvm/res_mods/configs/xvm
    mkdir -p ~output/xvm/res_mods/mods/shared_resources/xvm/
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

#builds XVM ActionScript 3 files
build_as3(){
    echo ""
    echo "Building AS3 files"

    pushd "$XVMBUILD_ROOT_PATH"/src/xvm/ > /dev/null

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

    popd > /dev/null
}

#builds XVM Framework and copy XFW to ~output/
build_xfw()
{
    echo ""
    echo "Building XFW"

    pushd "$XVMBUILD_ROOT_PATH" >/dev/null
    ./build_xfw.sh
    popd >/dev/null

    pushd "$XVMBUILD_ROOT_PATH" >/dev/null
    mkdir -p "~output/deploy/mods/$XVMBUILD_WOT_VERSION/com.modxvm.xfw/"
    cp -rf ~output/xfw/wotmod/*.wotmod "~output/deploy/mods/$XVMBUILD_WOT_VERSION/com.modxvm.xfw/"
    popd >/dev/null
}

#builds Python part of XVM
build_xpm()
{
    echo ""
    echo "Building XPM"

    pushd "$XVMBUILD_ROOT_PATH"/src/xpm/ >/dev/null
    export XPM_CLEAR=0
    export XPM_RUN_TEST=0
    ./build.sh
    unset XPM_CLEAR
    unset XPM_RUN_TEST
    popd >/dev/null
}

#calculates hashes for XVM files
calc_hash_for_xvm_integrity()
{
    echo ""
    echo "Calculating hashes for xvm_integrity"

    pushd ~output/deploy > /dev/null
    hash_file='res_mods/mods/xfw_packages/xvm_integrity/python/hash_table.py'
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
    # rename version-dependent folder
    mkdir -p "$XVMBUILD_ROOT_PATH/~output/deploy/res_mods/$XVMBUILD_WOT_VERSION"
    mkdir -p  "$XVMBUILD_ROOT_PATH/~output/deploy/res_mods/mods/shared_resources/xvm/"
    mkdir -p  "$XVMBUILD_ROOT_PATH/~output/deploy/res_mods/mods/xfw_packages/"
    mkdir -p  "$XVMBUILD_ROOT_PATH/~output/deploy/res_mods/configs/xvm/"

    # cp non-binary files
    cp -rf "$XVMBUILD_ROOT_PATH"/~output/xvm/res_mods/mods/xfw_packages/* "$XVMBUILD_ROOT_PATH/~output/deploy/res_mods/mods/xfw_packages/"
    cp -rf "$XVMBUILD_ROOT_PATH"/release/* "$XVMBUILD_ROOT_PATH/~output/deploy/res_mods/mods/shared_resources/xvm/"

    #move config
    mv "$XVMBUILD_ROOT_PATH"/~output/deploy/res_mods/mods/shared_resources/xvm/configs/* "$XVMBUILD_ROOT_PATH/~output/deploy/res_mods/configs/xvm/"
    rm -r "$XVMBUILD_ROOT_PATH"/~output/deploy/res_mods/mods/shared_resources/xvm/configs/

    # get l10n files from translation server
    pushd "$XVMBUILD_ROOT_PATH/~output/deploy/res_mods/mods/shared_resources/xvm/l10n/" >/dev/null
    mkdir -p temp
    cd temp
    wget --quiet --output-document=l10n.zip "$XVMBUILD_L10N_URL"
    unzip -o l10n.zip >/dev/null
    rm l10n.zip ru.xc
    rm -f en.xc
    cd ..
    mv temp/* ./
    rm -rf temp/
    popd >/dev/null

    # put readmes on root
    pushd "$XVMBUILD_ROOT_PATH/~output/deploy/res_mods/mods/shared_resources/xvm/doc/" > /dev/null
    find . -name "readme-*.txt" -exec cp {} ../../../../../ \;
    popd > /dev/null
}

##########################
####  BUILD PIPELINE  ####
##########################

pushd "$XVMBUILD_ROOT_PATH" >/dev/null

detect_os
detect_arch

extend_path

detect_actionscript_sdk
detect_ffdec
detect_git
detect_java
detect_patch
detect_python
detect_unzip
detect_wget
detect_zip

create_directories

build_xfw
build_xpm
build_as3

if [[ "$XFW_DEVELOPMENT" == "" ]]; then
  clean_sha1
  copy_files
  calc_hash_for_xvm_integrity
fi

popd >/dev/null
