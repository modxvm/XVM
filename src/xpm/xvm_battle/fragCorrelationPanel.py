""" XVM (c) www.modxvm.com 2013-2015 """

import traceback
import BigWorld
from xfw import *
from xvm_main.python.logger import *
import xvm_main.python.config as config


# show quantity of alive instead of dead in frags panel
# original idea/code by yaotzinv: http://forum.worldoftanks.ru/index.php?/topic/1339762-
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
