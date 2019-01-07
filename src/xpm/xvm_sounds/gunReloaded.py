""" XVM (c) https://modxvm.com 2013-2019 """

# Authors:
# night_dragon_on <https://kr.cm/f/p/14897/>

#####################################################################
# imports

import traceback

from Avatar import PlayerAvatar
import SoundGroups

from xfw import *
import xvm_main.python.config as config
from xvm_main.python.logger import *

#####################################################################
# constants

class XVM_SOUND_EVENT(object):
    GUN_RELOADED = "xvm_gunReloaded"

#####################################################################
# handlers

@overrideMethod(PlayerAvatar, 'updateVehicleGunReloadTime')
def updateVehicleGunReloadTime(base, self, vehicleID, timeLeft, baseTime):
    if (self._PlayerAvatar__prevGunReloadTimeLeft != timeLeft and timeLeft == 0.0) and not self.guiSessionProvider.shared.vehicleState.isInPostmortem:
        try:
            SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.GUN_RELOADED)
        except:
            err(traceback.format_exc())
    base(self, vehicleID, timeLeft, baseTime)
