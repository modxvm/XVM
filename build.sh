#!/bin/bash

# XVM team (c) www.modxvm.com 2014-2017
# XVM nightly build system

XVMBUILD_ROOT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$XVMBUILD_ROOT_PATH"

source ./build/library.sh
source ./build/xvm-build.conf
source ./src/xfw/build/xfw-build.conf

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
    rm -rf ~output/cmp/
    rm -rf ~output/res_mods/cmp/
    rm -rf ~output/sha1/
    rm -rf src/xfw/~output/sha1/
    rm -rf src/xfw/~output/cmp/
    popd > /dev/null
}

#creates all needed directories
create_directories()
{
    pushd "$XVMBUILD_ROOT_PATH" > /dev/null
    mkdir -p ~output/mods/~ver/
    mkdir -p ~output/res_mods/configs/xvm
    mkdir -p ~output/res_mods/mods/shared_resources/xvm/
    popd > /dev/null
}

#extends PATH system environment variable
extend_path()
{
    export PATH=$PATH:"$XVMBUILD_ROOT_PATH"/build/bin/java/:"$XVMBUILD_ROOT_PATH"/build/bin/msil/:"$XVMBUILD_ROOT_PATH"/build/bin/"$OS"_"$arch"/
}

##########################
####  BUILD FUNCTIONS ####
##########################

#builds XVM ActionScript 3 files
build_as3(){
    echo ""
    echo "Building AS3 files"

    pushd "$XVMBUILD_ROOT_PATH"/src/xvm/ > /dev/null

    top=( "_xvm_shared.as3proj" "_xvm_app.as3proj" "xvm_lobby.as3proj" "xvm_battle.as3proj" )

    for proj in "${top[@]}"; do
        echo "Building $proj"
        build_as3_h "$proj" || exit $?
    done

    for proj in *.as3proj; do
        exists=0
        for e in "${top[@]}"; do [[ "$e" == "$proj" ]] && { exists=1; break; } done
        if [ $exists -eq 0 ]; then
            echo "Building $proj"
            build_as3_h "$proj" || exit $?
        fi
    done

    popd > /dev/null
}

#builds XVM Framework and copy XFW to ~output/
build_xfw()
{
    echo ""
    echo "Building XFW"

    pushd "$XVMBUILD_ROOT_PATH"/src/xfw/ >/dev/null
    ./build.sh || exit $?
    popd >/dev/null

    pushd "$XVMBUILD_ROOT_PATH" >/dev/null
    cp -rf src/xfw/~output_wotmod/*.wotmod ~output/mods/~ver/
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
    ./build-all.sh || exit $?
    unset XPM_CLEAR
    unset XPM_RUN_TEST
    popd >/dev/null
}

#calculates hashes for XVM files
calc_hash_for_xvm_integrity()
{
    echo ""
    echo "Calculating hashes for xvm_integrity"

    pushd ~output > /dev/null
    hash_file='res_mods/mods/packages/xvm_integrity/python/hash_table.py'
    echo -e '""" Generated automatically by XVM builder """\nHASH_DATA = {' > $hash_file
    find res_mods -name *.py -print0 -o -name *.pyc -print0 -o -name *.swf -print0 | while read -d $'\0' file
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
    mv "$XVMBUILD_ROOT_PATH"/~output/mods/~ver/ "$XVMBUILD_ROOT_PATH"/~output/mods/"$XVMBUILD_WOT_VERSION"

    # cp non-binary files
    cp -rf "$XVMBUILD_ROOT_PATH"/release/* "$XVMBUILD_ROOT_PATH"/~output/res_mods/mods/shared_resources/xvm/
    mv "$XVMBUILD_ROOT_PATH"/~output/res_mods/mods/shared_resources/xvm/configs/* "$XVMBUILD_ROOT_PATH"/~output/res_mods/configs/xvm
    rm -rf "$XVMBUILD_ROOT_PATH"/~output/res_mods/mods/shared_resources/xvm/configs/

    # get l10n files from translation server
    pushd "$XVMBUILD_ROOT_PATH"/~output/res_mods/mods/shared_resources/xvm/l10n/ >/dev/null
    mkdir -p temp
    cd temp
    wget --quiet --output-document=l10n.zip "$XVMBUILD_L10N_URL"
    unzip -o l10n.zip >/dev/null
    rm l10n.zip ru.xc
    cd ..
    mv temp/* ./
    rm -rf temp/
    popd >/dev/null

    # put readmes on root
    pushd "$XVMBUILD_ROOT_PATH"/~output/res_mods/mods/shared_resources/xvm/doc/ > /dev/null
    find . -name "readme-*.txt" -exec cp {} ../../../../../ \;
    popd > /dev/null

    rm -r "$XVMBUILD_ROOT_PATH"/~output/swc/
}

##########################
####  BUILD PIPELINE  ####
##########################

pushd "$XVMBUILD_ROOT_PATH" >/dev/null

detect_os
detect_arch

extend_path

detect_fdbuild
detect_ffdec
detect_flex
detect_java
detect_mono
detect_patch
detect_python
detect_unzip
detect_wget
detect_zip

load_repositorystats

clean_repodir

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
