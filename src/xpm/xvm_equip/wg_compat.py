""" XVM (c) https://modxvm.com 2013-2020 """

from gui.shared.utils.decorators import process
from gui.shared.gui_items.processors.module import OptDeviceInstaller

class _WGCompat():

    @process('installEquipment')
    def processReturnEquip(self, vehicle, newComponentItem, slotIdx, install):
        yield OptDeviceInstaller(vehicle, newComponentItem, slotIdx, install).request()


g_instance = _WGCompat()
