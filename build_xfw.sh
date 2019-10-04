#!/bin/bash

# This file is part of the XVM Framework project.
#
# Copyright (c) 2014-2019 XVM Team.
#
# XVM Framework is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as
# published by the Free Software Foundation, version 3.
#
# XVM Framework is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#


##########################
#  PREPARE ENVIRONMENT   #
##########################

XVMBUILD_ROOT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$XVMBUILD_ROOT_PATH"

source ./build_lib/library.sh
source ./build/xvm-build.conf


##########################
####      CONFIG      ####
##########################

if [ "$XFW_BUILD_CLEAR" == "" ]; then
  export XFW_BUILD_CLEAR=1
fi
if [ "$XFW_BUILD_LIBS" == "" ]; then
  export XFW_BUILD_LIBS=1
fi


##########################
####  BUILD FUNCTIONS ####
##########################

build_source()
{
    args="$*"
    args="${args:=actionscript swf python packages}" # default - build all

    if [[ " $args " =~ " actionscript " ]]; then
      # build actionscript
      echo "building xfw: actionscript"
      pushd src/xfw_actionscript > /dev/null
      ./build.sh || exit 1
      popd > /dev/null
    fi

    if [[ " $args " =~ " swf " ]]; then
      # patch swfs
      echo "building xfw: swf"
      pushd src/xfw_swf > /dev/null
      ./build.sh || exit 1
      popd > /dev/null
    fi

    if [[ " $args " =~ " python " ]]; then
      # build python
      echo "building xfw: python"
      pushd src/xfw_python > /dev/null
      ./build.sh || exit 1
      popd > /dev/null
    fi

    if [[ " $args " =~ " packages " ]]; then
      # build packages
      echo "building xfw: packages"
      pushd src/xfw_packages > /dev/null
      ./build.sh || exit 1
      popd > /dev/null
    fi
}

build_wotmod()
{
    git_get_repostats "$XVMBUILD_ROOT_PATH"

    rm -rf "~output_wotmod/xfw/"

    mkdir -p "~output_wotmod/xfw/"
    mkdir -p "~output_wotmod/xfw/res/scripts/client/gui/mods/"
    mkdir -p "~output_wotmod/xfw/res/mods/"
    mkdir -p "~output_wotmod/xfw/res/mods/xfw/python/"

    cp -rf "~output/python/scripts/." "~output_wotmod/xfw/res/scripts/"

    cp -rf "~output/python/mods/xfw/." "~output_wotmod/xfw/res/mods/xfw/"

    cp "src/wotmod/meta.xml.in" "~output_wotmod/xfw/meta.xml"
    sed -i s/XFW_VERSION/$XVMBUILD_XVM_VERSION.$REPOSITORY_COMMITS_NUMBER$REPOSITORY_BRANCH_FORFILE/g "~output_wotmod/xfw/meta.xml"

    cp "LICENSE.txt" "~output_wotmod/xfw/LICENSE" 
    
    echo "$XVMBUILD_XVM_VERSION" > '~output_wotmod/xfw/res/mods/xfw/VERSION'

    pushd ~output_wotmod/xfw/ > /dev/null
    zip -0 -X -q -r ../com.modxvm.xfw_$XVMBUILD_XVM_VERSION.$REPOSITORY_COMMITS_NUMBER$REPOSITORY_BRANCH_FORFILE.wotmod ./*
    popd > /dev/null

    rm -r ~output_wotmod/xfw/
}


##########################
####  BUILD PIPELINE  ####
##########################

detect_git

build_source $*
build_wotmod
