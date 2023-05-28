#!/bin/bash

# This file is part of the XVM Framework project.
#
# Copyright (c) 2014-2021 XVM Team.
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

set -e

currentdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
XVMBUILD_ROOT_PATH="$currentdir/../../"

# $XVMBUILD_FLAVOR
if [[ "$XVMBUILD_FLAVOR" == "" ]]; then
    export XVMBUILD_FLAVOR="wg"
fi

source "$XVMBUILD_ROOT_PATH/build_lib/library.sh"

mkdir -p "$XVMBUILD_ROOT_PATH/$XVMBUILD_FLAVOR/~output/swf/"

projects="
    xfw_shared
    xfw_access
    xfw
    xvm_shared
    xvm_app
    xvm_lobby
    xvm_lobby_ui
    xvm_lobbycontacts_ui
    xvm_lobbyprofile_ui
    xvm_vehiclemarkers_ui
    xvm_battle_classic
    xvm_battle_comp7
    xvm_battle_epicbattle
    xvm_battle_epicrandom
    xvm_battle_event
    xvm_battle_ranked
    xvm_battle_royale
    xvm_battle_rts
    xvm_battle_stronghold
"

# special projects for WG
if [[ "$XVMBUILD_FLAVOR" == "wg" ]]; then
    projects="
        $projects
    "
fi

# special projects for Lesta
if [[ "$XVMBUILD_FLAVOR" == "lesta" ]]; then
    projects="
        $projects
    "
fi

for project in ${projects}; do
    echo "building ${project}"
    . .build-${project}.sh
done

echo ""
