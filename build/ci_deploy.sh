#!/bin/bash

# SPDX-License-Identifier: LGPL-3.0-or-later
# Copyright (c) 2013-2025 XVM Contributors

CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$CURRENT_PATH"
export XVMBUILD_ROOT_PATH="$CURRENT_PATH/.."
export XVMBUILD_UPLOAD_PORT=${XVMBUILD_UPLOAD_PORT:-22}
export XVMBUILD_UPLOAD_KEYCHECK=${XVMBUILD_UPLOAD_KEYCHECK:-no}

export XVM_RELEASE_SSH_PORT=${XVM_RELEASE_SSH_PORT:-222}
export XVM_RELEASE_SSH_STRICT_HOST_KEY_CHECKING=${XVM_RELEASE_SSH_STRICT_HOST_KEY_CHECKING:-yes}


source "$XVMBUILD_ROOT_PATH/build/xvm-build.conf"
source "$XVMBUILD_ROOT_PATH/build_lib/library.sh"

pack_xvm(){
    echo ""
    echo "Packing build"

    git_get_repostats "$XVMBUILD_ROOT_PATH"

    rm -r "$XVMBUILD_ROOT_PATH/~output/pack/"
    mkdir -p "$XVMBUILD_ROOT_PATH/~output/pack/"

    echo "$XVMBUILD_XVM_VERSION" >> "$XVMBUILD_ROOT_PATH"/~output/pack/"${XVMBUILD_XVM_VERSION}_${REPOSITORY_COMMITS_NUMBER}"
    echo "$REPOSITORY_COMMITS_NUMBER" >> "$XVMBUILD_ROOT_PATH"/~output/pack/"${XVMBUILD_XVM_VERSION}_${REPOSITORY_COMMITS_NUMBER}"
    echo "$REPOSITORY_HASH" >> "$XVMBUILD_ROOT_PATH"/~output/pack/"${XVMBUILD_XVM_VERSION}_${REPOSITORY_COMMITS_NUMBER}"
    echo "$REPOSITORY_BRANCH" >> "$XVMBUILD_ROOT_PATH"/~output/pack/"${XVMBUILD_XVM_VERSION}_${REPOSITORY_COMMITS_NUMBER}"

    cp -r "$XVMBUILD_ROOT_PATH/~output/lesta/deploy/." "$XVMBUILD_ROOT_PATH/~output/pack/lesta/"
    cp -r "$XVMBUILD_ROOT_PATH/~output/wg/deploy/." "$XVMBUILD_ROOT_PATH/~output/pack/wg/"


    pushd "$XVMBUILD_ROOT_PATH"/~output/pack/ > /dev/null
    zip -9 -r xvm_"$XVMBUILD_XVM_VERSION"_"$REPOSITORY_COMMITS_NUMBER"_"$REPOSITORY_BRANCH"_"$REPOSITORY_HASH".zip ./
    rm "$XVMBUILD_ROOT_PATH"/~output/pack/"${XVMBUILD_XVM_VERSION}_${REPOSITORY_COMMITS_NUMBER}"

    popd > /dev/null
}

