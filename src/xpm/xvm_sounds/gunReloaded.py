"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2018-2022 XVM Contributors
Copyright (c) 2018-2021 night_dragon_on <https://kr.cm/f/p/14897/>
"""

#
# Imports
#

# stdlib
import logging

# BigWorld
import SoundGroups
from gui.Scaleform.daapi.view.battle.shared.crosshair.plugins import AmmoPlugin

# XFW
from xfw.events import registerEvent

# XVM.Main
import xvm_main.python.config as config



#
# Constants
#

class XVM_SOUND_EVENT(object):
    GUN_RELOADED = "xvm_gunReloaded"



#
# Handlers
#

def _AmmoPlugin__onGunReloadTimeSet(self, _, state, skipAutoLoader):
    try:
        if config.get('sounds/enabled'):
            isAutoReload = self._AmmoPlugin__guiSettings.hasAutoReload
            isInPostmortem = self.sessionProvider.shared.vehicleState.isInPostmortem
            timeLast = state.getActualValue()
            timeLeft = state.getTimeLeft()
            if timeLeft == 0.0 and not isAutoReload and not isInPostmortem and (timeLast != -1):
                SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.GUN_RELOADED)
    except Exception:
        logging.getLogger('XVM/Sounds').exception('gunReloaded/_AmmoPlugin__onGunReloadTimeSet:')


def _AmmoPlugin__onGunAutoReloadTimeSet(self, state, stunned):
    try:
        if config.get('sounds/enabled'):
            isAutoReload = self._AmmoPlugin__guiSettings.hasAutoReload
            isInPostmortem = self.sessionProvider.shared.vehicleState.isInPostmortem
            timeLast = state.getActualValue()
            timeLeft = state.getTimeLeft()
            if timeLeft == 0.0 and isAutoReload and not isInPostmortem and (timeLast != -1):
                SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.GUN_RELOADED)
    except:
        logging.getLogger('XVM/Sounds').exception('gunReloaded/_AmmoPlugin__onGunAutoReloadTimeSet:')


#
# Initialization
#

def init():
    registerEvent(AmmoPlugin, '_AmmoPlugin__onGunReloadTimeSet')(_AmmoPlugin__onGunReloadTimeSet)
    registerEvent(AmmoPlugin, '_AmmoPlugin__onGunAutoReloadTimeSet')(_AmmoPlugin__onGunAutoReloadTimeSet)


def fini():
    pass
