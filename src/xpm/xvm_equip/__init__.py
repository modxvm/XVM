""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '3.1.0',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.9'],
    # optional
}

#####################################################################

import BigWorld
import traceback
from xfw import RegisterEvent, OverrideMethod, GAME_REGION
import xvm_main.python.userprefs as userprefs
import xvm_main.python.config as config
from xvm_main.python.logger import err, debug
from xvm_main.python.constants import *
import wg_compat

#####################################################################
# globals

last_vehicles_id_arr = [] # FIFO order of switching vehicles
equip_settings = None
player_name = None
PREF_VERSION = '1.0'

#####################################################################
# initialization/finalization

def start():
    from gui.shared import g_eventBus
    g_eventBus.addListener(XVM_EVENT.RELOAD_CONFIG, xvm_equip_init)

def fini():
    from gui.shared import g_eventBus
    g_eventBus.removeListener(XVM_EVENT.RELOAD_CONFIG, xvm_equip_init)

#####################################################################
# event handlers

# player entered, get player name + region as unique name
def xvm_equip_init(*args, **kwargs):
    try:
        global player_name, last_vehicles_id_arr, equip_settings
        last_vehicles_id_arr = []
        equip_settings = {}
        if not (config.get('hangar/enableEquipAutoReturn') and BigWorld.player()):
            debug('xvm_equip: disabled')
            player_name = None
            return
        player_name = '%s_%s' % (BigWorld.player().name, GAME_REGION)
        debug('xvm_equip: enabled, using name %s' % player_name)
    except Exception, ex:
        err(traceback.format_exc())
        player_name = None

# device is changed on vehicle, remember the setting
def AmmunitionPanel_setVehicleModule(self, newId, slotIdx, oldId, isRemove):
    try:
        if not player_name:
            return
        global equip_settings
        from CurrentVehicle import g_currentVehicle
        from gui.shared import g_itemsCache
        veh_name = g_currentVehicle.item.name
        settings_changed = False
        if isRemove and veh_name in equip_settings:
            equip_settings[veh_name][slotIdx] = None
            settings_changed = True
        else:
            newId = int(newId)
            new_device = g_itemsCache.items.getItemByCD(newId)
            if new_device and new_device.isRemovable and new_device.itemTypeName == 'optionalDevice':
                equip_settings[veh_name][slotIdx] = new_device.intCD
                settings_changed = True
        if settings_changed:
            debug('xvm_equip: devices changed on %s, new set: %s' % (veh_name, equip_settings[veh_name]))
            save_settings()
    except Exception, ex:
        err(traceback.format_exc())

# vehicle switched, remove removable devices from previous and put on new one
def TmenXpPanel_onVehicleChange(*args, **kwargs):
    try:
        if not player_name:
            return
        global last_vehicles_id_arr, equip_settings
        from CurrentVehicle import g_currentVehicle
        from gui.shared import g_itemsCache, REQ_CRITERIA
        from gui.shared.gui_items import GUI_ITEM_TYPE
        if last_vehicles_id_arr and last_vehicles_id_arr[-1] == g_currentVehicle.item.intCD:
            return
        if not (last_vehicles_id_arr and equip_settings) and not get_settings():
            return
        vehicle = g_currentVehicle.item
        # get one of each type of removable devices from vehicles by FIFO order of usage
        if vehicle.intCD in last_vehicles_id_arr:
            last_vehicles_id_arr.remove(vehicle.intCD)
        last_vehicles_id_arr.append(vehicle.intCD)
        updated_inventoryCount = {}
        for device in g_itemsCache.items.getItems(GUI_ITEM_TYPE.OPTIONALDEVICE, REQ_CRITERIA.REMOVABLE).values():
            updated_inventoryCount[device.name] = device.inventoryCount
        devices_arr = []
        for vehicle_id in last_vehicles_id_arr[:-1]:
            prev_vehicle = g_itemsCache.items.getItemByCD(vehicle_id)
            if not prev_vehicle or not prev_vehicle.isInInventory: # sold?
                last_vehicles_id_arr.remove(vehicle_id)
                continue
            if prev_vehicle.isAlive:
                for slotIdx, installed_device in enumerate(prev_vehicle.optDevices):
                    if installed_device and installed_device.isRemovable and installed_device.name not in devices_arr and not updated_inventoryCount[installed_device.name]:
                        #debug('xvm_equip: get %s from %s' % (installed_device.name, prev_vehicle.name))
                        wg_compat.g_instance.processReturnEquip(prev_vehicle, installed_device, slotIdx, False)
                        devices_arr.append(installed_device.name)

        if vehicle.name in equip_settings and len(equip_settings[vehicle.name]) == 3: # equip all modules from user prefs
            if vehicle.isAlive:
                debug_str = 'xvm_equip: equip to %s devices:' % vehicle.name
                for slotIdx, installed_device in enumerate(vehicle.optDevices):
                    needed_device_id = equip_settings[vehicle.name][slotIdx]
                    if needed_device_id and (not installed_device or (installed_device.isRemovable and installed_device.intCD != needed_device_id)):
                        needed_device = g_itemsCache.items.getItemByCD(needed_device_id)
                        debug_str += ' %s' % needed_device.name
                        wg_compat.g_instance.processReturnEquip(vehicle, needed_device, slotIdx, True)
                debug(debug_str)
            else:
                debug("xvm_equip: can't put equipment, vehicle %s not ready" % vehicle.name)
        else: # no prefs, save currently installed modules to user prefs
            installed_devices(vehicle)
            debug('xvm_equip: no prefs for %s, save installed modules: %s' % (vehicle.name, equip_settings[vehicle.name]))
            save_settings()
    except Exception, ex:
        err(traceback.format_exc())