deploy_nightly_files(){
    echo ""
    echo "Deploying XVM Nightly Build"

    git_get_repostats "$XVMBUILD_ROOT_PATH"

    sshpass -p "$XVMBUILD_UPLOAD_PASSWORD" ssh -o "StrictHostKeyChecking=$XVMBUILD_UPLOAD_KEYCHECK" $XVMBUILD_UPLOAD_USER@$XVMBUILD_UPLOAD_HOST -p $XVMBUILD_UPLOAD_PORT "mkdir -p $XVMBUILD_UPLOAD_PATH/$REPOSITORY_BRANCH/"

    #XVM ZIP
    localpath="$XVMBUILD_ROOT_PATH"/~output/pack/xvm_"$XVMBUILD_XVM_VERSION"_"$REPOSITORY_COMMITS_NUMBER"_"$REPOSITORY_BRANCH"_"$REPOSITORY_HASH".zip

    remotepath="$XVMBUILD_UPLOAD_PATH"/"$REPOSITORY_BRANCH"/xvm_latest.zip
    sshpass -p "$XVMBUILD_UPLOAD_PASSWORD" scp -o "StrictHostKeyChecking=$XVMBUILD_UPLOAD_KEYCHECK" -P "$XVMBUILD_UPLOAD_PORT" -r "$localpath" "$XVMBUILD_UPLOAD_USER@$XVMBUILD_UPLOAD_HOST:$remotepath"

    remotepath="$XVMBUILD_UPLOAD_PATH"/"$REPOSITORY_BRANCH"/xvm_"$XVMBUILD_XVM_VERSION"_"$REPOSITORY_COMMITS_NUMBER"_"$REPOSITORY_BRANCH"_"$REPOSITORY_HASH".zip
    sshpass -p "$XVMBUILD_UPLOAD_PASSWORD" scp -o "StrictHostKeyChecking=$XVMBUILD_UPLOAD_KEYCHECK" -P "$XVMBUILD_UPLOAD_PORT" -r "$localpath" "$XVMBUILD_UPLOAD_USER@$XVMBUILD_UPLOAD_HOST:$remotepath"

    #XVM INSTALLER
    localpath="$XVMBUILD_ROOT_PATH"/~output/installer/xvm_"$XVMBUILD_XVM_VERSION"_"$REPOSITORY_COMMITS_NUMBER"_"$REPOSITORY_BRANCH"_"$REPOSITORY_HASH".exe

    remotepath="$XVMBUILD_UPLOAD_PATH"/"$REPOSITORY_BRANCH"/xvm_latest_"$REPOSITORY_BRANCH".exe
    sshpass -p "$XVMBUILD_UPLOAD_PASSWORD" scp -o "StrictHostKeyChecking=$XVMBUILD_UPLOAD_KEYCHECK" -P "$XVMBUILD_UPLOAD_PORT" -r "$localpath" "$XVMBUILD_UPLOAD_USER@$XVMBUILD_UPLOAD_HOST:$remotepath"

    remotepath="$XVMBUILD_UPLOAD_PATH"/"$REPOSITORY_BRANCH"/xvm_"$XVMBUILD_XVM_VERSION"_"$REPOSITORY_COMMITS_NUMBER"_"$REPOSITORY_BRANCH"_"$REPOSITORY_HASH".exe
    sshpass -p "$XVMBUILD_UPLOAD_PASSWORD" scp -o "StrictHostKeyChecking=$XVMBUILD_UPLOAD_KEYCHECK" -P "$XVMBUILD_UPLOAD_PORT" -r "$localpath" "$XVMBUILD_UPLOAD_USER@$XVMBUILD_UPLOAD_HOST:$remotepath"
}

