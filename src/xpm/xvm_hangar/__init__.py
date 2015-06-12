""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '3.1.0',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.8.1'],
    # optional
}

#####################################################################

import traceback

import BigWorld

from xfw import *
import xvm_main.python.config as config
from xvm_main.python.logger import *
from xvm_main.python.xvm import l10n

#####################################################################
# event handlers

#barracks: add nation flag and skills for tanksman
def BarracksMeta_as_setTankmenS(base, self, tankmenCount, placesCount, tankmenInBarracks, tankmanArr):
    try:
        import nations
        from gui.shared import g_itemsCache
        imgPath = 'img://../mods/shared_resources/xvm/res/icons/barracks'
        for tankman in tankmanArr:
            if 'role' not in tankman:
                continue
            tankman['rank'] = tankman['role']
            tankman['role'] = "<img src='%s/nations/%s.png' vspace='-3'>" % (imgPath, nations.NAMES[tankman['nationID']])
            tankman_full_info = g_itemsCache.items.getTankman(tankman['tankmanID'])
            skills_str = ''
            for skill in tankman_full_info.skills:
                skills_str += "<img src='%s/skills/%s' vspace='-3'>" % (imgPath, skill.icon)
            if len(tankman_full_info.skills):
                skills_str += "%s%%" % tankman_full_info.descriptor.lastSkillLevel
            if tankman_full_info.hasNewSkill:
                skills_str += "<img src='%s/skills/new_skill.png' vspace='-3'>x%s" % (imgPath, tankman_full_info.newSkillCount[0])
            if not skills_str:
                skills_str = l10n('noSkills')
            tankman['role'] += ' ' + skills_str
    except Exception as ex:
        err(traceback.format_exc())

    return base(self, tankmenCount, placesCount, tankmenInBarracks, tankmanArr)

# less then 20% ammo => vehicle not ready
def Vehicle_isReadyToPrebattle(base, self, *args, **kwargs):
    try:
        if not self.hasLockMode() and not self.isAmmoFull and config.get('hangar/blockVehicleIfNoAmmo'):
            return False
    except Exception as ex:
        err(traceback.format_exc())
    return base(self, *args, **kwargs)

# less then 20% ammo => vehicle not ready
def Vehicle_isReadyToFight(base, self, *args, **kwargs):
    try:
        if not self.hasLockMode() and not self.isAmmoFull and config.get('hangar/blockVehicleIfNoAmmo'):
            return False
    except Exception as ex:
        err(traceback.format_exc())
    return base.fget(self, *args, **kwargs) # base is property

# less then 20% ammo => vehicle not ready (disable red button)
def _PrebattleDispatcher_canPlayerDoAction(base, self, *args, **kwargs):
    try:
        from CurrentVehicle import g_currentVehicle
        if not g_currentVehicle.isReadyToFight() and g_currentVehicle.item and not g_currentVehicle.item.isAmmoFull and config.get('hangar/blockVehicleIfNoAmmo'):
            from gui.prb_control.settings import PREBATTLE_RESTRICTION
            return (False, PREBATTLE_RESTRICTION.VEHICLE_NOT_READY)
    except Exception as ex:
        err(traceback.format_exc())
    return base(self, *args, **kwargs)

# less then 20% ammo => write on carousel's vehicle 'low ammo'
def i18n_makeString(base, key, *args, **kwargs):
    if key == '#menu:tankCarousel/vehicleStates/ammoNotFull': # originally returns empty string
        return l10n('lowAmmo')
    return base(key, *args, **kwargs)

#####################################################################
# Register events

def _RegisterEvents():
    from gui.Scaleform.daapi.view.meta.BarracksMeta import BarracksMeta
    OverrideMethod(BarracksMeta, 'as_setTankmenS', BarracksMeta_as_setTankmenS)

    from gui.shared.gui_items.Vehicle import Vehicle
    OverrideMethod(Vehicle, 'isReadyToPrebattle', Vehicle_isReadyToPrebattle)
    OverrideMethod(Vehicle, 'isReadyToFight', Vehicle_isReadyToFight)
    
    from gui.prb_control.dispatcher import _PrebattleDispatcher
    OverrideMethod(_PrebattleDispatcher, 'canPlayerDoAction', _PrebattleDispatcher_canPlayerDoAction)
    
    from helpers import i18n
    OverrideMethod(i18n, 'makeString', i18n_makeString)

BigWorld.callback(0, _RegisterEvents)
