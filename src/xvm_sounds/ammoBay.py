"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# imports
#

# stdlib
import logging

# BigWorld
import SoundGroups
from gui.Scaleform.daapi.view.battle.shared.damage_panel import DamagePanel
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider

# XFW
from xfw.events import registerEvent

# XVM.Main
import xvm_main.config as config



#
# Constants
#

class XVM_SOUND_EVENT(object):
    AMMO_BAY = "xvm_ammoBay"



#
# Handlers
#

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
    except Exception:
        logging.getLogger('XVM/Sounds').exception('ammobay/DamagePanel_updateDeviceState')



#
# Initialization
#

def init():
    registerEvent(DamagePanel, '_updateDeviceState')(DamagePanel_updateDeviceState)


def fini():
    pass
