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
import BigWorld
from PlayerEvents import g_playerEvents
# from gui.shared import g_eventBus
from CurrentVehicle import _CurrentVehicle, g_currentVehicle
from gui.Scaleform.daapi.view.lobby.cyberSport.VehicleSelectorPopup import VehicleSelectorPopup
from helpers import dependency
from skeletons.gui.app_loader import IAppLoader, GuiGlobalSpaceID
from skeletons.gui.shared import IItemsCache

# XFW
from xfw import *
from xfw_actionscript.python import *

# XVM
import xvm_main.python.config as config
# from xvm_main.python.xvm import l10n
import xvm_main.python.userprefs as userprefs

# XVM Crew
import wg_compat


#
# Logger
#

logger = logging.getLogger(__name__)

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
# Handlers
#

class Crew(object):
    itemsCache = dependency.descriptor(IItemsCache)

    def __init__(self):
        self.intCD = None
        self.__callbackID = None

    def init(self):
        vehicle = g_currentVehicle.item
        intCD = vehicle.intCD
        self.intCD = intCD

    def invalidate(self):
        self.intCD = None
        if self.__callbackID is not None:
            BigWorld.cancelCallback(self.__callbackID)
            self.__callbackID = None

    def handleVehicleChange(self):
        if config.get('hangar/enableCrewAutoReturn') and config.get('hangar/crewReturnByDefault'):
            if self.__callbackID is not None:
                BigWorld.cancelCallback(self.__callbackID)
                self.__callbackID = None
            vehicle = g_currentVehicle.item
            intCD = vehicle.intCD
            if intCD != self.intCD:
                self.__callbackID = BigWorld.callback(1.5, self.returnCrew)
                self.intCD = intCD

    def handlePopupSelect(self, items):
        if len(items) == 1:
            cd = int(items[0])
            vehicle = self.itemsCache.items.getItemByCD(cd)
            if vehicle and vehicle.isInInventory and not (vehicle.isCrewFull or vehicle.isInBattle or vehicle.isLocked):
                if config.get('hangar/enableCrewAutoReturn'):
                    if userprefs.get(USERPREFS.AUTO_PREV_CREW + str(vehicle.invID), True):
                        wg_compat.g_instance.processReturnCrewForVehicleSelectorPopup(vehicle)

    def isCrewAvailable(self):
        vehicle = g_currentVehicle.item
        lastCrewIDs = vehicle.lastCrew
        if lastCrewIDs is None:
            return False
        for lastTankmenInvID in lastCrewIDs:
            actualLastTankman = self.itemsCache.items.getTankman(lastTankmenInvID)
            if actualLastTankman is not None and actualLastTankman.isInTank:
                lastTankmanVehicle = self.itemsCache.items.getVehicle(actualLastTankman.vehicleInvID)
                if lastTankmanVehicle and lastTankmanVehicle.isLocked:
                    return False
        return True

    def returnCrew(self):
        self.__callbackID = None
        if not g_currentVehicle.isInHangar() or g_currentVehicle.isInBattle() or g_currentVehicle.isLocked() or g_currentVehicle.isCrewFull():
            return
        if not self.isCrewAvailable():
            return
        wg_compat.g_instance.processReturnCrew()

g_crew = Crew()

#
# Handlers/XFW
#

# returns: (result, status)
# def onXfwCommand(cmd, *args):
#     try:
#         if cmd == COMMANDS.PUT_PREVIOUS_CREW:
#             if g_currentVehicle.isInHangar() and not (g_currentVehicle.isCrewFull() or g_currentVehicle.isInBattle() or g_currentVehicle.isLocked()):
#                 PutPreviousCrew(g_currentVehicle, False)
#             return (None, True)
#     except Exception:
#         logger.exception('onXfwCommand')
#         return (None, True)
#     return (None, False)

#
# Handlers/AppLoader
#

def onGUISpaceEntered(spaceID):
    logger.info('onGUISpaceEntered, spaceID = %s', spaceID)
    if spaceID == GuiGlobalSpaceID.LOBBY:
        g_crew.init()
        g_currentVehicle.onChanged += g_currentVehicle_onChanged
    elif spaceID in (GuiGlobalSpaceID.LOGIN, GuiGlobalSpaceID.BATTLE, ):
        g_crew.invalidate()

#
# Handlers/g_currentVehicle
#

def g_currentVehicle_onChanged():
    try:
        g_crew.handleVehicleChange()
    except:
        logger.exception('g_currentVehicle_onChanged')

#
# Handlers/VehicleSelectorPopup
#

def VehicleSelectorPopup_onSelectVehicles(base, self, items):
    base(self, items)
    try:
        g_crew.handlePopupSelect(items)
    except:
        logger.exception('VehicleSelectorPopup_onSelectVehicles')

#
# XFW API
#

__initialized = False

def xfw_module_init():
    global __initialized
    if not __initialized:
        # g_eventBus.addListener(XFW_COMMAND.XFW_CMD, onXfwCommand)
        dependency.instance(IAppLoader).onGUISpaceEntered += onGUISpaceEntered
        overrideMethod(VehicleSelectorPopup, 'onSelectVehicles')(VehicleSelectorPopup_onSelectVehicles)
        __initialized = True


def xfw_module_fini():
    global __initialized
    if __initialized:
        try:
            dependency.instance(IAppLoader).onGUISpaceEntered += onGUISpaceEntered
        except dependency.DependencyError:
            pass
        g_currentVehicle.onChanged -= g_currentVehicle_onChanged
        # g_eventBus.removeListener(XFW_COMMAND.XFW_CMD, onXfwCommand)
        __initialized = False


def xfw_is_module_loaded():
    global __initialized
    return __initialized
