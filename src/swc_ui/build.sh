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

projects="
    wg_lobby_ui
    wg_battle_classic_ui
    wg_battle_event_ui
    wg_battle_epicbattle_ui
    wg_battle_epicrandom_ui
    wg_battle_ranked_ui
    wg_battle_royale_ui
    wg_vm_ui
"

# cosmic is the WG exclusive
if [[ "$XVMBUILD_FLAVOR" == "wg" ]]; then
    projects="
        $projects 
        wg_battle_cosmic_ui
    "
fi

for project in ${projects}; do
    echo "building ${project}"
    . .build-${project}.sh
done

echo ""
