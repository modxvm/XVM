""" XVM (c) www.modxvm.com 2013-2015 """

from gui.shared.utils import decorators

class _WGCompat():

    @decorators.process('installEquipment')
    def processReturnEquip(self, vehicle, newComponentItem, slotIdx, install):
        from gui.shared.gui_items.processors.module import OptDeviceInstaller
        yield OptDeviceInstaller(vehicle, newComponentItem, slotIdx, install).request()

g_instance = _WGCompat()
