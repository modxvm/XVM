""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO (mandatory)

XFW_MOD_VERSION    = '3.0.0'
XFW_MOD_URL        = 'http://www.modxvm.com/'
XFW_MOD_UPDATE_URL = 'http://www.modxvm.com/en/download-xvm/'
XFW_GAME_VERSIONS  = ['0.9.8']

#####################################################################

import BigWorld
import traceback
from xfw import RegisterEvent, GAME_REGION
import xvm_main.python.userprefs as userprefs
import xvm_main.python.config as config
from xvm_main.python.logger import err, debug

#####################################################################
# globals

last_vehicle_id = None
equip_settings = None
player_name = None

#####################################################################
# event handlers

# init, get player name + region as unique name
def PlayerAccount_onBecomePlayer(*args, **kwargs):
    try:
        global player_name, last_vehicle_id, equip_settings
        player_name = None
        last_vehicle_id = None
        equip_settings = {}
        if not config.get('hangar/enableEquipAutoReturn'):
            return
        player_name = '%s_%s' % (BigWorld.player().name, GAME_REGION)
        debug('xvm_equip: init, name %s' % player_name)
    except Exception, ex:
        err(traceback.format_exc())

# device is changed on vehicle, remember the setting
def AmmunitionPanel_setVehicleModule(self, newId, slotIdx, oldId, isRemove):
    try:
        if not player_name:
            return
        global equip_settings
        from CurrentVehicle import g_currentVehicle
        from gui.shared import g_itemsCache
        vehicle = g_currentVehicle.item
        settings_changed = False
        if oldId:
            oldId = int(oldId)
            if vehicle.name in equip_settings and oldId in equip_settings[vehicle.name]:
                equip_settings[vehicle.name].remove(oldId)
                settings_changed = True
        if newId:
            newId = int(newId)
            new_device = g_itemsCache.items.getItemByCD(newId)
            if new_device and new_device.isRemovable:
                if vehicle.name not in equip_settings:
                    equip_settings[vehicle.name] = [newId]
                    settings_changed = True
                elif newId not in equip_settings[vehicle.name]:
                    equip_settings[vehicle.name].append(newId)
                    settings_changed = True
        if settings_changed:
            debug_str = 'xvm_equip: devices changed, new set:'
            for device_id in equip_settings[vehicle.name]:
                device = g_itemsCache.items.getItemByCD(device_id)
                debug_str += ' %s' % device.name
            debug(debug_str)
            save_settings()
    except Exception, ex:
        err(traceback.format_exc())

# vehicle switched, remove removable devices from previous and put on new one
def ClientHangarSpace_recreateVehicle(*args, **kwargs):
    try:
        if not player_name:
            return
        global last_vehicle_id, equip_settings
        if not equip_settings:
            get_settings()
        from CurrentVehicle import g_currentVehicle
        from gui.shared import g_itemsCache
        if last_vehicle_id == g_currentVehicle.item.intCD:
            return
        if last_vehicle_id: # remove removable devices from prev vehicle if they are not in warehouse
            vehicle = g_itemsCache.items.getItemByCD(last_vehicle_id)
            if vehicle and not (vehicle.isInBattle or vehicle.isLocked):
                debug_str = 'xvm_equip: remove from %s devices:' % vehicle.name 
                for slotIdx, installed_device in enumerate(vehicle.optDevices):
                    # TODO: remove the devices by FIFO order of switching tanks in carousel
                    if installed_device and installed_device.isRemovable and not installed_device.inventoryCount:
                        debug_str += ' %s' % installed_device.name
                        BigWorld.player().inventory.equipOptionalDevice(vehicle.invID, 0, slotIdx, False, None)
                debug(debug_str)

        vehicle = g_currentVehicle.item
        last_vehicle_id = vehicle.intCD
        if vehicle.name in equip_settings: # equip all modules from user prefs
            debug_str = 'xvm_equip: equip to %s devices:' % vehicle.name
            devices_arr = []
            for device_id in equip_settings[vehicle.name]:
                new_device = g_itemsCache.items.getItemByCD(device_id)
                if new_device and new_device.isRemovable:
                    if new_device.inventoryCount or get_device(new_device):
                        devices_arr.append(new_device)
            for slotIdx, installed_device in enumerate(vehicle.optDevices):
                if len(devices_arr) and (not installed_device or installed_device.isRemovable):
                    new_device = devices_arr.pop(0)
                    debug_str += ' %s' % new_device.name
                    BigWorld.player().inventory.equipOptionalDevice(vehicle.invID, new_device.intCD, slotIdx, False, None)
            debug(debug_str)

        else: # no prefs, save currently installed modules to user prefs
            debug_str = 'xvm_equip: no prefs for %s, save installed modules:' % vehicle.name
            for slotIdx, installed_device in enumerate(vehicle.optDevices):
                if installed_device and installed_device.isRemovable:
                    debug_str += ' %s' % installed_device.name
                    installed_device_id = int(installed_device.intCD)
                    if vehicle.name not in equip_settings:
                        equip_settings[vehicle.name] = [installed_device_id]
                    elif installed_device_id not in equip_settings[vehicle.name]:
                        equip_settings[vehicle.name].append(installed_device_id)
            debug(debug_str)
            save_settings()
    except Exception, ex:
        err(traceback.format_exc())

