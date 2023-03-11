#!/bin/bash

# XVM Team (c) https://modxvm.com 2014-2021
# XVM nightly build system functions library

# Text formatting

DEFAULT='\033[0m'       # Reset formatting
BOLD_RED='\033[1;91m'   # Bold Red

#Actionscript constants
AS_VERSION_PLAYERGLOBAL="10.2"
AS_VERSION_PLAYER="10.2"
AS_VERSION_SWF="11"

#Apache Roayler constants
APACHE_ROYALE_DOWNLOADLINK="https://archive.apache.org/dist/royale/0.9.9/binaries/apache-royale-0.9.9-bin-js-swf.tar.gz"
APACHE_ROYALE_VER="0.9.9"

# AS3 compilation
build_as3_swf(){
    if [ "$ASSDK_TYPE" == "royale" ]; then
        "$XVMBUILD_MXMLC_FILEPATH" -targets=SWF -target-player $AS_VERSION_PLAYER -swf-version $AS_VERSION_SWF -load-config $XVMBUILD_ROYALECONFIG_PATH "$@"
    else
        "$XVMBUILD_MXMLC_FILEPATH" -target-player $AS_VERSION_PLAYER -swf-version $AS_VERSION_SWF "$@"
    fi
}

build_as3_swc(){
    if [ "$ASSDK_TYPE" == "royale" ]; then
        "$XVMBUILD_COMPC_FILEPATH" -targets=SWF -target-player $AS_VERSION_PLAYER -swf-version $AS_VERSION_SWF -load-config $XVMBUILD_ROYALECONFIG_PATH "$@"
    else
        "$XVMBUILD_COMPC_FILEPATH" -target-player $AS_VERSION_PLAYER -swf-version $AS_VERSION_SWF "$@"
    fi
}

#Arch and OS detection
detect_arch(){
    if [ "$(uname -m)" == "i686" ] || [ "$OS" == "Windows" ]; then
        export arch=i686
    elif [ "$(uname -m)" == "x86_64" ]; then
        export arch=amd64
    else
        echo -e "${BOLD_RED} Only i686 and amd64 architectures are supported${DEFAULT}"
        exit 1
    fi
}

detect_os(){
    if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        export OS=Linux
    elif [ "$(expr substr $(uname -s) 1 7)" == "MSYS_NT" ]; then
        export OS=Windows
        export OS_Version=$(expr substr $(uname -s) 9 4)
    elif [ "$(expr substr $(uname -s) 1 5)" == "MINGW" ] ||
         [ "$(expr substr $(uname -s) 1 6)" == "CYGWIN" ]; then
        export OS=Windows
    else
        echo -e "${BOLD_RED} Only Linux and Windows are supported${DEFAULT}"
        exit 1
    fi
}
#

#VCS detection
detect_git(){
    if hash git 2>/dev/null; then
        return 0
    else
        echo -e "${BOLD_RED}!!! Git is not found${DEFAULT}"
        return 1
    fi
}

detect_mercurial(){
    if hash hg 2>/dev/null; then
        return 0
    else
        echo -e "${BOLD_RED}!!! Mercurial is not found${DEFAULT}"
        exit 1
    fi
}

