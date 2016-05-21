""" XVM (c) www.modxvm.com 2013-2016 """

#####################################################################
# imports

import SoundGroups
from gui.Scaleform.Battle import Battle

from xfw import *
import xvm_main.python.config as config
from xvm_main.python.logger import *
import traceback

#####################################################################
# constants

class XVM_SOUND_EVENT(object):
    FIRE_ALERT = "xvm_fireAlert"

#####################################################################
# handlers

@registerEvent(Battle, '_setFireInVehicle')
def Battle_setFireInVehicle(self, bool):
    try:
        if config.get('sounds/enabled'):
            SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.FIRE_ALERT)
    except:
        err(traceback.format_exc())