"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2023 XVM Contributors
"""

#
# Imports
#

# BigWorld
from CurrentVehicle import g_currentVehicle
from gui import SystemMessages
from gui.shared.gui_items.processors.tankman import TankmanReturn
from gui.shared.utils import decorators



#
# Classes
#

class _WGCompat():

    @decorators.adisp_process('crewReturning')
    def processReturnCrew(self, print_message=True):
        result = yield TankmanReturn(g_currentVehicle.item).request()
        if len(result.userMsg) and print_message:
            SystemMessages.pushI18nMessage(result.userMsg, type=result.sysMsgType)


    @decorators.adisp_process('crewReturning')
    def processReturnCrewForVehicleSelectorPopup(self, vehicle):
        if not (vehicle.isCrewFull or vehicle.isInBattle or vehicle.isLocked):
            yield TankmanReturn(vehicle).request()

    @decorators.adisp_process('unloading')
    def processUnloadCrew():
        result = yield TankmanUnload(g_currentVehicle.item.invID).request()
        if result.userMsg:
            SystemMessages.pushI18nMessage(result.userMsg, type=result.sysMsgType)


#
# Globals
#

g_instance = _WGCompat()
