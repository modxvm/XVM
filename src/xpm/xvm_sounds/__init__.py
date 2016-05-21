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
import WWISE

from xfw import *

import xvm_main.python.config as config
from xvm_main.python.logger import *

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

#####################################################################
# imports new sound events dispatchers

import sixthSense
import fireAlert
import ammoBay
import enemySighted
import battleEnd
import test