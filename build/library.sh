#!/bin/bash

# XVM team (c) www.modxvm.com 2014-2015
# XVM nightly build system functions library

#constants
PLAYERGLOBAL_VERSION="11.0"

#AS2/3 compilation and patching
build_as2_h(){
    $XVMBUILD_MONO_FILENAME "$XVMBUILD_FDBUILD_FILEPATH" $1.as2proj -version "1.14" -notrace > /dev/null || exit 1
}

build_as3_h(){
    $XVMBUILD_MONO_FILENAME "$XVMBUILD_FDBUILD_FILEPATH" -notrace -compiler:"$FLEX_HOME" -cp:"" "$1" > /dev/null || exit 1
}

patch_as2_h(){
    swfmill swf2xml orig/$1.swf temp/$1.xml || exit 1
    patch temp/$1.xml $1.xml.patch || exit 1
    swfmill xml2swf temp/$1.xml $1.swf || exit 1
}
#

#Arch and OS detection
detect_arch(){
    if [ "$(uname -m)" == "x86_64" ]; then
        export arch=amd64
    elif [ "$(uname -m)" == "i686" ]; then
        export arch=i686
    else
        echo "!!! Only i686 and amd64 architectures are supported"
        exit 1
    fi
}

detect_os(){
    if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        export OS=Linux
    elif [ "$(expr substr $(uname -s) 1 4)" == "MSYS"   ] ||
         [ "$(expr substr $(uname -s) 1 5)" == "MINGW"  ] ||
         [ "$(expr substr $(uname -s) 1 6)" == "CYGWIN" ]; then
        export OS=Windows
    else
        echo "!!! Only Linux and Windows are supported"
        exit 1
    fi
}
#

#VCS detection
detect_git(){
    if hash git 2>/dev/null; then
        return 0
    else
        echo "!!! Git is not found"
        return 1
    fi
}

detect_mercurial(){
    if hash hg 2>/dev/null; then
        return 0
    else
        echo "!!! Mercurial is not found"
        return 1
    fi
}
#

#Build software detection
detect_coreutils(){
    if !(hash sha1sum 2>/dev/null); then
        echo "!!! coreutils is not found"
        exit 1
    fi
}
detect_fdbuild(){
	#export XVMBUILD_FDBUILD_FILEPATH to set your own fdbuild.exe location
    if [ "$XVMBUILD_FDBUILD_FILEPATH" == "" ]; then
        declare -a arr
        arr=$(echo $PATH | tr -s ':' '\n')
        for i in $arr; do
            if [ -f "$i/fdbuild.exe" ]; then
                export XVMBUILD_FDBUILD_FILEPATH="$i/fdbuild.exe"
                return 0
            fi
        done
    fi

    if [ ! -f "$XVMBUILD_FDBUILD_FILEPATH" ]; then
        echo "!!! FlashDevelop fdbuild.exe is not found"
        exit 1
    fi
}

detect_flex(){
	# export FLEX_HOME variable to set your own Apache Flex location
    # fallback FLEX_HOME variable
    if [ "$FLEX_HOME" == "" ]; then
        if [[ "$OS" == "Windows" ]]; then
            export FLEX_HOME="$LOCALAPPDATA/FlashDevelop/Apps/flexsdk/4.6.0"
        else    
            export FLEX_HOME="/opt/apache-flex"
        fi
    fi

    # extend PATH
    export PATH=$PATH:$FLEX_HOME/bin/

    if !(hash "$FLEX_HOME/bin/mxmlc"); then
        echo "!!! Apache Flex is not found"
        exit 1
    fi

    export XVMBUILD_COMPC_FILEPATH="$FLEX_HOME/bin/compc"

    #  fallback PLAYERGLOBAL_HOME variable
    if [ "$PLAYERGLOBAL_HOME" == "" ]; then
        export PLAYERGLOBAL_HOME="$FLEX_HOME/frameworks/libs/player" 
    fi

    # download playerglobal if not found
    if [ ! -f "$PLAYERGLOBAL_HOME/$PLAYERGLOBAL_VERSION/playerglobal.swc" ]; then
        if ! detect_wget; then
            exit 1
        fi
        mkdir -p "$PLAYERGLOBAL_HOME/$PLAYERGLOBAL_VERSION/"
        wget --quiet "https://github.com/nexussays/playerglobal/raw/master/$PLAYERGLOBAL_VERSION/playerglobal.swc" --output-document="$PLAYERGLOBAL_HOME/$PLAYERGLOBAL_VERSION/playerglobal.swc"
    fi
}

detect_mono(){
	#export XVMBUILD_MONO_FILENAME to use mono on windows
    if [ "$XVMBUILD_MONO_FILENAME" == "" ]; then 
        if [ "$OS" == "Windows" ]; then
            export XVMBUILD_MONO_FILENAME=
        else
            if hash mono 2>/dev/null; then
                export XVMBUILD_MONO_FILENAME=mono
            else
                echo "!!! Mono is not found"
                exit 1
            fi
        fi
    else
        if hash "$XVMBUILD_MONO_FILENAME" 2>/dev/null; then
            return 0
        else
            echo "!!! Mono is not found"
            exit 1
        fi
    fi
}

detect_mtasc(){
    if !(hash mtasc 2>/dev/null); then
        echo "!!! MTASC is not found"
        exit 1
    fi
}

detect_patch(){
    if !(hash patch 2>/dev/null); then
        echo "!!! Patch is not found"
        exit 1
    fi
}

detect_python(){
    if [[ "$XVMBUILD_PYTHON_FILEPATH" == "" ]]; then
        export XVMBUILD_PYTHON_FILEPATH="/cygdrive/c/Python27/python.exe"
        if [ ! -f $XVMBUILD_PYTHON_FILEPATH ]; then
            export XVMBUILD_PYTHON_FILEPATH="python2.7" # Installed by cygwin or *nix
        fi
    fi

    if !(hash "$XVMBUILD_PYTHON_FILEPATH" 2>/dev/null); then
        echo "!!! Python 2.7 is not found"
        exit 1
    fi
}

detect_swfmill(){
    if !(hash swfmill 2>/dev/null); then
        echo "!!! swfmill is not found"
        exit 1
    fi
}

detect_wget(){
    if !(hash wget 2>/dev/null); then
        echo "!!! wget is not found"
        exit 1
    fi
}

detect_zip(){
    if !(hash zip 2>/dev/null); then
        echo "!!! zip is not found"
        exit 1
    fi
}
