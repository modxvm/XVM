""" XVM (c) https://modxvm.com 2013-2021 """

#####################################################################
# imports

import SoundGroups
from gui.battle_control import avatar_getter
from gui.Scaleform.daapi.view.battle.shared.indicators import SixthSenseIndicator
import traceback

from xfw import *
import xvm_main.python.config as config
from xvm_main.python.logger import *

#####################################################################
# constants

class XVM_SOUND_EVENT(object):
    SIXTH_SENSE = "xvm_sixthSense"
    SIXTH_SENSE_RUDY = "xvm_sixthSenseRudy"

#####################################################################
# handlers

@registerEvent(SixthSenseIndicator, 'as_showS')
def SixthSenseIndicator_as_showS(self):
    try:
        if config.get('sounds/enabled'):
            vehCD = getVehCD(avatar_getter.getPlayerVehicleID())
            # 59393 => Rudy
            soundId = XVM_SOUND_EVENT.SIXTH_SENSE_RUDY if vehCD == 59393 else XVM_SOUND_EVENT.SIXTH_SENSE
            SoundGroups.g_instance.playSound2D(soundId)
    except:
        err(traceback.format_exc())
