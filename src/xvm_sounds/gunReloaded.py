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
from PlayerEvents import g_playerEvents

# XFW
from xfw.events import registerEvent

# XVM.Main
import xvm_main.config as config



#
# Globals
#

_prevGunReloadTimeLeft = -1.0



#
# Constants
#

class XVM_SOUND_EVENT(object):
    GUN_RELOADED = "xvm_gunReloaded"



#
# Handlers
#

def _onAvatarBecomeNonPlayer(*args, **kwargs):
    global _prevGunReloadTimeLeft
    _prevGunReloadTimeLeft = -1.0


def updateVehicleGunReloadTime(self, vehicleID, timeLeft, *args, **kwargs):
    try:
        if config.get('sounds/enabled'):
            global _prevGunReloadTimeLeft
            isInPostmortem = self.sessionProvider.shared.vehicleState.isInPostmortem
            if timeLeft != _prevGunReloadTimeLeft and timeLeft == 0.0 and not isInPostmortem:
                SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.GUN_RELOADED)
            _prevGunReloadTimeLeft = timeLeft
    except Exception:
        logging.getLogger('XVM/Sounds').exception('[gunReloaded.py] updateVehicleGunReloadTime')



#
# Initialization
#

def init():
    g_playerEvents.onAvatarBecomeNonPlayer += _onAvatarBecomeNonPlayer
    registerEvent(PlayerAvatar, 'updateVehicleGunReloadTime', prepend=True)(updateVehicleGunReloadTime)


def fini():
    pass
