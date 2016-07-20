#!/bin/bash

# XVM team (c) www.modxvm.com 2014-2016
# XVM nightly build system

CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$CURRENT_PATH"
export XVMBUILD_REPOSITORY_PATH="$CURRENT_PATH/../.."

source /var/xvm/ci_config.sh
source "$XVMBUILD_REPOSITORY_PATH/build/xvm-build.conf"
source "$XVMBUILD_REPOSITORY_PATH/build/library.sh"

build(){
  hg clone "$XVMINST_REPO" "$XVMBUILD_REPOSITORY_PATH/xvminst"
  "$XVMBUILD_REPOSITORY_PATH/xvminst/build.sh"
}

load_repositorystats
build