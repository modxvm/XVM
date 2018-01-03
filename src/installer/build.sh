#!/bin/bash

# XVM team (c) https://modxvm.com 2014-2018
# XVM nightly build system

XVMINST_ROOT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
XVMBUILD_ROOT_PATH="$XVMINST_ROOT_PATH/../../"

source "$XVMBUILD_ROOT_PATH"/src/xfw/build/library.sh
source "$XVMBUILD_ROOT_PATH"/build/xvm-build.conf

##########################
####      CONFIG      ####
##########################

# $XVMBUILD_L10N_URL
if [[ "$XVMINST_L10N_URL" == "" ]]; then
    export XVMINST_L10N_URL="http://translate.modxvm.com/download/xvm-installer/xvm-installer-l10n_isl.zip"
fi

##########################
####    FUNCTIONS     ####
##########################

extend_path()
{
    export PATH="$XVMBUILD_ROOT_PATH/build/bin/Windows_i686/innosetup/:$PATH"
}

load_repositorystats(){
    #read xvm revision and hash
    pushd "$XVMBUILD_ROOT_PATH"/ > /dev/null
        export XVMBUILD_XVM_BRANCH=$(hg parent --template "{branch}") || exit 1
        export XVMBUILD_XVM_HASH=$(hg parent --template "{node|short}") || exit 1
        export XVMBUILD_XVM_REVISION=$(hg parent --template "{rev}") || exit 1
    popd > /dev/null
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
    cp "$XVMBUILD_ROOT_PATH/~output/res_mods/mods/shared_resources/xvm/doc/ChangeLog-en.txt" "$XVMINST_ROOT_PATH/temp/changelogs/"
    cp "$XVMBUILD_ROOT_PATH/~output/res_mods/mods/shared_resources/xvm/doc/ChangeLog-ru.txt" "$XVMINST_ROOT_PATH/temp/changelogs/"

    sed -i '1s/^\xef\xbb\xbf//' "$XVMINST_ROOT_PATH/temp/changelogs/ChangeLog-ru.txt"
    iconv --from-code=utf-8 --to-code=cp1251 "$XVMINST_ROOT_PATH/temp/changelogs/ChangeLog-ru.txt" > "$XVMINST_ROOT_PATH/temp/changelogs/ChangeLog-ru.txt.new"
    mv "$XVMINST_ROOT_PATH/temp/changelogs/ChangeLog-ru.txt.new" "$XVMINST_ROOT_PATH/temp/changelogs/ChangeLog-ru.txt"
}

prepare_defines()
{
    cp "$XVMINST_ROOT_PATH/src/xvm_defines_template.iss" "$XVMINST_ROOT_PATH/temp/defines/xvm_defines.iss"
   
    sed -i "s/XVM_WOTVERSION/${XVMBUILD_WOT_VERSION}/g" "$XVMINST_ROOT_PATH/temp/defines/xvm_defines.iss"
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
       sed -i "s/{#VersionWOT}/${XVMBUILD_WOT_VERSION}/g" ../l10n_result/$lang
       sed -i "s/{#VersionXVM}/${XVMBUILD_XVM_VERSION}/g" ../l10n_result/$lang
    done

    popd > /dev/null

    pushd "$XVMINST_ROOT_PATH/temp/l10n_result/" >/dev/null

    echo "[Languages]" >> lang.iss    

    echo "Name: \"en\"; MessagesFile: \"l10n_inno\\en.islu,..\\temp\\l10n_result\\en.islu\"; InfoBeforeFile: \"..\\temp\\changelogs\\ChangeLog-en.txt\"" >> lang.iss

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
                echo "Name: \"$lang\"; MessagesFile: \"l10n_inno\\$lang.islu,..\\temp\\l10n_result\\$lang.islu\"; InfoBeforeFile: \"..\\temp\\changelogs\\ChangeLog-$langchg.txt\"" >> lang.iss
            fi
        fi      
    done

    popd >/dev/null
}


build_run(){
    rm -rf "$XVMINST_ROOT_PATH"/output/

    pushd "$XVMINST_ROOT_PATH"/src/ >/dev/null

    $XVMBUILD_WINE_FILENAME "$XVMBUILD_ROOT_PATH/build/bin/Windows_i686/innosetup/ISCC.exe" "xvm.iss"

    popd >/dev/null
}

build_deploy(){
    pushd "$XVMINST_ROOT_PATH/" >/dev/null

    mkdir -p ./output/"$XVMBUILD_XVM_BRANCH"/
    mv ./output/setup_xvm.exe ./output/"$XVMBUILD_XVM_BRANCH"/latest_"$XVMBUILD_XVM_BRANCH"_xvm.exe
    cp ./output/"$XVMBUILD_XVM_BRANCH"/latest_"$XVMBUILD_XVM_BRANCH"_xvm.exe ./output/"$XVMBUILD_XVM_BRANCH"/"$XVMBUILD_XVM_REVISION"_"$XVMBUILD_XVM_BRANCH"_xvm.exe

    popd >/dev/null
}

build_sign(){
    pushd "$XVMINST_ROOT_PATH/output" >/dev/null
    sign_file ./setup_xvm.exe
    popd >/dev/null
}

main(){
    detect_os
    detect_wine
    detect_wget
    detect_mercurial
    detect_unzip

    load_repositorystats
    extend_path

    clean_directories

    prepare_changelog
    prepare_defines
    prepare_languages

    build_run

    if [ "$XVMBUILD_SIGN" != "" ]; then
        build_sign
    fi

    build_deploy
}

main
