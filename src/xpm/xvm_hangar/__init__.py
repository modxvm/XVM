""" XVM (c) www.modxvm.com 2013-2016 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '0.9.17.0.1',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.17.0.1'],
    # optional
}

#####################################################################
# imports

import traceback

import BigWorld
import game
import helpers
import nations
from CurrentVehicle import g_currentVehicle
from gui.shared import g_eventBus, g_itemsCache
from gui.prb_control.settings import PREBATTLE_RESTRICTION
from gui.Scaleform.daapi.view.meta.BarracksMeta import BarracksMeta
from gui.shared.gui_items.Vehicle import Vehicle
from gui.prb_control.entities.base.limits import VehicleIsValid

from xfw import *

import xvm_main.python.config as config
from xvm_main.python.consts import *
from xvm_main.python.logger import *
from xvm_main.python.xvm import l10n

import svcmsg

#####################################################################
# initialization/finalization

def onConfigLoaded(self, e=None):
    Vehicle.NOT_FULL_AMMO_MULTIPLIER = config.get('hangar/lowAmmoPercentage', 20) / 100.0


g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, onConfigLoaded)


@registerEvent(game, 'fini')
def fini():
    g_eventBus.removeListener(XVM_EVENT.CONFIG_LOADED, onConfigLoaded)


#####################################################################
# handlers

# original function in 9.10 does not take into account NOT_FULL_AMMO_MULTIPLIER
@overrideMethod(Vehicle, 'isAmmoFull')
def Vehicle_isAmmoFull(base, self):
    try:
        if not self.isEvent:
            mult = self.NOT_FULL_AMMO_MULTIPLIER
        else:
            mult = 1.0
        return sum((s.count for s in self.shells)) >= self.ammoMaxSize * mult
    except Exception as ex:
        err(traceback.format_exc())
        return base(self)

#barracks: add nation flag and skills for tanksman
@overrideMethod(BarracksMeta, 'as_setTankmenS')
def BarracksMeta_as_setTankmenS(base, self, data):
    try:
        show_flags = config.get('hangar/barracksShowFlags', True)
        show_skills = config.get('hangar/barracksShowSkills', True)
        if show_flags or show_skills:
            imgPath = 'img://../mods/shared_resources/xvm/res/icons/barracks'
            for tankman in data['tankmenData']:
                if 'role' not in tankman:
                    continue
                tankman['rank'] = tankman['role']
                tankman_role_arr = []
                if show_flags:
                    tankman_role_arr.append("<img src='%s/nations/%s.png' vspace='-3'>" % (imgPath, nations.NAMES[tankman['nationID']]))
                if show_skills:
                    tankman_role_arr.append('')
                    tankman_full_info = g_itemsCache.items.getTankman(tankman['tankmanID'])
                    for skill in tankman_full_info.skills:
                        tankman_role_arr[-1] += "<img src='%s/skills/%s' vspace='-3'>" % (imgPath, skill.icon)
                    if len(tankman_full_info.skills):
                        tankman_role_arr[-1] += "%s%%" % tankman_full_info.descriptor.lastSkillLevel
                    if tankman_full_info.hasNewSkill and tankman_full_info.newSkillCount[0] > 0:
                        tankman_role_arr[-1] += "<img src='%s/skills/new_skill.png' vspace='-3'>x%s" % (imgPath, tankman_full_info.newSkillCount[0])
                    if not tankman_role_arr[-1]:
                        tankman_role_arr[-1] = l10n('noSkills')
                tankman['role'] = ' '.join(tankman_role_arr)
    except Exception as ex:
        err(traceback.format_exc())
    return base(self, data)


# low ammo => vehicle not ready
@overrideMethod(Vehicle, 'isReadyToPrebattle')
def Vehicle_isReadyToPrebattle(base, self, *args, **kwargs):
    try:
        if not self.hasLockMode() and not self.isAmmoFull and config.get('hangar/blockVehicleIfLowAmmo'):
            return False
    except Exception as ex:
        err(traceback.format_exc())
    return base(self, *args, **kwargs)


# low ammo => vehicle not ready
@overrideMethod(Vehicle, 'isReadyToFight')
def Vehicle_isReadyToFight(base, self, *args, **kwargs):
    try:
        if not self.hasLockMode() and not self.isAmmoFull and config.get('hangar/blockVehicleIfLowAmmo'):
            return False
    except Exception as ex:
        err(traceback.format_exc())
    return base.fget(self, *args, **kwargs) # base is property


# low ammo => vehicle not ready (disable red button)
@overrideMethod(VehicleIsValid, 'check')
def _VehicleIsValid_check(base, self, *args, **kwargs):
    res = base(self, *args, **kwargs)
    if res[0] == True:
        try:
            if not g_currentVehicle.isReadyToFight() and g_currentVehicle.item and not g_currentVehicle.item.isAmmoFull and config.get('hangar/blockVehicleIfLowAmmo'):
                res = (False, PREBATTLE_RESTRICTION.VEHICLE_NOT_READY)
        except Exception as ex:
            err(traceback.format_exc())
    return res

# low ammo => write on carousel's vehicle 'low ammo'
@overrideMethod(helpers.i18n, 'makeString')
def i18n_makeString(base, key, *args, **kwargs):
    if key == '#menu:tankCarousel/vehicleStates/ammoNotFull': # originally returns empty string
        return l10n('lowAmmo')
    return base(key, *args, **kwargs)
