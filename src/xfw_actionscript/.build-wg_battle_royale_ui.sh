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

set -e

currentdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$currentdir"/../../build_lib/library.sh


detect_os
detect_actionscript_sdk

class="\$AppLinks"
build_as3_swc \
    -source-path wg/battle_ui/royale \
    -source-path wg/battle_ui/ui/* \
    -source-path wg/battle \
    -source-path wg/common_i18n \
    -external-library-path+=../../~output/xfw/swc/wg_battle.swc \
    -output ../../~output/xfw/swc/wg_battle_royale_ui.swc \
    -include-classes $class
