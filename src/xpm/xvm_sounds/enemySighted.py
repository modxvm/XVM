""" XVM (c) https://modxvm.com 2013-2021 """

# Authors:
# night_dragon_on <https://kr.cm/f/p/14897/>
# sirmax <max(at)modxvm.com>

#####################################################################
# imports

import SoundGroups
from Avatar import PlayerAvatar
from gui.Scaleform.daapi.view.battle.shared.minimap.entries import VehicleEntry
import traceback

from xfw import *
import xvm_main.python.config as config
from xvm_main.python.logger import *

#####################################################################
# constants

class XVM_SOUND_EVENT(object):
    ENEMY_SIGHTED = "xvm_enemySighted"

#####################################################################
# handlers

enemyList = {}

@overrideMethod(PlayerAvatar, 'onBecomeNonPlayer')
def _PlayerAvatar_onBecomeNonPlayer(base, self):
    try:
        global enemyList
        enemyList.clear()
    except Exception, ex:
        err(traceback.format_exc())
    base(self)

@registerEvent(VehicleEntry, 'setActive')
def setActive(self, active):
    #log('setActive: {} {} {} {}'.format(self._entryID, self._isEnemy, self._isActive, self._isInAoI))
    try:
        if self._isEnemy and self._isActive: # and self._isInAoI?
            if config.get('sounds/enabled'):
                global enemyList
                if not self._entryID in enemyList:
                    enemyList[self._entryID] = True
                    SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.ENEMY_SIGHTED)
    except:
        err(traceback.format_exc())
