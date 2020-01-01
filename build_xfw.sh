#!/bin/bash

# This file is part of the XVM Framework project.
#
# Copyright (c) 2014-2020 XVM Team.
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
    args="${args:=actionscript swf packages}" # default - build all

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

    if [[ " $args " =~ " packages " ]]; then
      # build packages
      echo "building xfw: packages"
      pushd src/xfw_packages > /dev/null
      ./build.sh || exit 1
      popd > /dev/null
    fi
}

##########################
####  BUILD PIPELINE  ####
##########################

detect_git

build_source $*
