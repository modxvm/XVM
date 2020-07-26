""" XVM (c) https://modxvm.com 2013-2020 """

#####################################################################
# imports

import SoundGroups
from gui.Scaleform.daapi.view.battle.shared.timers_panel import TimersPanel
import traceback

from xfw import *
import xvm_main.python.config as config
from xvm_main.python.logger import *

#####################################################################
# constants

class XVM_SOUND_EVENT(object):
    FIRE_ALERT = "xvm_fireAlert"

#####################################################################
# handlers

@registerEvent(TimersPanel, '_TimersPanel__setFireInVehicle')
def _TimersPanel__setFireInVehicle(self, isInFire):
    try:
        if isInFire and config.get('sounds/enabled'):
            SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.FIRE_ALERT)
    except:
        err(traceback.format_exc())