#####################################################################
# utility functions

# we need some removable devices, get it from any vehicle
def get_device(needed_device):
    try:
        if not needed_device.isRemovable:
            return False
        from gui.shared import g_itemsCache, REQ_CRITERIA
        inventory_vehicles = g_itemsCache.items.getVehicles(REQ_CRITERIA.INVENTORY).values()
        vehicles_with_device = needed_device.getInstalledVehicles(inventory_vehicles)
        for vehicle in vehicles_with_device:
            if vehicle and not (vehicle.isInBattle or vehicle.isLocked):
                for slotIdx, installed_device in enumerate(vehicle.optDevices):
                    if installed_device and installed_device.intCD == needed_device.intCD:
                        debug('xvm_equip: get %s from %s' % (needed_device.name, vehicle.name))
                        BigWorld.player().inventory.equipOptionalDevice(vehicle.invID, 0, slotIdx, False, None)
                        return True
    except Exception, ex:
        err(traceback.format_exc())
    debug('xvm_equip: could not get needed device %s' % needed_device.name)
    return False

# save user prefs
def save_settings():
    if player_name:
        userprefs.set('auto_equip/%s' % player_name, equip_settings)

# load user prefs or create new from current vehicles in hangar
def get_settings():
    global equip_settings
    try:
        from gui.shared import g_itemsCache, REQ_CRITERIA
        equip_settings = userprefs.get('auto_equip/%s' % player_name)
        if equip_settings is None: # first run, get currently installed devices
            debug('xvm_equip: no prefs for %s, get currently installed devices' % player_name)
            equip_settings = {'dummy': []} # to know that it's loaded
            inventory_vehicles = g_itemsCache.items.getVehicles(REQ_CRITERIA.INVENTORY).values()
            for vehicle in inventory_vehicles:
                if vehicle:
                    for slotIdx, installed_device in enumerate(vehicle.optDevices):
                        if installed_device and installed_device.isRemovable:
                            installed_device_id = int(installed_device.intCD)
                            if vehicle.name not in equip_settings:
                                equip_settings[vehicle.name] = [installed_device_id]
                            elif installed_device_id not in equip_settings[vehicle.name]:
                                equip_settings[vehicle.name].append(installed_device_id)
            save_settings()
        debug('xvm_equip: got settings: %s' % equip_settings)
    except Exception, ex:
        err(traceback.format_exc())
        equip_settings = {}

#####################################################################
# Register events

def _RegisterEvents():
    from Account import PlayerAccount
    RegisterEvent(PlayerAccount, 'onBecomePlayer', PlayerAccount_onBecomePlayer)
    from gui.Scaleform.daapi.view.lobby.hangar.AmmunitionPanel import AmmunitionPanel
    RegisterEvent(AmmunitionPanel, 'setVehicleModule', AmmunitionPanel_setVehicleModule)
    from gui.ClientHangarSpace import ClientHangarSpace
    RegisterEvent(ClientHangarSpace, 'recreateVehicle', ClientHangarSpace_recreateVehicle)

BigWorld.callback(0, _RegisterEvents)