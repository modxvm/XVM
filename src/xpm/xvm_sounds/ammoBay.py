""" XVM (c) www.modxvm.com 2013-2017 """

#####################################################################
# imports

import SoundGroups
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider
from gui.Scaleform.daapi.view.battle.shared.damage_panel import DamagePanel

from xfw import *
import xvm_main.python.config as config
from xvm_main.python.logger import *
import traceback

#####################################################################
# constants

class XVM_SOUND_EVENT(object):
    AMMO_BAY = "xvm_ammoBay"

#####################################################################
# handlers

@registerEvent(DamagePanel, '_updateDeviceState')
def DamagePanel_updateDeviceState(self, value):
    try:
        if config.get('sounds/enabled'):
            sessionProvider = dependency.instance(IBattleSessionProvider)
            ctrl = sessionProvider.shared.vehicleState
            if ctrl is not None:
                vehicle = ctrl.getControllingVehicle()
                if vehicle is not None:
                    if not vehicle.isPlayerVehicle or not vehicle.isAlive():
                        return
                    module, state, _ = value
                    if module == 'ammoBay' and state == 'critical':
                        SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.AMMO_BAY)
    except:
        err(traceback.format_exc())
