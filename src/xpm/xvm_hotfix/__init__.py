"""
This file is part of the XVM project.

Copyright (c) 2013-2019 XVM Team.

XVM is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as
published by the Free Software Foundation, version 3.

XVM is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
"""

#####################################################################
# imports

import traceback

import base64
from account_helpers.CustomFilesCache import CustomFilesCache

from xfw import *
from xvm_main.python.logger import *

#####################################################################
# handlers

@overrideMethod(CustomFilesCache, '_CustomFilesCache__onReadLocalFile')
def _CustomFilesCache__onReadLocalFile(base, self, url, showImmediately):
    try:
        base(self, url, showImmediately)
    except EOFError:
        err('CustomFilesCache.__onReadLocalFile: url="{0}"'.format(url))
        err(traceback.format_exc())
        try:
            log('Attempt to reload url: {0}'.format(url))
            del(self._CustomFilesCache__db[base64.b32encode(url)])
            base(self, url, showImmediately)
        except Exception:
            err(traceback.format_exc())

#####################################################################
# Festival config key error fix
# -------------------------
# Fixed typical error:
#    Traceback (most recent call last):
#      File "scripts/common/Event.py", line 44, in __call__
#      File "scripts/client/gui/Scaleform/framework/managers/containers.py", line 1328, in __onViewLoaded
#      File "scripts/client/gui/Scaleform/framework/managers/containers.py", line 1285, in __showAndInitializeView
#      File "scripts/client/gui/Scaleform/framework/entities/DisposableEntity.py", line 63, in create
#      File "scripts/client/helpers/uniprof/regions.py", line 84, in wrapper
#      File "scripts/client/gui/Scaleform/daapi/view/battle/shared/page.py", line 194, in _populate
#      File "scripts/client/gui/Scaleform/daapi/view/battle/shared/page.py", line 256, in _definePostmortemPanel
#      File "controller", line 72, in isEnabled
#    KeyError: 'isEnabled'
# -------------------------
# Author: Pavel3333

from festivity.festival.controller import FestivalController, FEST_CONFIG

@overrideMethod(FestivalController, 'isEnabled')
def _FestivalController_isEnabled(base, self):
    if self._FestivalController__bootcampController.isInBootcamp():
        return False
    festival_config = self._FestivalController__lobbyContext.getServerSettings().getFestivalConfig()
    return festival_config.get(FEST_CONFIG.FESTIVAL_ENABLED, False) and festival_config.get(FEST_CONFIG.PLAYER_CARDS_ENABLED, False)

#####################################################################
# Festival race error fix
# -------------------------
# Fixed typical error:
#    Traceback (most recent call last):
#      File "scripts/common/Event.py", line 44, in __call__
#      File "scripts/client/gui/Scaleform/daapi/view/battle/event/festival_race/minimap.py", line 191, in __onVehicleStateUpdated
#    AttributeError: 'NoneType' object has no attribute 'raceList'
# -------------------------
# Author: night_dragon_on

import BigWorld
from gui.Scaleform.daapi.view.battle.event.festival_race.minimap import FestivalRaceMinimapComponent

@overrideMethod(FestivalRaceMinimapComponent, '_FestivalRaceMinimapComponent__onVehicleStateUpdated')
def _FestivalRaceMinimapComponent_onVehicleStateUpdated(base, self, state, value):
    if hasattr(BigWorld.player().arena.arenaInfo, 'raceList'):
        base(self, state, value)