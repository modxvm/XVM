"""
This file is part of the XVM project.

Copyright (c) 2013-2018 XVM Team

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

from xfw import *
from xvm_main.python.logger import *


#####################################################################
# fix WG's bug with markers appearing in the top corner on battle start
# https://koreanrandom.com/forum/topic/32423-/page-86#entry395145

import BigWorld
from gui.Scaleform.daapi.view.battle.shared.markers2d.manager import MarkersManager

markersVisibleCallbackID = None

def _set_canvas_visible_true(self):
    global markersVisibleCallbackID
    markersVisibleCallbackID = None
    self.movie.visible = True

@overrideMethod(MarkersManager, 'createMarker')
def _MarkersManager_createMarker(base, self, *args, **kwargs):
    global markersVisibleCallbackID
    self.movie.visible = False
    if markersVisibleCallbackID is not None:
        BigWorld.cancelCallback(markersVisibleCallbackID)
    markersVisibleCallbackID = BigWorld.callback(0, lambda: _set_canvas_visible_true(self))
    return base(self, *args, **kwargs)


#####################################################################
# Debug FullStats

from gui.Scaleform.daapi.view.battle.shared.stats_exchage import BattleStatisticsDataController

@registerEvent(BattleStatisticsDataController, '_BattleStatisticsDataController__setArenaDescription')
def __setArenaDescription(self):
    log('BattleStatisticsDataController.__setArenaDescription()')

@registerEvent(BattleStatisticsDataController, '_BattleStatisticsDataController__onQuestProgressUpdate')
def __onQuestProgressUpdate(self, progressID, conditionVO):
    log('BattleStatisticsDataController.__onQuestProgressUpdate({0}, "{1}")'.format(progressID, conditionVO))

@registerEvent(BattleStatisticsDataController, '_BattleStatisticsDataController__onFullConditionsUpdate')
def __onFullConditionsUpdate(self, *args):
    log('BattleStatisticsDataController.__onFullConditionsUpdate({0})'.format(args))

@registerEvent(BattleStatisticsDataController, '_BattleStatisticsDataController__onHeaderProgressesUpdate')
def __onHeaderProgressesUpdate(self, *args):
    log('BattleStatisticsDataController.__onHeaderProgressesUpdate({0})'.format(args))
