#!/bin/bash

# XVM team (c) www.modxvm.com 2014-2016
# XVM nightly build system functions library

#constants
PLAYERGLOBAL_VERSIONS="11.0 11.1"

# AS3 compilation
build_as3_h(){
    $XVMBUILD_MONO_FILENAME "$XVMBUILD_FDBUILD_FILEPATH" -notrace -compiler:"$FLEX_HOME" -cp:"" "$1" > /dev/null || exit 1
}

#Arch and OS detection
detect_arch(){
    if [ "$(uname -m)" == "i686" ] || [ "$OS" == "Windows" ]; then
        export arch=i686
    elif [ "$(uname -m)" == "x86_64" ]; then
        export arch=amd64
    else
        echo "!!! Only i686 and amd64 architectures are supported"
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
        echo "!!! FFdec is not found"
        exit 1
    fi
}

detect_fdbuild(){
    # export XVMBUILD_FDBUILD_FILEPATH to set your own fdbuild.exe location
    if [ ! -f "$XVMBUILD_FDBUILD_FILEPATH" ]; then
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

    #check if directory exists
    if [ ! -d "$FLEX_HOME" ]; then
        echo "!!! Apache Flex directory is not found"
        exit 1
    fi

    # extend PATH and set XVMBUILD_COMPC_FILEPATH
    export PATH=$PATH:$FLEX_HOME/bin/
    export XVMBUILD_COMPC_FILEPATH="$FLEX_HOME/bin/compc"
   
    #check if compc exists
    if [ ! -f  "$XVMBUILD_COMPC_FILEPATH" ]; then
        echo "!!! Apache Flex compc file is not found"
        exit 1
    fi

    # fallback PLAYERGLOBAL_HOME variable
    if [ "$PLAYERGLOBAL_HOME" == "" ]; then
        export PLAYERGLOBAL_HOME="$FLEX_HOME/frameworks/libs/player" 
    fi

    # download playerglobal if not found
    for playerglobalver in $PLAYERGLOBAL_VERSIONS
    do
        if [ ! -f "$PLAYERGLOBAL_HOME/$playerglobalver/playerglobal.swc" ]; then
            if ! detect_wget; then
                exit 1
            fi
            mkdir -p "$PLAYERGLOBAL_HOME/$playerglobalver/"
            wget --quiet "https://github.com/nexussays/playerglobal/raw/master/$playerglobalver/playerglobal.swc" --output-document="$PLAYERGLOBAL_HOME/$playerglobalver/playerglobal.swc"
        fi
    done
}

detect_java(){
    if !(hash java 2>/dev/null); then
        echo "!!! java is not found"
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
        if hash "/c/Python27/python.exe" 2>/dev/null; then
            export XVMBUILD_PYTHON_FILEPATH="/c/Python27/python.exe"  #Windows default path
        fi
        if hash "python" 2>/dev/null; then
            export XVMBUILD_PYTHON_FILEPATH="python"                  #Default name of python executable
        fi
        if hash "python2.7" 2>/dev/null; then
            export XVMBUILD_PYTHON_FILEPATH="python2.7"               #Installed by cygwin or *nix
        fi
    fi

    if !(hash "$XVMBUILD_PYTHON_FILEPATH" 2>/dev/null); then          #Check if file exists
        echo "!!! Python 2.7 is not found"
        exit 1
    fi

    #Check python version
    pythonver=$($XVMBUILD_PYTHON_FILEPATH --version 2>&1)
    if [[ ${pythonver:7:3} != "2.7" ]]; then          
        echo "!!! Python 2.7 is not found. Current version is: ${pythonver:7:3}"
        exit 1
    fi
}

detect_wget(){
    if !(hash wget 2>/dev/null); then
        echo "!!! wget is not found"
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
            echo "!!! Wine is not found"
            return 1
        fi
    else
        export XVMBUILD_WINE_FILENAME=
    fi
}

detect_unzip(){
    if !(hash unzip 2>/dev/null); then
        echo "!!! unzip is not found"
        exit 1
    fi
}

detect_zip(){
    if !(hash zip 2>/dev/null); then
        echo "!!! zip is not found"
        exit 1
    fi
}

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

#Cleaners

clean_repodir(){
    pushd "$XVMBUILD_ROOT_PATH" > /dev/null

    rm -rf src/xvm/lib/*
    rm -rf src/xvm/obj/
    rm -rf src/xfw/src/actionscript/lib/*
    rm -rf src/xfw/src/actionscript/obj/*
    rm -rf src/xfw/src/actionscript/output/*
    rm -rf ~output/
    rm -rf src/xfw/~output/

    rm -rf xvminst/

    popd > /dev/null
}
