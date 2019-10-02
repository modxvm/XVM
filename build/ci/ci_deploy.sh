#!/bin/bash

# XVM team (c) https://modxvm.com 2014-2019
# XVM nightly build system

CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$CURRENT_PATH"
export XVMBUILD_ROOT_PATH="$CURRENT_PATH/../.."

source /var/xvm/ci_config.sh
source "$XVMBUILD_ROOT_PATH/build/xvm-build.conf"
source "$XVMBUILD_ROOT_PATH/src/xfw/build/library.sh"

pack_xvm(){
    echo ""
    echo "Packing build"

    git_get_repostats "$XVMBUILD_ROOT_PATH"

    echo "$XVMBUILD_XVM_VERSION" >> "$XVMBUILD_ROOT_PATH"/~output/"$XVMBUILD_XVM_VERSION"_"$REPOSITORY_COMMITS_NUMBER"
    echo "$REPOSITORY_COMMITS_NUMBER" >> "$XVMBUILD_ROOT_PATH"/~output/"$XVMBUILD_XVM_VERSION"_"$REPOSITORY_COMMITS_NUMBER"
    echo "$REPOSITORY_HASH" >> "$XVMBUILD_ROOT_PATH"/~output/"$XVMBUILD_XVM_VERSION"_"$REPOSITORY_COMMITS_NUMBER"
    echo "$REPOSITORY_BRANCH" >> "$XVMBUILD_ROOT_PATH"/~output/"$XVMBUILD_XVM_VERSION"_"$REPOSITORY_COMMITS_NUMBER"

    pushd "$XVMBUILD_ROOT_PATH"/~output/ > /dev/null
    zip -9 -r -q xvm_"$XVMBUILD_XVM_VERSION"_"$REPOSITORY_COMMITS_NUMBER"_"$REPOSITORY_BRANCH"_"$REPOSITORY_HASH".zip ./
    rm "$XVMBUILD_XVM_VERSION_$REPOSITORY_COMMITS_NUMBER"
    popd > /dev/null
}

pack_xfw(){
    echo ""
    echo "Packing XFW"

    git_get_repostats "$XVMBUILD_ROOT_PATH"

    echo "$XVMBUILD_XVM_VERSION" >> "$XVMBUILD_ROOT_PATH"/src/xfw/~output/"$XVMBUILD_XVM_VERSION_$REPOSITORY_COMMITS_NUMBER"
    echo "$REPOSITORY_COMMITS_NUMBER" >> "$XVMBUILD_ROOT_PATH"/src/xfw/~output/"$XVMBUILD_XVM_VERSION_$REPOSITORY_COMMITS_NUMBER"
    echo "$REPOSITORY_HASH" >> "$XVMBUILD_ROOT_PATH"/src/xfw/~output/"$XVMBUILD_XVM_VERSION_$REPOSITORY_COMMITS_NUMBER"
    echo "$REPOSITORY_BRANCH" >> "$XVMBUILD_ROOT_PATH"/src/xfw/~output/"$XVMBUILD_XVM_VERSION_$REPOSITORY_COMMITS_NUMBER"

    pushd "$XVMBUILD_ROOT_PATH"/src/xfw/ > /dev/null

    rm -rf "~output_zip/"
    mkdir -p "~output_zip/"

    mkdir -p "~output_zip/mods/$XVMBUILD_WOT_VERSION/com.modxvm.xfw/"
    cp -rf "~output_wotmod/." "~output_zip/mods/$XVMBUILD_WOT_VERSION/com.modxvm.xfw/"
    cp -r "~output/swc/" "~output_zip/"

    popd > /dev/null

    pushd "$XVMBUILD_ROOT_PATH"/src/xfw/~output_zip/ > /dev/null
    zip -9 -r -q xfw_"$REPOSITORY_COMMITS_NUMBER"_"$REPOSITORY_HASH".zip ./
    rm "$XVMBUILD_XVM_VERSION_$REPOSITORY_COMMITS_NUMBER"
    popd > /dev/null
}


