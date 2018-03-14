""" XVM (c) https://modxvm.com 2013-2018 """

# Authors:
# night_dragon_on <http://www.koreanrandom.com/forum/user/14897-night-dragon-on/>

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

@registerEvent(PlayerAvatar, 'updateVehicleGunReloadTime')
def updateVehicleGunReloadTime(self, vehicleID, timeLeft, baseTime):
    try:
        self.__prevGunReloadTimeLeft = -1.0
        if self.__prevGunReloadTimeLeft != timeLeft and timeLeft == 0.0:
            SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.GUN_RELOADED)
    except:
        err(traceback.format_exc())
