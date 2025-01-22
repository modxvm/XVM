#!/bin/bash

# SPDX-License-Identifier: LGPL-3.0-or-later
# Copyright (c) 2013-2025 XVM Contributors

XVMINST_ROOT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
XVMBUILD_ROOT_PATH="$XVMINST_ROOT_PATH/../../"

source "$XVMBUILD_ROOT_PATH"/build_lib/library.sh
source "$XVMBUILD_ROOT_PATH"/build/xvm-build.conf

##########################
####      CONFIG      ####
##########################

# $XVMBUILD_L10N_URL
if [[ "$XVMINST_L10N_URL" == "" ]]; then
    export XVMINST_L10N_URL="https://translate.modxvm.com/downloads/xvm-installer/xvm-installer-l10n_isl.zip"
fi

##########################
####    FUNCTIONS     ####
##########################

extend_path()
{
    export PATH="$XVMBUILD_ROOT_PATH/build/bin/Windows_i686/innosetup/:$PATH"
}

clean_directories()
{
    rm -rf "$XVMINST_ROOT_PATH/temp"

    mkdir -p "$XVMINST_ROOT_PATH/temp"
    mkdir -p "$XVMINST_ROOT_PATH/temp/changelogs"
    mkdir -p "$XVMINST_ROOT_PATH/temp/defines"
    mkdir -p "$XVMINST_ROOT_PATH/temp/l10n_download"
    mkdir -p "$XVMINST_ROOT_PATH/temp/l10n_result"
}

prepare_changelog()
{
    pushd "$XVMBUILD_ROOT_PATH/release/doc/" > /dev/null
 
    for file in ChangeLog-*.md; do
        pandoc "$file" -s -f gfm -o "$XVMINST_ROOT_PATH/temp/changelogs/${file%.md}.rtf";
        sed -i 's/\\bullet \\tx360\\tab/ \\bullet /g' "$XVMINST_ROOT_PATH/temp/changelogs/${file%.md}.rtf"
    done
 
    popd > /dev/null
}

prepare_defines()
{
    cp "$XVMINST_ROOT_PATH/src/xvm_defines_template.iss" "$XVMINST_ROOT_PATH/temp/defines/xvm_defines.iss"

    sed -i "s/XVM_WOTVERSION/${XVMBUILD_WOT_VERSION_wg}/g" "$XVMINST_ROOT_PATH/temp/defines/xvm_defines.iss"
    sed -i "s/XVM_MTVERSION/${XVMBUILD_WOT_VERSION_lesta}/g" "$XVMINST_ROOT_PATH/temp/defines/xvm_defines.iss"
    sed -i "s/XVM_VERSION/${XVMBUILD_XVM_VERSION}/g" "$XVMINST_ROOT_PATH/temp/defines/xvm_defines.iss"
}


prepare_languages()
{
    pushd "$XVMINST_ROOT_PATH/temp/l10n_download/" > /dev/null

    wget "$XVMINST_L10N_URL" --output-document=./l10n.zip
    unzip -q -o l10n.zip -d .
    rm l10n.zip

    cp "$XVMINST_ROOT_PATH/src/l10n/en.islu.tpl" "$XVMINST_ROOT_PATH/temp/l10n_download/en.islu.tpl"

    for file in *.tpl; do
       lang="${file%.*}"
       cp "$file" "../l10n_result/$lang"
       sed -i "s/{#VersionWOT}/${XVMBUILD_WOT_VERSION_wg}/g" ../l10n_result/$lang
       sed -i "s/{#VersionMT}/${XVMBUILD_WOT_VERSION_lesta}/g" ../l10n_result/$lang
       sed -i "s/{#VersionXVM}/${XVMBUILD_XVM_VERSION}/g" ../l10n_result/$lang
    done

    popd > /dev/null

    pushd "$XVMINST_ROOT_PATH/temp/l10n_result/" >/dev/null

    echo "[Languages]" >> lang.iss

    echo "Name: \"en\"; MessagesFile: \"l10n_inno\\en.islu,..\\temp\\l10n_result\\en.islu\"" >> lang.iss

    for file in *.islu; do
        lang="${file%.*}"

        if [ "$lang" != "en" ]; then
            #changelog
            if [ "$lang" == "ru" ] || [ "$lang" == "be" ] || [ "$lang" == "uk" ] || [ "$lang" == "kk" ];then
                langchg="ru"
            else
                langchg="en"
            fi

            if [ -f "$XVMINST_ROOT_PATH/src/l10n_inno/$lang.islu" ]; then
                echo "Name: \"$lang\"; MessagesFile: \"l10n_inno\\$lang.islu,..\\temp\\l10n_result\\$lang.islu\"" >> lang.iss
            fi
        fi
    done

    popd >/dev/null
}


build_run(){
    rm -rf "$XVMINST_ROOT_PATH"/output/

    pushd "$XVMINST_ROOT_PATH"/src/ >/dev/null

    $XVMBUILD_WINE_FILENAME "$XVMBUILD_ROOT_PATH/build_lib/bin/Windows_i686/innosetup/ISCC.exe" "xvm.iss"

    popd >/dev/null
}

build_deploy(){
    pushd "$XVMINST_ROOT_PATH/" >/dev/null

    mkdir -p ../../~output/installer
    cp ./output/setup_xvm.exe ../../~output/installer/xvm_latest_"$REPOSITORY_BRANCH".exe
    cp ./output/setup_xvm.exe ../../~output/installer/xvm_"$XVMBUILD_XVM_VERSION"_"$REPOSITORY_COMMITS_NUMBER"_"$REPOSITORY_BRANCH"_"$REPOSITORY_HASH".exe
    rm ./output/setup_xvm.exe
    popd >/dev/null
}

main(){
    detect_os
    detect_pandoc
    detect_wine
    detect_wget
    detect_git
    detect_unzip

    git_get_repostats "$XVMINST_ROOT_PATH"
    extend_path

    clean_directories

    prepare_changelog
    prepare_defines
    prepare_languages

    build_run

    build_deploy
    clean_directories
}

main
