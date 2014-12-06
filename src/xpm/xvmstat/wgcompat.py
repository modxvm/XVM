""" XVM (c) www.modxvm.com 2013-2014 """

from gui.shared.utils import decorators

class _WGCompat():

    # removed in 0.9.5
    @decorators.process('unloading')
    def unloadTankman(self, tmanInvID):
        from gui.shared import g_itemsCache
        from gui.shared.gui_items.processors.tankman import TankmanUnload
        from CurrentVehicle import g_currentVehicle
        from gui import SystemMessages
        tankman = g_itemsCache.items.getTankman(int(tmanInvID))
        result = yield TankmanUnload(g_currentVehicle.item, tankman.vehicleSlotIdx).request()
        if len(result.userMsg):
            SystemMessages.g_instance.pushI18nMessage(result.userMsg, type = result.sysMsgType)

g_instance = _WGCompat()