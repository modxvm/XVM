"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2016-2022 XVM Contributors
"""

#
# Imports
#

# stdlib
import logging

# BigWorld
import SoundGroups
from gui.Scaleform.daapi.view.battle.shared.timers_panel import TimersPanel

# XFW
from xfw.events import registerEvent

# XVM.Main
import xvm_main.python.config as config



#
# Constants
# 

class XVM_SOUND_EVENT(object):
    FIRE_ALERT = "xvm_fireAlert"


#
# Handlers
#

def _TimersPanel__setFireInVehicle(self, isInFire):
    try:
        if isInFire and config.get('sounds/enabled'):
            SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.FIRE_ALERT)
    except:
        logging.getLogger('XVM/Main').exception('fireAlert/_TimersPanel__setFireInVehicle:')



#
# Initialization
#

def init():
    registerEvent(TimersPanel, '_TimersPanel__setFireInVehicle')(_TimersPanel__setFireInVehicle)


def fini():
    pass