prepare_meta(){
    echo ""
    echo "Preparing Meta"
    git_get_repostats "$XVMBUILD_ROOT_PATH"

    #MODXVM meta
    XVMBUILD_MX_DATE=$(date +%Y-%m-%dT%H:%M:%S%:z)
    XVMBUILD_MX_SIZE_EXE=$(stat --printf=%s "$XVMBUILD_ROOT_PATH"/~output/installer/xvm_"$XVMBUILD_XVM_VERSION"_"$REPOSITORY_COMMITS_NUMBER"_"$REPOSITORY_BRANCH"_"$REPOSITORY_HASH".exe)
    XVMBUILD_MX_SIZE_ZIP=$(stat --printf=%s "$XVMBUILD_ROOT_PATH"/~output/pack/xvm_"$XVMBUILD_XVM_VERSION"_"$REPOSITORY_COMMITS_NUMBER"_"$REPOSITORY_BRANCH"_"$REPOSITORY_HASH".zip)
    XVMBUILD_MX_URL_ZIP="${XVMBUILD_URL_DOWNLOAD}/${REPOSITORY_BRANCH}/xvm_${XVMBUILD_XVM_VERSION}_${REPOSITORY_COMMITS_NUMBER}_${REPOSITORY_BRANCH}_${REPOSITORY_HASH}.zip"
    XVMBUILD_MX_URL_EXE="${XVMBUILD_URL_DOWNLOAD}/${REPOSITORY_BRANCH}/xvm_${XVMBUILD_XVM_VERSION}_${REPOSITORY_COMMITS_NUMBER}_${REPOSITORY_BRANCH}_${REPOSITORY_HASH}.exe"

    dlmeta_output="dl_meta.json"
    cp "./ci_deploy.json.template" "$dlmeta_output"
    sed -i "s/XVMBUILD_MX_DATE/$XVMBUILD_MX_DATE/g" "$dlmeta_output"
    sed -i "s/XVMBUILD_MX_SIZE_EXE/$XVMBUILD_MX_SIZE_EXE/g" "$dlmeta_output"
    sed -i "s/XVMBUILD_MX_SIZE_ZIP/$XVMBUILD_MX_SIZE_ZIP/g" "$dlmeta_output"
    sed -i "s/REPOSITORY_BRANCH/$REPOSITORY_BRANCH/g" "$dlmeta_output"
    sed -i "s/REPOSITORY_HASH/$REPOSITORY_HASH/g" "$dlmeta_output"
    sed -i "s/XVMBUILD_XVM_VERSION/$XVMBUILD_XVM_VERSION/g" "$dlmeta_output"
    sed -i "s/REPOSITORY_COMMITS_NUMBER/$REPOSITORY_COMMITS_NUMBER/g" "$dlmeta_output"
    sed -i "s/XVMBUILD_WOT_VERSION_wg/$XVMBUILD_WOT_VERSION_wg/g" "$dlmeta_output"
    sed -i "s/XVMBUILD_WOT_VERSION_lesta/$XVMBUILD_WOT_VERSION_lesta/g" "$dlmeta_output"
    sed -i "s,XVMBUILD_MX_URL_EXE,$XVMBUILD_MX_URL_EXE,g" "$dlmeta_output"
    sed -i "s,XVMBUILD_MX_URL_ZIP,$XVMBUILD_MX_URL_ZIP,g" "$dlmeta_output"
    sed -i "s,XVMBUILD_URL_REPO,$XVMBUILD_URL_REPO,g" "$dlmeta_output"
}