git_get_repostats(){
    pushd $1 >/dev/null
    export REPOSITORY_AUTHOR=$(git log -1 --pretty=format:'%an')


    if [[ "$CI_COMMIT_BRANCH" != "" ]]; then
        export REPOSITORY_BRANCH="$CI_COMMIT_BRANCH"
    else
        export REPOSITORY_BRANCH=$(git rev-parse --abbrev-ref HEAD)
    fi
    export REPOSITORY_BRANCH=${REPOSITORY_BRANCH/\//_}

    if [ "$REPOSITORY_BRANCH" = "master" ]; then
        export REPOSITORY_BRANCH_FORFILE=""
    else
        export REPOSITORY_BRANCH_FORFILE="_$REPOSITORY_BRANCH"
    fi

    export REPOSITORY_HASH=$(git log -1 --pretty=format:'%H')
    export REPOSITORY_SUBJECT=$(git log -1 --pretty=format:'%s')
    export REPOSITORY_BODY=$(git log -1 --pretty=format:'%b')
    export REPOSITORY_LAST_TAG=$(git describe --tags --abbrev=0)
    export REPOSITORY_COMMITS_NUMBER=$(printf %04d $(git rev-list $REPOSITORY_LAST_TAG..HEAD --count))
    popd >/dev/null
}
#

#Build software detection
detect_coreutils(){
    if ! (hash sha1sum 2>/dev/null); then
        echo -e "${BOLD_RED}!!! coreutils is not found${DEFAULT}"
        exit 1
    fi
}

detect_ffdec(){
    # export XVMBUILD_FFDEC_FILEPATH to set your own ffec.jar location
    if [ ! -f "$XVMBUILD_FFDEC_FILEPATH" ]; then
        declare -a arr
        arr=$(echo $PATH | tr -s ':' '\n')
        for i in $arr; do
            if [ -f "$i/ffdec.jar" ]; then
                export XVMBUILD_FFDEC_FILEPATH="$i/ffdec.jar"
                return 0
            fi
        done
    fi

    if [ ! -f "$XVMBUILD_FFDEC_FILEPATH" ]; then
        echo -e "${BOLD_RED}!!! FFdec is not found${DEFAULT}"
        exit 1
    fi
}

detect_tar(){
    if ! (hash tar 2>/dev/null); then
        echo -e "${BOLD_RED}!!! tar is not found${DEFAULT}"
        exit 1
    fi
}

# Installs Apache Roayle
install_actionscript_sdk(){
    detect_tar
    detect_wget

    assdk_root="$XVMBUILD_ROOT_PATH/~temp/assdk"
    rm -rf "$1"
    mkdir -p "$1"
    wget $APACHE_ROYALE_DOWNLOADLINK -O "$1/file.tar.gz"
    tar xf "$1/file.tar.gz" -C "$1/" --strip 1
    rm -f "$1/file.tar.gz"
}

# Detects Apache Royale / Apache Flex SDK
#
# Search Order:
#  - $ROYALE_HOME
#  - /opt/apache-royale
#  - C:/Apache Royale/royale-asjs/
#  - <repo>/~downloads/apache_royale_<ver>/
#  - $FLEX_HOME
#  - /opt/apache-flex
#  - $LOCALAPPDATA/FlashDevelop/Apps/flexsdk/4.6.0
#
# Exports:
#  - $ASSDK_HOME
#  - $ASSDK_TYPE
#  - $PLAYERGLOBAL_HOME
#  - $XVMBUILD_MXMLC_FILEPATH
#  - $XVMBUILD_COMPC_FILEPATH
#
# Modifies:
#  - $PATHS+=$ASSDK_HOME/bin
#
detect_actionscript_sdk(){
    detect_java

    if [ "$ROYALE_HOME" != "" -a -d "$ROYALE_HOME" ]; then
        export ASSDK_HOME="$ROYALE_HOME"
        export ASSDK_TYPE="royale"
    elif [ -d "/c/Apache Royale/royale-asjs" ]; then
        export ASSDK_HOME="/c/Apache Royale/royale-asjs"
        export ASSDK_TYPE="royale"
    elif [ -d "/opt/apache-royale/royale-asjs" ]; then
        export ASSDK_HOME="/opt/apache-royale/royale-asjs"
        export ASSDK_TYPE="royale"
    elif [ -d "$XVMBUILD_ROOT_PATH/~downloads/as_sdk_$APACHE_ROYALE_VER/royale-asjs" ]; then
        export ASSDK_HOME="$XVMBUILD_ROOT_PATH/~downloads/as_sdk_$APACHE_ROYALE_VER/royale-asjs"
        export ASSDK_TYPE="royale"
    elif [ "$FLEX_HOME" != "" -a -d "$FLEX_HOME" ]; then
        export ASSDK_HOME="$FLEX_HOME"
        export ASSDK_TYPE="flex"
    elif [ -d "/opt/apache-flex" ]; then
        export ASSDK_HOME="/opt/apache-flex"
        export ASSDK_TYPE="flex"
    elif [ -d "$LOCALAPPDATA/FlashDevelop/Apps/flexsdk/4.6.0" ]; then
        export ASSDK_HOME="$LOCALAPPDATA/FlashDevelop/Apps/flexsdk/4.6.0"
        export ASSDK_TYPE="flex"
    fi

    #download if not found
    if [ ! -d "$ASSDK_HOME" ]; then
        install_actionscript_sdk "$XVMBUILD_ROOT_PATH/~downloads/as_sdk_$APACHE_ROYALE_VER"
        export ASSDK_HOME="$XVMBUILD_ROOT_PATH/~downloads/as_sdk_$APACHE_ROYALE_VER/royale-asjs"
        export ASSDK_TYPE="royale"

        if [ ! -d "$ASSDK_HOME" ]; then
            echo -e "${BOLD_RED}!!! Apache Royale/Flex error on download${DEFAULT}"
            exit 1
        fi
    fi

    # extend PATH and set XVMBUILD_MXMLC_FILEPATH and XVMBUILD_COMPC_FILEPATH
    export PATH=$PATH:$ASSDK_HOME/bin/
    if [ "$ASSDK_TYPE" = "royale" ]; then
        export XVMBUILD_MXMLC_FILEPATH="$ASSDK_HOME/js/bin/mxmlc"
        export XVMBUILD_COMPC_FILEPATH="$ASSDK_HOME/js/bin/compc"
    else
        export XVMBUILD_MXMLC_FILEPATH="$ASSDK_HOME/bin/mxmlc"
        export XVMBUILD_COMPC_FILEPATH="$ASSDK_HOME/bin/compc"
    fi

    #check if mxmlc exists
    if [ ! -f "$XVMBUILD_MXMLC_FILEPATH" ]; then
        echo -e "${BOLD_RED}!!! Apache Royale/Flex mxmlc file is not found${DEFAULT}"
        exit 1
    fi

    #check if compc exists
    if [ ! -f "$XVMBUILD_COMPC_FILEPATH" ]; then
        echo -e "${BOLD_RED}!!! Apache Royale/Flex compc file is not found${DEFAULT}"
        exit 1
    fi

    # fallback PLAYERGLOBAL_HOME variable
    if [ "$PLAYERGLOBAL_HOME" == "" ]; then
        export PLAYERGLOBAL_HOME="$ASSDK_HOME/frameworks/libs/player"
    fi

    # download playerglobal if not found
    for playerglobalver in $AS_VERSION_PLAYERGLOBAL
    do
        if [ ! -f "$PLAYERGLOBAL_HOME/$playerglobalver/playerglobal.swc" ]; then
            if ! detect_wget; then
                exit 1
            fi
            mkdir -p "$PLAYERGLOBAL_HOME/$playerglobalver/"
            wget "https://github.com/nexussays/playerglobal/raw/master/$playerglobalver/playerglobal.swc" --output-document="$PLAYERGLOBAL_HOME/$playerglobalver/playerglobal.swc"
        fi
    done

    # set roayle config path
    export XVMBUILD_ROYALECONFIG_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/royale_toolchain/xvm-config.xml"
}

detect_java(){
    #skip if already detected
    if [[ "$XVMBUILD_JAVA_FILEPATH" != "" ]]; then
        return
    fi

    #find os
    detect_os

    #check full path for windows
    if [[ "$XVMBUILD_JAVA_FILEPATH" == "" ]]; then
        if [ "$OS" == "Windows" ]; then
            if [ -f "/c/Software/Java/jdk-19/bin/java.exe" ]; then
                export PATH=$PATH:/c/Software/Java/jdk-19/bin/
                export XVMBUILD_JAVA_FILEPATH="/c/Software/Java/jdk-19/bin/java.exe"
            fi
        fi
    fi

    #*nix and fallback
    if [[ "$XVMBUILD_JAVA_FILEPATH" == "" ]]; then
        if hash "java" 2>/dev/null; then
            export XVMBUILD_JAVA_FILEPATH="java"
        fi
    fi

    #check results
    if [[ "$XVMBUILD_JAVA_FILEPATH" == "" ]]; then
        echo -e "${BOLD_RED}!!! Java is not found${DEFAULT}"
        exit 1
    fi
}

detect_mono(){
    # export XVMBUILD_MONO_FILENAME to use mono on windows
    if [ "$XVMBUILD_MONO_FILENAME" == "" ]; then
        if [ "$OS" == "Windows" ]; then
            export XVMBUILD_MONO_FILENAME=
        else
            if hash mono 2>/dev/null; then
                export XVMBUILD_MONO_FILENAME=mono
            else
                echo -e "${BOLD_RED}!!! Mono is not found${DEFAULT}"
                exit 1
            fi
        fi
    else
        if hash "$XVMBUILD_MONO_FILENAME" 2>/dev/null; then
            return 0
        else
            echo -e "${BOLD_RED}!!! Mono is not found${DEFAULT}"
            exit 1
        fi
    fi
}

detect_mtasc(){
    if ! (hash mtasc 2>/dev/null); then
        echo -e "${BOLD_RED}!!! MTASC is not found${DEFAULT}"
        exit 1
    fi
}

detect_patch(){
    if ! (hash patch 2>/dev/null); then
        echo -e "${BOLD_RED}!!! Patch is not found${DEFAULT}"
        exit 1
    fi
}

detect_python(){
    detect_os

    #check full path for windows
    if [[ "$XVMBUILD_PYTHON_FILEPATH" == "" ]]; then
        if [ "$OS" == "Windows" ]; then
            if [ -f "/c/Python27/python.exe" ]; then
                export XVMBUILD_PYTHON_FILEPATH="/c/Python27/python.exe"  #Windows default path
            elif [ -f "/c/Software/Python/27_64/python.exe" ]; then
                export XVMBUILD_PYTHON_FILEPATH="/c/Software/Python/27_64/python.exe"  #Mikhail's path
            elif [ -f "/c/Software/Python27/python.exe" ]; then
                export XVMBUILD_PYTHON_FILEPATH="/c/Software/Python27/python.exe"  #Mikhail's second path
            elif [ -f "/c/Program Files/Python27/python.exe" ]; then
                export XVMBUILD_PYTHON_FILEPATH="/c/Program Files/Python27/python.exe"  #MSVS default path
            fi
        fi
    fi

    #*nix and fallback
    if [[ "$XVMBUILD_PYTHON_FILEPATH" == "" ]]; then
        if hash "python2.7" 2>/dev/null; then
            export XVMBUILD_PYTHON_FILEPATH="python2.7" #Installed by cygwin or *nix
        elif hash "python2" 2>/dev/null; then
            export XVMBUILD_PYTHON_FILEPATH="python2"   #Installed by cygwin or *nix
        elif hash "python" 2>/dev/null; then
            export XVMBUILD_PYTHON_FILEPATH="python"    #Default name of python executable
        fi
    fi

    #check results
    if [[ "$XVMBUILD_PYTHON_FILEPATH" == "" ]]; then
        echo -e "${BOLD_RED}!!! Python 2.7 is not found${DEFAULT}"
        exit 1
    fi

    #Check python version
    pythonver=$("$XVMBUILD_PYTHON_FILEPATH" --version 2>&1)
    if [[ ${pythonver:7:3} != "2.7" ]]; then
        echo -e "${BOLD_RED} Python 2.7 is not found. Current version is: ${pythonver:7:3}${DEFAULT}"
        exit 1
    fi
}

detect_wget(){
    if ! (hash wget 2>/dev/null); then
        echo -e "${BOLD_RED}!!! wget is not found${DEFAULT}"
        exit 1
    fi
}

detect_wine(){
    if [ "$OS" != "Windows" ]; then
        if hash wine 2>/dev/null; then
            export WINEDEBUG=-all
            export XVMBUILD_WINE_FILENAME="wine"
            return 0
        else
            echo -e "${BOLD_RED}!!! Wine is not found${DEFAULT}"
            exit 1
        fi
    else
        export XVMBUILD_WINE_FILENAME=
    fi
}

detect_unzip(){
    if ! (hash unzip 2>/dev/null); then
        echo -e "${BOLD_RED}!!! unzip is not found${DEFAULT}"
        exit 1
    fi
}

detect_zip(){
    if ! (hash zip 2>/dev/null); then
        echo -e "${BOLD_RED}!!! zip is not found${DEFAULT}"
        exit 1
    fi
}

detect_pandoc(){
    if ! (hash pandoc 2>/dev/null); then
        echo -e "${BOLD_RED}!!! pandoc is not found${DEFAULT}"
        exit 1
    fi
}

#used in: /build/ci/ci_deploy.sh
clean_repodir(){
    pushd "$XVMBUILD_ROOT_PATH" > /dev/null

    rm -rf src/xvm/lib/*
    rm -rf src/xvm/obj/
    rm -rf src/xfw/src/actionscript/lib/*
    rm -rf src/xfw/src/actionscript/obj/*
    rm -rf src/xfw/src/actionscript/output/*
    rm -rf ~output/
    rm -rf src/xfw/~output/
    rm -rf src/xfw/~output_package/
    rm -rf src/xfw/~output_wotmod/

    rm -rf xvminst/

    popd > /dev/null
}


sign_file(){
    if [ "$OS" == "Linux" ]; then
        if ! (hash osslsigncode 2>/dev/null); then
            echo -e "${BOLD_RED}!!! osslsigncode is not found${DEFAULT}"
            exit 1
        fi
        echo "Signing $1"
        osslsigncode sign \
            -certs "$XVMBUILD_SIGN_FILE_CERT_SHA256" \
            -key "$XVMBUILD_SIGN_FILE_KEY" \
            -pass "$XVMBUILD_SIGN_PASS" \
            -h sha256 \
            -n "$XVMBUILD_SIGN_APP_NAME" \
            -i "$XVMBUILD_SIGN_APP_WEBSITE" \
            -t "$XVMBUILD_SIGN_TIMESTAMP_SHA256" \
            -in "$1" \
            -out "$1_signed"

        mv "$1_signed" "$1"
    else
        echo "[WARN] Signing supported only on Linux"
    fi
}

sign_files_in_directory()
{
    files=$(find $1 -type f \( -name "*.dll" -o -name "*.pyd" \) )
    for file in $files ; do
        sign_file "$file"
    done
}
