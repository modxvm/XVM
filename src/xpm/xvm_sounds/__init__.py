""" XVM (c) www.modxvm.com 2013-2016 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '0.9.15',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.15'],
    # optional
}


#####################################################################
# imports

import traceback

import BigWorld
import SoundGroups
import WWISE
from gui.Scaleform.Battle import Battle
from gui.Scaleform.daapi.view.battle.damage_panel import DamagePanel
from Avatar import PlayerAvatar
from gui.Scaleform.Minimap import Minimap
from gui.battle_control import g_sessionProvider

from xfw import *

import xvm_main.python.config as config
from xvm_main.python.logger import *

#####################################################################
# constants

class XVM_SOUND_EVENT(object):
    SIXTH_SENSE = "xvm_sixthSense"
    SIXTH_SENSE_RUDY = "xvm_sixthSenseRudy"
    FIRE_ALERT = "xvm_fireAlert"
    AMMO_BAY = "xvm_ammoBay"
    ENEMY_SIGHTED = "xvm_enemySighted"

#####################################################################
# handlers

@overrideMethod(WWISE, 'WG_loadBanks')
def _WWISE_WG_loadBanks(base, xmlPath, banks, isHangar, *args, **kwargs):
    if config.get('sounds/enabled'):
        extraBanks = config.get('sounds/soundBanks/%s' % ('hangar' if isHangar else 'battle'))
        if extraBanks:
            banks_list = (banks + ';' + extraBanks).split(';')
            banks_list = set([x.strip() for x in banks_list if x and x.strip()])
            banks = '; '.join(banks_list)
        log('WWISE.WG_loadBanks: %s' % banks)
    base(xmlPath, banks, isHangar, *args, **kwargs)

@overrideMethod(WWISE, 'WW_eventGlobal')
def _WWISE_WW_eventGlobal(base, event):
    return base(_checkAndReplace(event))

@overrideMethod(WWISE, 'WW_eventGlobalPos')
def _WWISE_WW_eventGlobalPos(base, event, pos):
    return base(_checkAndReplace(event), pos)

@overrideMethod(WWISE, 'WW_getSoundObject')
def _WWISE_WW_getSoundObject(base, event, matrix, local):
    return base(_checkAndReplace(event), matrix, local)

@overrideMethod(WWISE, 'WW_getSound')
def _WWISE_WW_getSound(base, eventName, objectName, matrix, local):
    return base(_checkAndReplace(eventName), _checkAndReplace(objectName), matrix, local)

@overrideMethod(WWISE, 'WW_getSoundCallback')
def _WWISE_WW_getSoundCallback(base, eventName, objectName, matrix, callback):
    return base(_checkAndReplace(eventName), _checkAndReplace(objectName), matrix, callback)

@overrideMethod(WWISE, 'WW_getSoundPos')
def _WWISE_WW_getSoundPos(base, eventName, objectName, position):
    return base(_checkAndReplace(eventName), _checkAndReplace(objectName), position)

def _checkAndReplace(event):
    if not config.get('sounds/enabled'):
        return event
    if not event:
        return event
    mappedEvent = config.get('sounds/soundMapping/%s' % event)
    logSoundEvents = config.get('sounds/logSoundEvents')
    if mappedEvent is not None:
        if mappedEvent == '':
            mappedEvent = 'emptyEvent'
        if logSoundEvents:
            log('SOUND EVENT: %s => %s' % (event, mappedEvent))
        return mappedEvent
    else:
        if logSoundEvents:
            log('SOUND EVENT: %s' % event)
        return event


# new sound events dispatchers

@registerEvent(Battle, '_showSixthSenseIndicator')
def Battle_showSixthSenseIndicator(self, isShow):
    try:
        if config.get('sounds/enabled'):
            vehId = BigWorld.entities[BigWorld.player().playerVehicleID].typeDescriptor.type.compactDescr
            # 59393 => Rudy
            soundId = XVM_SOUND_EVENT.SIXTH_SENSE_RUDY if vehId == 59393 else XVM_SOUND_EVENT.SIXTH_SENSE
            SoundGroups.g_instance.playSound2D(soundId)
    except:
        err(traceback.format_exc())


@registerEvent(Battle, '_setFireInVehicle')
def Battle_setFireInVehicle(self, bool):
    try:
        if config.get('sounds/enabled'):
            SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.FIRE_ALERT)
    except:
        err(traceback.format_exc())


@registerEvent(DamagePanel, '_updateDeviceState')
def DamagePanel_updateDeviceState(self, value):
    try:
        if config.get('sounds/enabled'):
            module, state, _ = value
            if module == 'ammoBay' and state == 'critical':
                SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.AMMO_BAY)
    except:
        err(traceback.format_exc())


enemyList = {}

@registerEvent(PlayerAvatar, '_PlayerAvatar__destroyGUI')
def PlayerAvatar_PlayerAvatar__destroyGUI(self):
    enemyList.clear()


@overrideMethod(Minimap, '_Minimap__addEntry')
def Minimap_Minimap__addEntry(base, self, vInfo, guiProps, location, doMark):
    base(self, vInfo, guiProps, location, doMark)
    try:
        if config.get('sounds/enabled'):
            if vInfo.vehicleID not in enemyList and not guiProps.isFriend:
                enemyList[vInfo.vehicleID] = True
                if doMark and not g_sessionProvider.getCtx().isPlayerObserver():
                    SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.ENEMY_SIGHTED)
    except:
        err(traceback.format_exc())


# TEST

def _test():
    log('test')
    SoundGroups.g_instance.playSound2D(XVM_SOUND_EVENT.SIXTH_SENSE_RUDY)
    BigWorld.callback(3, _test)

#BigWorld.callback(10, _test)
