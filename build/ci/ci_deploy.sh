#!/bin/bash

# XVM team (c) www.modxvm.com 2014-2016
# XVM nightly build system

CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$CURRENT_PATH"
export XVMBUILD_ROOT_PATH="$CURRENT_PATH/../.."

source /var/xvm/ci_config.sh
source "$XVMBUILD_ROOT_PATH/build/xvm-build.conf"
source "$XVMBUILD_ROOT_PATH/build/library.sh"

pack_xvm(){
    echo ""
    echo "Packing build"

    echo "$XVMBUILD_XVM_REVISION" >> "$XVMBUILD_ROOT_PATH"/~output/"$XVMBUILD_XVM_REVISION"
    echo "$XVMBUILD_XVM_HASH" >> "$XVMBUILD_ROOT_PATH"/~output/"$XVMBUILD_XVM_REVISION"
    echo "$XVMBUILD_XVM_BRANCH" >> "$XVMBUILD_ROOT_PATH"/~output/"$XVMBUILD_XVM_REVISION"

    pushd "$XVMBUILD_ROOT_PATH"/~output/ > /dev/null
    zip -9 -r -q "$XVMBUILD_XVM_REVISION"_"$XVMBUILD_XVM_HASH"_xvm.zip ./
    popd > /dev/null
}

pack_xfw(){
    echo ""
    echo "Packing XFW"

    echo "$XVMBUILD_XFW_REVISION" >> "$XVMBUILD_ROOT_PATH"/src/xfw/~output/"$XVMBUILD_XFW_REVISION"
    echo "$XVMBUILD_XFW_HASH" >> "$XVMBUILD_ROOT_PATH"/src/xfw/~output/"$XVMBUILD_XFW_REVISION"
    echo "$XVMBUILD_XFW_BRANCH" >> "$XVMBUILD_ROOT_PATH"/src/xfw/~output/"$XVMBUILD_XFW_REVISION"

    pushd "$XVMBUILD_ROOT_PATH"/src/xfw/~output/ > /dev/null
    zip -9 -r -q "$XVMBUILD_XFW_REVISION"_"$XVMBUILD_XFW_HASH"_xfw.zip ./
    rm "$XVMBUILD_XFW_REVISION"
    popd > /dev/null
}


deploy_xvm(){
    echo ""
    echo "Deploying build"

    mkdir -p "$XVMBUILD_OUTPUT_PATH"/

    mv -f "$XVMBUILD_ROOT_PATH"/src/xfw/~output/"$XVMBUILD_XFW_REVISION"_"$XVMBUILD_XFW_HASH"_xfw.zip "$XVMBUILD_OUTPUT_PATH"/
    mv -f "$XVMBUILD_ROOT_PATH"/~output/"$XVMBUILD_XVM_REVISION"_"$XVMBUILD_XVM_HASH"_xvm.zip "$XVMBUILD_OUTPUT_PATH"/

    cp -f "$XVMBUILD_OUTPUT_PATH"/"$XVMBUILD_XVM_REVISION"_"$XVMBUILD_XVM_HASH"_xvm.zip "$XVMBUILD_OUTPUT_PATH"/latest_xvm.zip
    cp -f "$XVMBUILD_OUTPUT_PATH"/"$XVMBUILD_XFW_REVISION"_"$XVMBUILD_XFW_HASH"_xfw.zip "$XVMBUILD_OUTPUT_PATH"/latest_xfw.zip

    echo $XVMBUILD_XVM_REVISION > "$XVMBUILD_OUTPUT_PATH"/xvm_revision.txt
    echo $XVMBUILD_XVM_HASH > "$XVMBUILD_OUTPUT_PATH"/xvm_hash.txt
    echo $XVMBUILD_XVM_BRANCH > "$XVMBUILD_OUTPUT_PATH"/xvm_branch.txt
    echo $XVMBUILD_XFW_REVISION > "$XVMBUILD_OUTPUT_PATH"/xfw_revision.txt
    echo $XVMBUILD_XFW_HASH > "$XVMBUILD_OUTPUT_PATH"/xfw_hash.txt
    echo $XVMBUILD_XFW_BRANCH > "$XVMBUILD_OUTPUT_PATH"/xfw_branch.txt

    echo $XVM_VERSION > "$XVMBUILD_OUTPUT_PATH"/xvm_version.txt
    echo $TARGET_VERSION > "$XVMBUILD_OUTPUT_PATH"/wot_version.txt
}

deploy_xvminst()
{
    mv -f "$XVMBUILD_ROOT_PATH"/src/installer/output/"$XVMBUILD_XVM_BRANCH"/"$XVMBUILD_XVM_REVISION"_"$XVMBUILD_XVM_BRANCH"_xvm.exe "$XVMBUILD_OUTPUT_PATH"/
    mv -f "$XVMBUILD_ROOT_PATH"/src/installer/output/"$XVMBUILD_XVM_BRANCH"/latest_"$XVMBUILD_XVM_BRANCH"_xvm.exe "$XVMBUILD_OUTPUT_PATH"/
}

load_repositorystats

pack_xvm
pack_xfw

XVMBUILD_OUTPUT_PATH="$XVMBUILD_OUTPUT_PATH"/"$XVMBUILD_XVM_BRANCH"

deploy_xvm
deploy_xvminst

clean_repodir
