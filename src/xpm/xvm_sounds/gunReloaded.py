""" XVM (c) https://modxvm.com 2013-2021 """

# Authors:
# night_dragon_on <https://kr.cm/f/p/14897/>

#####################################################################
# imports

import SoundGroups
from gui.Scaleform.daapi.view.battle.shared.crosshair.plugins import AmmoPlugin
import traceback

from xfw import *
import xvm_main.python.config as config
from xvm_main.python.logger import *

#####################################################################
# constants

class XVM_SOUND_EVENT(object):
    GUN_RELOADED = "xvm_gunReloaded"

#####################################################################
# handlers

@registerEvent(AmmoPlugin, '_AmmoPlugin__onGunReloadTimeSet')
def onGunReloadTimeSet(self, _, state, skipAutoLoader):
    try:
        if config.get('sounds/enabled'):
            isAutoReload = self._AmmoPlugin__guiSettings.hasAutoReload
            isInPostmortem = self.sessionProvider.shared.vehicleState.isInPostmortem
            timeLast = state.getActualValue()
            timeLeft = state.getTimeLeft()
            if timeLeft == 0.0 and not isAutoReload and not isInPostmortem and (timeLast != -1):
                SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.GUN_RELOADED)
    except:
        err(traceback.format_exc())

@registerEvent(AmmoPlugin, '_AmmoPlugin__onGunAutoReloadTimeSet')
def onGunAutoReloadTimeSet(self, state, stunned):
    try:
        if config.get('sounds/enabled'):
            isAutoReload = self._AmmoPlugin__guiSettings.hasAutoReload
            isInPostmortem = self.sessionProvider.shared.vehicleState.isInPostmortem
            timeLast = state.getActualValue()
            timeLeft = state.getTimeLeft()
            if timeLeft == 0.0 and isAutoReload and not isInPostmortem and (timeLast != -1):
                SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.GUN_RELOADED)
    except:
        err(traceback.format_exc())
