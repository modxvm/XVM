""" XVM (c) www.modxvm.com 2013-2014 """

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

    # removed in 0.9.5
    @decorators.process('unloading')
    def unloadTankman(self, tmanInvID):
        from gui.shared import g_itemsCache
        from gui.shared.gui_items.processors.tankman import TankmanUnload
        from CurrentVehicle import g_currentVehicle
        tankman = g_itemsCache.items.getTankman(int(tmanInvID))
        result = yield TankmanUnload(g_currentVehicle.item, tankman.vehicleSlotIdx).request()
        if len(result.userMsg):
            SystemMessages.g_instance.pushI18nMessage(result.userMsg, type = result.sysMsgType)

g_instance = _WGCompat()