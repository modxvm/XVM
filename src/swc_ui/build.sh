#!/bin/bash

# SPDX-License-Identifier: LGPL-3.0-or-later
# Copyright (c) 2013-2025 XVM Contributors

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
    wg_battle_comp7_ui
    wg_battle_event_ui
    wg_battle_epicbattle_ui
    wg_battle_epicrandom_ui
    wg_battle_ranked_ui
    wg_battle_royale_ui
    wg_battle_storymode_ui
    wg_vm_ui
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
