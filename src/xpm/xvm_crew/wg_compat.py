""" XVM (c) www.modxvm.com 2013-2015 """

from gui.shared.utils import decorators
from gui import SystemMessages

class _WGCompat():

    # removed in 0.9.4
    # taken from gui.Scaleform.daapi.view.lobby.crewOperations.CrewOperationsPopOver
    @decorators.process('crewReturning')
    def processReturnCrew(self):
        from gui.shared.gui_items.processors.tankman import TankmanReturn
        from CurrentVehicle import g_currentVehicle
        result = yield TankmanReturn(g_currentVehicle.item).request()
        if len(result.userMsg):
            SystemMessages.g_instance.pushI18nMessage(result.userMsg, type = result.sysMsgType)

g_instance = _WGCompat()
