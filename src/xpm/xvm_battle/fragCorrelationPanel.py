""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# imports

import traceback

import BigWorld
from gui.shared.gui_items.Vehicle import VEHICLE_BATTLE_TYPES_ORDER_INDICES
import gui.Scaleform.daapi.view.battle.score_panel as score_panel

from xfw import *

from xvm_main.python.logger import *
import xvm_main.python.config as config


#####################################################################
# handlers

# show quantity of alive instead of dead in frags panel
# original idea/code by yaotzinv: http://forum.worldoftanks.ru/index.php?/topic/1339762-
@overrideMethod(score_panel._FragCorrelationPanel, 'updateScore')
def FragCorrelationPanel_updateScore(base, self):
    try:
        if config.get('fragCorrelation/showAliveNotFrags'):
            if len(self._FragCorrelationPanel__teamsDeaths) and len(self._FragCorrelationPanel__teamsShortLists):
                from gui.battle_control import g_sessionProvider
                isTeamEnemy = g_sessionProvider.getArenaDP().isEnemyTeam
                ally_frags, enemy_frags, ally_vehicles, enemy_vehicles  = (0, 0, 0, 0)
                for teamIdx, vehs in self._FragCorrelationPanel__teamsShortLists.iteritems():
                    if isTeamEnemy(teamIdx):
                        enemy_vehicles += len(vehs)
                    else:
                        ally_vehicles += len(vehs)
                for teamIdx, score in self._FragCorrelationPanel__teamsDeaths.iteritems():
                    if isTeamEnemy(teamIdx):
                        ally_frags += score
                    else:
                        enemy_frags += score
            team_left = ally_vehicles - enemy_frags
            enemy_left = enemy_vehicles - ally_frags
            self._FragCorrelationPanel__callFlash('updateFrags', [team_left, enemy_left])
            return
    except Exception, ex:
        err(traceback.format_exc())
    base(self)


@overrideMethod(score_panel, '_markerComparator')
def _markerComparator(base, x1, x2):
    try:
        if config.get('fragCorrelation/sortByType'):
            INDEX_IS_ALIVE = 2
            INDEX_VEHICLE_CLASS = 1
            res = x2[INDEX_IS_ALIVE] - x1[INDEX_IS_ALIVE]
            if res:
                return res
            x1Index = VEHICLE_BATTLE_TYPES_ORDER_INDICES.get(x1[INDEX_VEHICLE_CLASS], 100)
            x2Index = VEHICLE_BATTLE_TYPES_ORDER_INDICES.get(x2[INDEX_VEHICLE_CLASS], 100)
            res = x1Index - x2Index
            if res:
                return res
            return 0
    except Exception, ex:
        err(traceback.format_exc())
    return base(x1, x2)