deploy_nightly_meta(){
    echo ""
    echo "Deploying Meta for Nightly Build"

    git_get_repostats "$XVMBUILD_ROOT_PATH"

    #XVM-Nightly meta
    echo "$XVMBUILD_XVM_VERSION"_"$REPOSITORY_COMMITS_NUMBER" > xvm_revision.txt
    sshpass -p "$XVMBUILD_UPLOAD_PASSWORD" scp -o "StrictHostKeyChecking=$XVMBUILD_UPLOAD_KEYCHECK" -P "$XVMBUILD_UPLOAD_PORT" -r "xvm_revision.txt" "$XVMBUILD_UPLOAD_USER@$XVMBUILD_UPLOAD_HOST:$XVMBUILD_UPLOAD_PATH/$REPOSITORY_BRANCH/xvm_revision.txt"

    echo $REPOSITORY_HASH > xvm_hash.txt
    sshpass -p "$XVMBUILD_UPLOAD_PASSWORD" scp -o "StrictHostKeyChecking=$XVMBUILD_UPLOAD_KEYCHECK" -P "$XVMBUILD_UPLOAD_PORT" -r "xvm_hash.txt" "$XVMBUILD_UPLOAD_USER@$XVMBUILD_UPLOAD_HOST:$XVMBUILD_UPLOAD_PATH/$REPOSITORY_BRANCH/xvm_hash.txt"

    echo $REPOSITORY_BRANCH > xvm_branch.txt
    sshpass -p "$XVMBUILD_UPLOAD_PASSWORD" scp -o "StrictHostKeyChecking=$XVMBUILD_UPLOAD_KEYCHECK" -P "$XVMBUILD_UPLOAD_PORT" -r "xvm_branch.txt" "$XVMBUILD_UPLOAD_USER@$XVMBUILD_UPLOAD_HOST:$XVMBUILD_UPLOAD_PATH/$REPOSITORY_BRANCH/xvm_branch.txt"

    echo $REPOSITORY_COMMITS_NUMBER > xvm_commits.txt
    sshpass -p "$XVMBUILD_UPLOAD_PASSWORD" scp -o "StrictHostKeyChecking=$XVMBUILD_UPLOAD_KEYCHECK" -P "$XVMBUILD_UPLOAD_PORT" -r "xvm_commits.txt" "$XVMBUILD_UPLOAD_USER@$XVMBUILD_UPLOAD_HOST:$XVMBUILD_UPLOAD_PATH/$REPOSITORY_BRANCH/xvm_commits.txt"

    echo $REPOSITORY_COMMITS_NUMBER > xvm_version.txt
    sshpass -p "$XVMBUILD_UPLOAD_PASSWORD" scp -o "StrictHostKeyChecking=$XVMBUILD_UPLOAD_KEYCHECK" -P "$XVMBUILD_UPLOAD_PORT" -r "xvm_version.txt" "$XVMBUILD_UPLOAD_USER@$XVMBUILD_UPLOAD_HOST:$XVMBUILD_UPLOAD_PATH/$REPOSITORY_BRANCH/xvm_version.txt"

    echo "$XVMBUILD_WOT_VERSION_wg" > wot_version.txt
    sshpass -p "$XVMBUILD_UPLOAD_PASSWORD" scp -o "StrictHostKeyChecking=$XVMBUILD_UPLOAD_KEYCHECK" -P "$XVMBUILD_UPLOAD_PORT" -r "wot_version.txt" "$XVMBUILD_UPLOAD_USER@$XVMBUILD_UPLOAD_HOST:$XVMBUILD_UPLOAD_PATH/$REPOSITORY_BRANCH/wot_version.txt"

    echo "$XVMBUILD_WOT_VERSION_wg" > wot_version_wg.txt
    sshpass -p "$XVMBUILD_UPLOAD_PASSWORD" scp -o "StrictHostKeyChecking=$XVMBUILD_UPLOAD_KEYCHECK" -P "$XVMBUILD_UPLOAD_PORT" -r "wot_version_wg.txt" "$XVMBUILD_UPLOAD_USER@$XVMBUILD_UPLOAD_HOST:$XVMBUILD_UPLOAD_PATH/$REPOSITORY_BRANCH/wot_version_wg.txt"

    echo "$XVMBUILD_WOT_VERSION_lesta" > wot_version_lesta.txt
    sshpass -p "$XVMBUILD_UPLOAD_PASSWORD" scp -o "StrictHostKeyChecking=$XVMBUILD_UPLOAD_KEYCHECK" -P "$XVMBUILD_UPLOAD_PORT" -r "wot_version_lesta.txt" "$XVMBUILD_UPLOAD_USER@$XVMBUILD_UPLOAD_HOST:$XVMBUILD_UPLOAD_PATH/$REPOSITORY_BRANCH/wot_version_lesta.txt"


    #XVM Website Meta (Nightly Builds)
    sshpass -p "$XVMBUILD_UPLOAD_PASSWORD" scp -o "StrictHostKeyChecking=$XVMBUILD_UPLOAD_KEYCHECK" -P "$XVMBUILD_UPLOAD_PORT" -r "$dlmeta_output" "$XVMBUILD_UPLOAD_USER@$XVMBUILD_UPLOAD_HOST:$XVMBUILD_UPLOAD_PATH/$REPOSITORY_BRANCH/dl_meta.json"
}

pack_xvm
#pack_xfw
prepare_meta

deploy_nightly_files
deploy_nightly_meta

clean_repodir
