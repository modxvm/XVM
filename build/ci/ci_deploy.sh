#!/bin/bash

# XVM team (c) https://modxvm.com 2014-2017
# XVM nightly build system

CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$CURRENT_PATH"
export XVMBUILD_ROOT_PATH="$CURRENT_PATH/../.."

source /var/xvm/ci_config.sh
source "$XVMBUILD_ROOT_PATH/build/xvm-build.conf"
source "$XVMBUILD_ROOT_PATH/src/xfw/build/xfw-build.conf"
source "$XVMBUILD_ROOT_PATH/src/xfw/build/library.sh"

load_repositorystats(){
    #read xvm revision and hash
    pushd "$XVMBUILD_ROOT_PATH"/ > /dev/null
        export XVMBUILD_XVM_BRANCH=$(hg parent --template "{branch}") || exit 1
        export XVMBUILD_XVM_HASH=$(hg parent --template "{node|short}") || exit 1
        export XVMBUILD_XVM_REVISION=$(hg parent --template "{rev}") || exit 1
        export XVMBUILD_XVM_COMMITMSG=$(hg parent --template "{desc}") || exit 1
        export XVMBUILD_XVM_COMMITAUTHOR=$(hg parent --template "{author}" | sed 's/<.*//') || exit 1
    popd > /dev/null

    #read xfw revision and hash
    pushd "$XVMBUILD_ROOT_PATH"/src/xfw/ > /dev/null
        export XVMBUILD_XFW_BRANCH=$(hg parent --template "{branch}") || exit 1
        export XVMBUILD_XFW_HASH=$(hg parent --template "{node|short}") || exit 1
        export XVMBUILD_XFW_REVISION=$(hg parent --template "{rev}") || exit 1
    popd > /dev/null
}


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

    pushd "$XVMBUILD_ROOT_PATH"/src/xfw/ > /dev/null

    rm -rf "~output_zip/"
    mkdir -p "~output_zip/"

    mkdir -p "~output_zip/mods/$XVMBUILD_WOT_VERSION/"
    cp -rf "~output_wotmod/com.modxvm.xfw_$XVMBUILD_XFW_VERSION.$XVMBUILD_XFW_REVISION.wotmod" "~output_zip/mods/$XVMBUILD_WOT_VERSION/"

    cp -r "~output/swc/" "~output_zip/"

    popd > /dev/null

    pushd "$XVMBUILD_ROOT_PATH"/src/xfw/~output_zip/ > /dev/null
    zip -9 -r -q "$XVMBUILD_XFW_REVISION"_"$XVMBUILD_XFW_HASH"_xfw.zip ./
    rm "$XVMBUILD_XFW_REVISION"
    popd > /dev/null
}


deploy_xvm(){
    echo ""
    echo "Deploying build"

    mkdir -p "$XVMBUILD_OUTPUT_PATH"/

    mv -f "$XVMBUILD_ROOT_PATH"/src/xfw/~output_zip/"$XVMBUILD_XFW_REVISION"_"$XVMBUILD_XFW_HASH"_xfw.zip "$XVMBUILD_OUTPUT_PATH"/
    mv -f "$XVMBUILD_ROOT_PATH"/~output/"$XVMBUILD_XVM_REVISION"_"$XVMBUILD_XVM_HASH"_xvm.zip "$XVMBUILD_OUTPUT_PATH"/

    cp -f "$XVMBUILD_OUTPUT_PATH"/"$XVMBUILD_XVM_REVISION"_"$XVMBUILD_XVM_HASH"_xvm.zip "$XVMBUILD_OUTPUT_PATH"/latest_xvm.zip
    cp -f "$XVMBUILD_OUTPUT_PATH"/"$XVMBUILD_XFW_REVISION"_"$XVMBUILD_XFW_HASH"_xfw.zip "$XVMBUILD_OUTPUT_PATH"/latest_xfw.zip

    echo $XVMBUILD_XVM_REVISION > "$XVMBUILD_OUTPUT_PATH"/xvm_revision.txt
    echo $XVMBUILD_XVM_HASH > "$XVMBUILD_OUTPUT_PATH"/xvm_hash.txt
    echo $XVMBUILD_XVM_BRANCH > "$XVMBUILD_OUTPUT_PATH"/xvm_branch.txt
    echo $XVMBUILD_XFW_REVISION > "$XVMBUILD_OUTPUT_PATH"/xfw_revision.txt
    echo $XVMBUILD_XFW_HASH > "$XVMBUILD_OUTPUT_PATH"/xfw_hash.txt
    echo $XVMBUILD_XFW_BRANCH > "$XVMBUILD_OUTPUT_PATH"/xfw_branch.txt

    echo "$XVMBUILD_XVM_VERSION" > "$XVMBUILD_OUTPUT_PATH"/xvm_version.txt
    echo "$XVMBUILD_WOT_VERSION" > "$XVMBUILD_OUTPUT_PATH"/wot_version.txt
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
