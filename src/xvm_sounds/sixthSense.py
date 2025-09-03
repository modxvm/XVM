"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

# python
import logging

# BigWorld
import SoundGroups
from gui.battle_control import avatar_getter
from gui.Scaleform.daapi.view.battle.shared.indicators import SixthSenseIndicator

# XFW
from xfw.events import registerEvent
from xfw.wg import getVehCD

# XVM.Main
import xvm_main.config as config



#
# Constants
#

class XVM_SOUND_EVENT(object):
    SIXTH_SENSE = "xvm_sixthSense"
    SIXTH_SENSE_RUDY = "xvm_sixthSenseRudy"



#
# handlers
#

def SixthSenseIndicator_as_showS(self, *args, **kwargs):
    try:
        if config.get('sounds/enabled'):
            vehCD = getVehCD(avatar_getter.getPlayerVehicleID())
            # 59393 => Rudy
            soundId = XVM_SOUND_EVENT.SIXTH_SENSE_RUDY if vehCD == 59393 else XVM_SOUND_EVENT.SIXTH_SENSE
            SoundGroups.g_instance.playSound2D(soundId)
    except Exception:
        logging.getLogger('XVM/Sounds').exception('sixthSense/SixthSenseIndicator_as_showS:')



#
# Initialization
#

def init():
    registerEvent(SixthSenseIndicator, 'as_showS')(SixthSenseIndicator_as_showS)


def fini():
    pass
