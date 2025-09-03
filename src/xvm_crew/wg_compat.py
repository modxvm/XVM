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
from AccountCommands import VEHICLE_SETTINGS_FLAG
from CurrentVehicle import g_currentVehicle
from gui import SystemMessages
from gui.shared.gui_items.processors.tankman import TankmanReturn
from gui.shared.utils import decorators

# XFW
from xfw import *



#
# Classes
#

class _WGCompat():

    @decorators.adisp_process('crewReturning')
    def processCrewReturn(self, print_message=True):
        result = yield TankmanReturn(g_currentVehicle.item).request()
        if len(result.userMsg) and print_message:
            SystemMessages.pushI18nMessage(result.userMsg, type=result.sysMsgType)


    @decorators.adisp_process('crewReturning')
    def processCrewReturnForVehicleSelectorPopup(self, vehicle):
        if not (vehicle.isCrewFull or vehicle.isInBattle or vehicle.isLocked):
            yield TankmanReturn(vehicle).request()

    @decorators.adisp_process('unloading')
    def processCrewUnload(self):
        result = yield TankmanUnload(g_currentVehicle.item.invID).request()
        if result.userMsg:
            SystemMessages.pushI18nMessage(result.userMsg, type=result.sysMsgType)

    def isAutoReturnEnabled(self, vehicle):
        if IS_LESTA:
            logging.getLogger('XVM/Crew').error('isAutoReturnEnabled call is only supported on WG client')
            return
        if vehicle is None:
            return False
        return bool(vehicle.settings & VEHICLE_SETTINGS_FLAG.AUTO_RETURN)

    @decorators.adisp_process('updating')
    def enableCrewAutoReturn(self, vehicle):
        if IS_LESTA:
            logging.getLogger('XVM/Crew').error('enableCrewAutoReturn call is only supported on WG client with native implementation')
            return
        from gui.shared.gui_items.processors.vehicle import VehicleAutoReturnProcessor
        yield VehicleAutoReturnProcessor(vehicle, True).request()


#
# Globals
#

g_instance = _WGCompat()
