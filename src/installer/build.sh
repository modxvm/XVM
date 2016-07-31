#!/bin/bash

# XVM team (c) www.modxvm.com 2014-2016
# XVM nightly build system

XVMINST_ROOT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
XVMBUILD_ROOT_PATH="$XVMINST_ROOT_PATH/../../"

source "$XVMBUILD_ROOT_PATH"/build/library.sh
source "$XVMBUILD_ROOT_PATH"/build/xvm-build.conf

##########################
####      CONFIG      ####
##########################

# $XVMBUILD_L10N_URL
if [[ "$XVMINST_L10N_URL" == "" ]]; then
    export XVMINST_L10N_URL="http://translate.by-reservation.com/download/xvm-installer/xvminstaller_l10n_isl.zip"
fi


extend_path()
{
    export PATH="$XVMBUILD_ROOT_PATH/build/bin/Windows_i686/innosetup/:$PATH"
}

clean_directories()
{
    rm -rf "$XVMINST_ROOT_PATH"/src/l10n_result/
    mkdir -p "$XVMINST_ROOT_PATH"/src/l10n_result/

    rm -rf "$XVMINST_ROOT_PATH"/src/temp_changelogs/
    mkdir -p  "$XVMINST_ROOT_PATH"/src/temp_changelogs/
}

download_languages(){
    pushd "$XVMINST_ROOT_PATH"/src/l10n_result/ > /dev/null

    wget "$XVMINST_L10N_URL" --output-document=./l10n.zip
    unzip -q -o l10n.zip -d .

    popd > /dev/null
}

generate_defines(){
    pushd "$XVMINST_ROOT_PATH"/src/ >/dev/null

    rm -rf ./xvm_defines.iss
    cp ./xvm_defines_template.iss ./xvm_defines.iss
    sed -i "s/XVM_WOTVERSION/${TARGET_VERSION}/g" ./xvm_defines.iss
    sed -i "s/XVM_VERSION/${XVM_VERSION}/g" ./xvm_defines.iss

    popd >/dev/null
}

prepare_changelog()
{
    cp "$XVMBUILD_ROOT_PATH"/~output/res_mods/mods/shared_resources/xvm/doc/ChangeLog-en.txt "$XVMINST_ROOT_PATH"/src/temp_changelogs/
    iconv -f utf8 -t cp1251 -o "$XVMINST_ROOT_PATH/src/temp_changelogs/ChangeLog-ru.txt" "$XVMBUILD_ROOT_PATH/~output/res_mods/mods/shared_resources/xvm/doc/ChangeLog-ru.txt"
}

generate_languages(){
    pushd "$XVMINST_ROOT_PATH"/src/l10n_result/ >/dev/null
    
    cp "$XVMINST_ROOT_PATH"/src/l10n/en.islu.tpl "$XVMINST_ROOT_PATH"/src/l10n_result/en.islu.tpl

    echo "[Languages]" >> lang.iss    

    for file in *.tpl; do
       lang="${file%.*}"
       cp $file $lang
       sed -i "s/{#VersionWOT}/${TARGET_VERSION}/g" ./$lang
       sed -i "s/{#VersionXVM}/${XVM_VERSION}/g" ./$lang
    done

    for file in *.islu; do
       lang="${file%.*}"
       
       #changelog
       if [ "$lang" == "ru" ];then
           langchg="ru"
       else 
           langchg="en"
       fi
       
       if [ -f "$XVMINST_ROOT_PATH"/src/l10n_inno/"$lang".islu ]; then
           echo "Name: \"$lang\"; MessagesFile: \"l10n_inno\\$lang.islu,l10n_result\\$lang.islu\"; InfoBeforeFile: \"temp_changelogs\\ChangeLog-$langchg.txt\"" >> lang.iss
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

build_sign(){
    pushd "$XVMINST_ROOT_PATH/output" >/dev/null
    
    if [ "$OS" == "Linux" ]; then
        osslsigncode sign \
            -certs "$XVMINST_SIGN_FILE_CERT_SHA256" \
            -key "$XVMINST_SIGN_FILE_KEY" \
            -pass "$XVMINST_SIGN_PASS" \
            -h sha256 \
            -n "$XVMINST_SIGN_APP_NAME" \
            -i "$XVMINST_SIGN_APP_WEBSITE" \
            -ts "$XVMINST_SIGN_TIMESTAMP_SHA256" \
            -in "./setup_xvm.exe" \
            -out "./setup_xvm_signed_sha256.exe"

        mv ./setup_xvm_signed_sha256.exe ./setup_xvm.exe
    else
        echo "[WARN] [INSTALLER] Signing supported only on Linux"
    fi

    popd >/dev/null
}

build_deploy(){
    pushd "$XVMINST_ROOT_PATH/" >/dev/null

    mkdir -p ./output/"$XVMBUILD_XVM_BRANCH"/
    mv ./output/setup_xvm.exe ./output/"$XVMBUILD_XVM_BRANCH"/latest_"$XVMBUILD_XVM_BRANCH"_xvm.exe
    cp ./output/"$XVMBUILD_XVM_BRANCH"/latest_"$XVMBUILD_XVM_BRANCH"_xvm.exe ./output/"$XVMBUILD_XVM_BRANCH"/"$XVMBUILD_XVM_REVISION"_"$XVMBUILD_XVM_BRANCH"_xvm.exe

    popd >/dev/null
}

main(){
    detect_os
    detect_wine
    detect_wget
    detect_mercurial

    load_repositorystats

    extend_path
    clean_directories

    prepare_changelog

    download_languages
    generate_defines
    generate_languages

    build_run

    if [ "$XVMINST_SIGN" != "" ]; then
        build_sign
    fi

    build_deploy
}

main