#####################################################################
# utility functions

# load user prefs or create new from current vehicles in hangar
def get_settings():
    try:
        global last_vehicles_id_arr, equip_settings
        from gui.shared import g_itemsCache, REQ_CRITERIA
        inventory_vehicles_dict = dict(g_itemsCache.items.getVehicles(REQ_CRITERIA.INVENTORY))
        last_vehicles_id_arr = inventory_vehicles_dict.keys()
        equip_settings = userprefs.get('auto_equip/%s' % player_name)
        if equip_settings is None or 'version' not in equip_settings or equip_settings['version'] != PREF_VERSION: # no prefs, or old version: get currently installed devices
            if equip_settings is None:
                debug('xvm_equip: no prefs for %s, get currently installed devices' % player_name)
            else:
                debug('xvm_equip: old prefs for %s, get currently installed devices' % player_name)
            equip_settings = {'version': PREF_VERSION}
            for vehicle in inventory_vehicles_dict.values():
                installed_devices(vehicle)
            save_settings()
        debug('xvm_equip: got settings: %s' % equip_settings)
        return True
    except Exception, ex:
        equip_settings = None
        err(traceback.format_exc())
        return False

# determine which removable devices installed on vehicle
def installed_devices(vehicle):
    try:
        global equip_settings
        equip_settings[vehicle.name] = []
        for slotIdx, installed_device in enumerate(vehicle.optDevices):
            if installed_device and installed_device.isRemovable:
                equip_settings[vehicle.name].append(installed_device.intCD)
            else:
                equip_settings[vehicle.name].append(None)
    except Exception, ex:
        err(traceback.format_exc())

# save user prefs
def save_settings():
    if player_name:
        userprefs.set('auto_equip/%s' % player_name, equip_settings)

#####################################################################
# Register events

def _RegisterEvents():
    start()
    import game
    RegisterEvent(game, 'fini', fini)

    from Account import PlayerAccount
    RegisterEvent(PlayerAccount, 'onBecomePlayer', xvm_equip_init)
    from gui.Scaleform.daapi.view.lobby.hangar.AmmunitionPanel import AmmunitionPanel
    RegisterEvent(AmmunitionPanel, 'setVehicleModule', AmmunitionPanel_setVehicleModule)
    from gui.Scaleform.daapi.view.lobby.hangar.TmenXpPanel import TmenXpPanel
    RegisterEvent(TmenXpPanel, '_onVehicleChange', TmenXpPanel_onVehicleChange)    

BigWorld.callback(0, _RegisterEvents)


# User preferences:
# no version: {'vehicle.name': list of removables} (not taking slots into account)
# ver 1.0: {'version': '1.0', 'vehicle.name': [None, removable1, removable2]} <- removables in their slots