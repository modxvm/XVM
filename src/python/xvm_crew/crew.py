"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

# stdlib
import logging

# BigWorld
import BigWorld
from CurrentVehicle import g_currentVehicle
from gui.Scaleform.daapi.view.lobby.crewOperations.CrewOperationsPopOver import CrewOperationsPopOver
from gui.Scaleform.daapi.view.lobby.cyberSport.VehicleSelectorPopup import VehicleSelectorPopup
from helpers import dependency
from skeletons.gui.app_loader import IAppLoader, GuiGlobalSpaceID
from skeletons.gui.shared import IItemsCache

# XFW
from xfw import *
from xfw_actionscript.python import *

# XVM
import xvm_main.python.config as config
import xvm_main.python.userprefs as userprefs

# XVM Crew
import wg_compat
from consts import USERPREFS



#
# Globals
#

g_crew = None



#
# Crew class
#

class Crew(object):
    itemsCache = dependency.descriptor(IItemsCache)

    def __init__(self):
        self.intCD = None
        self.__callbackID = None
        self.__useXvmCrewReturnImpl = IS_LESTA

    def init(self):
        if config.get('hangar/enableCrewAutoReturn', True):
            vehicle = g_currentVehicle.item
            if vehicle is None:
                return
            intCD = vehicle.intCD
            self.intCD = intCD

    def invalidate(self):
        self.intCD = None
        if self.__callbackID is not None:
            BigWorld.cancelCallback(self.__callbackID)
            self.__callbackID = None

    def handleVehicleChange(self):
        if not (config.get('hangar/enableCrewAutoReturn', True) and config.get('hangar/crewReturnByDefault', False)):
            return
        vehicle = g_currentVehicle.item
        if vehicle is None:
            return
        intCD = vehicle.intCD
        if intCD != self.intCD:
            if self.__useXvmCrewReturnImpl:
                if self.__callbackID is not None:
                    BigWorld.cancelCallback(self.__callbackID)
                    self.__callbackID = None
                self.__callbackID = BigWorld.callback(0.0, self.__returnCrew)
            else:
                isEnabledByUserPrefs = userprefs.get(USERPREFS.AUTO_PREV_CREW + str(vehicle.invID), True)
                if isEnabledByUserPrefs and not wg_compat.g_instance.isAutoReturnEnabled(vehicle):
                    wg_compat.g_instance.enableCrewAutoReturn(vehicle)
            self.intCD = intCD

    def handlePopupVehicleSelect(self, items):
        if not config.get('hangar/enableCrewAutoReturn', True):
            return
        if len(items) == 1:
            intCD = int(items[0])
            vehicle = self.itemsCache.items.getItemByCD(intCD)
            isEnabledByUserPrefs = userprefs.get(USERPREFS.AUTO_PREV_CREW + str(vehicle.invID), True)
            if vehicle and vehicle.isInInventory and not (vehicle.isCrewFull or vehicle.isInBattle or vehicle.isLocked) and isEnabledByUserPrefs:
                wg_compat.g_instance.processCrewReturnForVehicleSelectorPopup(vehicle)

    def syncAutoReturnState(self):
        vehicle = g_currentVehicle.item
        if vehicle is not None:
            userprefs.set(USERPREFS.AUTO_PREV_CREW + str(vehicle.invID), not vehicle.isAutoReturn)

    def __returnCrew(self):
        self.__callbackID = None
        if not g_currentVehicle.isInHangar() or g_currentVehicle.isInBattle() or g_currentVehicle.isLocked() or g_currentVehicle.isCrewFull():
            return
        if not self.__isLastCrewAvailable():
            return
        wg_compat.g_instance.processCrewReturn()

    def __isLastCrewAvailable(self):
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



#
# Handlers/AppLoader
#

def onGUISpaceEntered(spaceID):
    if spaceID == GuiGlobalSpaceID.LOBBY:
        g_crew.init()
        g_currentVehicle.onChanged += g_currentVehicle_onChanged


def onGUISpaceLeft(spaceID):
    if spaceID == GuiGlobalSpaceID.LOBBY:
        g_crew.invalidate()



#
# Handlers/CurrentVehicle
#

def g_currentVehicle_onChanged():
    try:
        g_crew.handleVehicleChange()
    except:
        logging.getLogger('XVM/Crew').exception('g_currentVehicle_onChanged')



#
# Handlers/VehicleSelectorPopup
#

def VehicleSelectorPopup_onSelectVehicles(base, self, items):
    base(self, items)
    try:
        g_crew.handlePopupVehicleSelect(items)
    except:
        logging.getLogger('XVM/Crew').exception('VehicleSelectorPopup_onSelectVehicles')



#
# Handlers/CrewOperationsPopOver
#

def CrewOperationsPopOver_onToggleClick(base, self, operationName):
    try:
        g_crew.syncAutoReturnState()
    except:
        logging.getLogger('XVM/Crew').exception('CrewOperationsPopOver_onToggleClick')
    base(self, operationName)


def init():
    global g_crew
    g_crew = Crew()

    appLoader = dependency.instance(IAppLoader)
    appLoader.onGUISpaceEntered += onGUISpaceEntered
    appLoader.onGUISpaceLeft += onGUISpaceLeft

    overrideMethod(VehicleSelectorPopup, 'onSelectVehicles')(VehicleSelectorPopup_onSelectVehicles)
    if IS_WG:
        overrideMethod(CrewOperationsPopOver, 'onToggleClick')(CrewOperationsPopOver_onToggleClick)


def fini():
    global g_crew
    g_crew.invalidate()
    g_crew = None

    try:
        appLoader = dependency.instance(IAppLoader)
        appLoader.onGUISpaceEntered -= onGUISpaceEntered
        appLoader.onGUISpaceLeft -= onGUISpaceLeft
    except dependency.DependencyError:
        pass

    g_currentVehicle.onChanged -= g_currentVehicle_onChanged