deploy_xvm(){
    echo ""
    echo "Deploying XVM"

    git_get_repostats "$XVMBUILD_ROOT_PATH"

    mkdir -p "$XVMBUILD_OUTPUT_PATH"/"$REPOSITORY_BRANCH"/

    mv -f "$XVMBUILD_ROOT_PATH"/~output/xvm_"$XVMBUILD_XVM_VERSION"_"$REPOSITORY_COMMITS_NUMBER"_"$REPOSITORY_BRANCH"_"$REPOSITORY_HASH".zip "$XVMBUILD_OUTPUT_PATH"/"$REPOSITORY_BRANCH"/

    cp -f "$XVMBUILD_OUTPUT_PATH"/"$REPOSITORY_BRANCH"/xvm_"$XVMBUILD_XVM_VERSION"_"$REPOSITORY_COMMITS_NUMBER"_"$REPOSITORY_BRANCH"_"$REPOSITORY_HASH".zip "$XVMBUILD_OUTPUT_PATH"/"$REPOSITORY_BRANCH"/latest_xvm.zip

    echo "$XVMBUILD_XVM_VERSION_$REPOSITORY_COMMITS_NUMBER" > "$XVMBUILD_OUTPUT_PATH"/"$REPOSITORY_BRANCH"/xvm_revision.txt
    echo $REPOSITORY_HASH > "$XVMBUILD_OUTPUT_PATH"/"$REPOSITORY_BRANCH"/xvm_hash.txt
    echo $REPOSITORY_BRANCH > "$XVMBUILD_OUTPUT_PATH"/"$REPOSITORY_BRANCH"/xvm_branch.txt
    echo $REPOSITORY_COMMITS_NUMBER > "$XVMBUILD_OUTPUT_PATH"/"$REPOSITORY_BRANCH"/xvm_commits.txt

    echo "$XVMBUILD_XVM_VERSION" > "$XVMBUILD_OUTPUT_PATH"/"$REPOSITORY_BRANCH"/xvm_version.txt
    echo "$XVMBUILD_WOT_VERSION" > "$XVMBUILD_OUTPUT_PATH"/"$REPOSITORY_BRANCH"/wot_version.txt
}

deploy_xfw(){
    echo ""
    echo "Deploying XFW"

    git_get_repostats "$XVMBUILD_ROOT_PATH"

    mkdir -p "$XVMBUILD_OUTPUT_PATH"/"$REPOSITORY_BRANCH"/

    mv -f "$XVMBUILD_ROOT_PATH"/src/xfw/~output_zip/xfw_"$REPOSITORY_COMMITS_NUMBER"_"$REPOSITORY_HASH".zip "$XVMBUILD_OUTPUT_PATH"/"$REPOSITORY_BRANCH"/
    cp -f "$XVMBUILD_OUTPUT_PATH"/"$REPOSITORY_BRANCH"/xfw_"$REPOSITORY_COMMITS_NUMBER"_"$REPOSITORY_HASH".zip "$XVMBUILD_OUTPUT_PATH"/"$REPOSITORY_BRANCH"/latest_xfw.zip

    echo "$XVMBUILD_XVM_VERSION_$REPOSITORY_COMMITS_NUMBER" > "$XVMBUILD_OUTPUT_PATH"/"$REPOSITORY_BRANCH"/xfw_revision.txt
    echo $REPOSITORY_HASH > "$XVMBUILD_OUTPUT_PATH"/"$REPOSITORY_BRANCH"/xfw_hash.txt
    echo $REPOSITORY_BRANCH > "$XVMBUILD_OUTPUT_PATH"/"$REPOSITORY_BRANCH"/xfw_branch.txt
    echo $REPOSITORY_COMMITS_NUMBER > "$XVMBUILD_OUTPUT_PATH"/"$REPOSITORY_BRANCH"/xfw_commits.txt
}


deploy_xvminst()
{
    git_get_repostats "$XVMBUILD_ROOT_PATH"

    mkdir -p "$XVMBUILD_OUTPUT_PATH"/"$REPOSITORY_BRANCH"/

    mv -f "$XVMBUILD_ROOT_PATH"/src/installer/output/"$REPOSITORY_BRANCH"/xvm_"$XVMBUILD_XVM_VERSION"_"$REPOSITORY_COMMITS_NUMBER"_"$REPOSITORY_BRANCH"_"$REPOSITORY_HASH".exe "$XVMBUILD_OUTPUT_PATH"/"$REPOSITORY_BRANCH"/
    mv -f "$XVMBUILD_ROOT_PATH"/src/installer/output/"$REPOSITORY_BRANCH"/xvm_latest_"$REPOSITORY_BRANCH".exe "$XVMBUILD_OUTPUT_PATH"/"$REPOSITORY_BRANCH"/
}

pack_xvm
pack_xfw

deploy_xvm
deploy_xfw
deploy_xvminst

clean_repodir
