"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2023 XVM Contributors
"""


#
# Imports
#

# stdlib
import logging

# BigWorld
from gui.shared import g_eventBus
from CurrentVehicle import g_currentVehicle
from gui.Scaleform.daapi.view.lobby.cyberSport.VehicleSelectorPopup import VehicleSelectorPopup
from helpers import dependency
from skeletons.gui.shared import IItemsCache

# XFW
from xfw import *
from xfw_actionscript.python import *

# XVM
import xvm_main.python.config as config
from xvm_main.python.logger import *
from xvm_main.python.xvm import l10n
import xvm_main.python.userprefs as userprefs

# XVM Crew
import wg_compat



#
# Constants
#

class CREW(object):
    DROP_ALL_CREW = 'DropAllCrew'
    PUT_OWN_CREW = 'PutOwnCrew'
    PUT_BEST_CREW = 'PutBestCrew'
    PUT_CLASS_CREW = 'PutClassCrew'
    PUT_PREVIOUS_CREW = 'PutPreviousCrew'

class COMMANDS(object):
    PUT_PREVIOUS_CREW = 'xvm_crew.put_previous_crew'
    AS_VEHICLE_CHANGED = 'xvm_crew.as_vehicle_changed'
    AS_PUT_OWN_CREW = 'xvm_crew.as_put_own_crew'
    AS_PUT_BEST_CREW = 'xvm_crew.as_put_best_crew'
    AS_PUT_CLASS_CREW = 'xvm_crew.as_put_class_crew'

class USERPREFS(object):
    AUTO_PREV_CREW = "users/{accountDBID}/crew/auto_prev_crew/"


#
# Handlers/XFW
#

# returns: (result, status)
def onXfwCommand(cmd, *args):
    try:
        if cmd == COMMANDS.PUT_PREVIOUS_CREW:
            if g_currentVehicle.isInHangar() and not (g_currentVehicle.isCrewFull() or g_currentVehicle.isInBattle() or g_currentVehicle.isLocked()):
                PutPreviousCrew(g_currentVehicle, False)
            return (None, True)
    except Exception:
        logging.exception('xvm_crew/onXfwCommand')
        return (None, True)
    return (None, False)



#
# Handlers/g_currentVehicle
#

def g_currentVehicle_onChanged():
    if config.get('hangar/enableCrewAutoReturn'):
        vehicle = g_currentVehicle.item
        invID = g_currentVehicle.invID if vehicle is not None else 0
        isElite = vehicle.isElite if vehicle is not None else 0
        as_xfw_cmd(COMMANDS.AS_VEHICLE_CHANGED, invID, isElite)


#
# Handlers/VehicleSelectorPopup
#

def VehicleSelectorPopup_onSelectVehicles(base, self, items):
    base(self, items)
    try:
        if len(items) == 1:
            cd = int(items[0])
            itemsCache = dependency.instance(IItemsCache)
            vehicle = itemsCache.items.getItemByCD(cd)
            if vehicle and vehicle.isInInventory and not (vehicle.isCrewFull or vehicle.isInBattle or vehicle.isLocked):
                if config.get('hangar/enableCrewAutoReturn'):
                    if userprefs.get(USERPREFS.AUTO_PREV_CREW + str(vehicle.invID), True):
                        wg_compat.g_instance.processReturnCrewForVehicleSelectorPopup(vehicle)
    except Exception:
        logging.exception('xvm_crew/VehicleSelectorPopup_onSelectVehicles')



#
# XFW API
#

__initialized = False

def xfw_module_init():
    global __initialized
    if not __initialized:
        g_eventBus.addListener(XFW_COMMAND.XFW_CMD, onXfwCommand)
        g_currentVehicle.onChanged += g_currentVehicle_onChanged
        overrideMethod(VehicleSelectorPopup, 'onSelectVehicles')(VehicleSelectorPopup_onSelectVehicles)
        __initialized = True
    

def xfw_module_fini():
    global __initialized
    if __initialized:
        g_currentVehicle.onChanged -= g_currentVehicle_onChanged
        g_eventBus.removeListener(XFW_COMMAND.XFW_CMD, onXfwCommand)
        __initialized = False


def xfw_is_module_loaded():
    global __initialized
    return __initialized
