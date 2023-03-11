"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2016-2022 XVM Contributors
Copyright (c) 2016-2021 night_dragon_on <https://kr.cm/f/p/14897/>
"""

#
# imports
#

# stdlib
import logging

# BigWorld
import SoundGroups
from PlayerEvents import g_playerEvents
from gui.Scaleform.daapi.view.battle.shared.minimap.entries import VehicleEntry

# XFW
from xfw.events import registerEvent

# XVM.Main
import xvm_main.python.config as config



#
# Constants
#

class XVM_SOUND_EVENT(object):
    ENEMY_SIGHTED = "xvm_enemySighted"



#
# Globals
# 

enemyList = {}



#
# Handlers
#

def _onAvatarBecomeNonPlayer(*args, **kwargs):
    global enemyList
    enemyList.clear()


def VehicleEntry_setActive(self, active):
    try:
        if self._isEnemy and self._isActive:
            if config.get('sounds/enabled'):
                global enemyList
                if not self._entryID in enemyList:
                    enemyList[self._entryID] = True
                    SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.ENEMY_SIGHTED)
    except Exception:
        logging.getLogger('XVM/Sounds').exception('enemySighted/VehicleEntry_setActive:')



#
# Initialization
#

def init():
    g_playerEvents.onAvatarBecomeNonPlayer += _onAvatarBecomeNonPlayer
    registerEvent(VehicleEntry, 'setActive')(VehicleEntry_setActive)


def fini():
    g_playerEvents.onAvatarBecomeNonPlayer -= _onAvatarBecomeNonPlayer
