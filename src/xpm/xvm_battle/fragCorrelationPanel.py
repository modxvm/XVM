""" XVM (c) www.modxvm.com 2013-2015 """

import traceback
import BigWorld
from xfw import *
from xvm_main.python.logger import *
import xvm_main.python.config as config


# show quantity of alive instead of dead in frags panel
# original idea/code by yaotzinv: http://forum.worldoftanks.ru/index.php?/topic/1339762-
def FragCorrelationPanel_updateScore(base, self, playerTeam):
    try:
        if config.get('fragCorrelation/showAliveNotFrags'):
            if not playerTeam:
                return
            teamIndex = playerTeam - 1
            enemyIndex = 1 - teamIndex
            enemyTeam = enemyIndex + 1
            team_left = len(self._FragCorrelationPanel__teamsShortLists[playerTeam]) - self._FragCorrelationPanel__teamsFrags[enemyIndex]
            enemy_left = len(self._FragCorrelationPanel__teamsShortLists[enemyTeam]) - self._FragCorrelationPanel__teamsFrags[teamIndex]
            self._FragCorrelationPanel__callFlash('updateFrags', [team_left, enemy_left])
            return
    except Exception, ex:
        err(traceback.format_exc())
    base(self, playerTeam)
