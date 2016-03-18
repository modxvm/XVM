""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '0.9.14',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.14'],
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

from xfw import *

import xvm_main.python.config as config
from xvm_main.python.logger import *


#####################################################################
# handlers

@overrideMethod(WWISE, 'WG_loadBanks')
def WWISE_WG_loadBanks(base, *args, **kwargs):
    extraBanks = config.get('sounds/soundBanks/%s' % ('hangar' if args[1] else 'battle'))
    if extraBanks:
        lst = list(args)
        lst[0] += extraBanks
        args = tuple(lst)
    debug('WWISE.WG_loadBanks: %s' % args[0])
    base(*args, **kwargs)


@overrideMethod(SoundGroups.g_instance, 'checkAndReplace')
def SoundGroups_g_instance_checkAndReplace(base, event):
    event = base(event)
    if not event:
        return event
    mappedEvent = config.get('sounds/soundMapping/%s' % event)
    logSoundEvents = config.get('sounds/logSoundEvents')
    if mappedEvent is not None:
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
        vehId = BigWorld.entities[BigWorld.player().playerVehicleID].typeDescriptor.type.compactDescr
        if vehId == 59393: # Rudy
            soundId = config.get('sounds/events/sixthSenseRudy')
        else:
            soundId = config.get('sounds/events/sixthSense')
        if soundId is not None and soundId != '':
            SoundGroups.g_instance.playSound2D(soundId)
    except:
        err(traceback.format_exc())


@registerEvent(Battle, '_setFireInVehicle')
def Battle_setFireInVehicle(self, bool):
    try:
        soundId = config.get('sounds/events/fireAlert')
        if soundId is not None and soundId != '':
            SoundGroups.g_instance.playSound2D(soundId)
    except:
        err(traceback.format_exc())


@registerEvent(DamagePanel, '_updateDeviceState')
def DamagePanel_updateDeviceState(self, value):
    try:
        module, state, _ = value
        if module == 'ammoBay' and state == 'critical':
            soundId = config.get('sounds/events/ammoBay')
            if soundId is not None and soundId != '':
                SoundGroups.g_instance.playSound2D(soundId)
    except:
        err(traceback.format_exc())


# TEST

def _test():
    log('test')
    soundId = config.get('sounds/events/sixthSenseRudy')
    if soundId is not None and soundId != '':
        SoundGroups.g_instance.playSound2D(soundId)
    BigWorld.callback(3, _test)

#BigWorld.callback(10, _test)
