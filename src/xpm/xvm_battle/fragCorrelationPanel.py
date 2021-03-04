""" XVM (c) https://modxvm.com 2013-2021 """

#####################################################################
# imports

import traceback

from Avatar import PlayerAvatar
from gui.Scaleform.daapi.view.battle.classic.stats_exchange import FragsCollectableStats
from gui.shared import g_eventBus

from xfw import *
from xvm_main.python import config


#####################################################################
# globals

ally_frags = 0
enemy_frags = 0
ally_vehicles = 0
enemy_vehicles = 0

#####################################################################
# handlers

# show quantity of alive instead of dead in frags panel
# night_dragon_on <https://kr.cm/f/p/14897/>

def cleanup():
    global ally_frags, enemy_frags, ally_vehicles, enemy_vehicles
    ally_frags = 0
    enemy_frags = 0
    ally_vehicles = 0
    enemy_vehicles = 0

# AFTER-BATTLE

@registerEvent(PlayerAvatar, '_PlayerAvatar__destroyGUI')
def destroyGUI(self):
    cleanup()

# BATTLE

@overrideMethod(FragsCollectableStats, 'getTotalStats')
def _FragCorrelationPanel_getTotalStats(base, self, arenaVisitor, sessionProvider):
    try:
        global ally_frags, enemy_frags, ally_vehicles, enemy_vehicles
        arenaDP = sessionProvider.getArenaDP()
        isEnemyTeam = arenaDP.isEnemyTeam

        ally_frags, enemy_frags = (0, 0)
        for teamIdx, vehicleIDs in self._FragsCollectableStats__teamsDeaths.iteritems():
            score = len(vehicleIDs)
            if isEnemyTeam(teamIdx):
                ally_frags += score
            else:
                enemy_frags += score

        ally_vehicles = arenaDP.getAlliesVehiclesNumber()
        enemy_vehicles = arenaDP.getEnemiesVehiclesNumber()

        if config.get('fragCorrelation/showAliveNotFrags'):
            allyScope = ally_vehicles - enemy_frags
            enemyScope = enemy_vehicles - ally_frags
        else:
            allyScope = ally_frags
            enemyScope = enemy_frags

        self._setTotalScore(allyScope, enemyScope)
        if allyScope or enemyScope:
            return {'leftScope': allyScope, 'rightScope': enemyScope}
        else:
            return {}
    except Exception, ex:
        err(traceback.format_exc())
    base(self, arenaVisitor, sessionProvider)
