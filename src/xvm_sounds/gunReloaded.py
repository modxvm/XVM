"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
Copyright (c) 2018-2021 night_dragon_on <https://kr.cm/f/p/14897/>
"""

#
# Imports
#

# stdlib
import logging

# BigWorld
import SoundGroups
from Avatar import PlayerAvatar

# XFW
from xfw.events import registerEvent

# XVM.Main
import xvm_main.config as config



#
# Constants
#

class XVM_SOUND_EVENT(object):
    GUN_RELOADED = "xvm_gunReloaded"



#
# Handlers
#

def updateVehicleGunReloadTime(self, vehicleID, timeLeft, *args, **kwargs):
    try:
        if config.get('sounds/enabled'):
            prevTimeLeft = self._PlayerAvatar__prevGunReloadTimeLeft
            isInPostmortem = self.sessionProvider.shared.vehicleState.isInPostmortem
            if prevTimeLeft != timeLeft and timeLeft == 0.0 and not isInPostmortem:
                SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.GUN_RELOADED)
    except Exception:
        logging.getLogger('XVM/Sounds').exception('gunReloaded/updateVehicleGunReloadTime')



#
# Initialization
#

def init():
    registerEvent(PlayerAvatar, 'updateVehicleGunReloadTime', prepend=True)(updateVehicleGunReloadTime)


def fini():
    pass
