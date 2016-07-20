#!/bin/bash

# XVM team (c) www.modxvm.com 2014-2016
# XVM nightly build system

CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$CURRENT_PATH"

source ../library.sh
export XVMBUILD_REPOSITORY_PATH="$CURRENT_PATH/../.."

load_repositorystats