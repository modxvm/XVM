""" XVM (c) www.modxvm.com 2013-2017 """

#####################################################################
# imports

import traceback

import SoundGroups
from gui.Scaleform.daapi.view.battle.shared.destroy_timers_panel import DestroyTimersPanel

from xfw import *
import xvm_main.python.config as config
from xvm_main.python.logger import *


#####################################################################
# constants

class XVM_SOUND_EVENT(object):
    FIRE_ALERT = "xvm_fireAlert"


#####################################################################
# handlers

@registerEvent(DestroyTimersPanel, '_DestroyTimersPanel__setFireInVehicle')
def _DestroyTimersPanel__setFireInVehicle(self, isInFire):
    if isInFire:
        if config.get('sounds/enabled'):
            SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.FIRE_ALERT)
