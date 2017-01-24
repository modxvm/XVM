""" XVM (c) www.modxvm.com 2013-2017 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '0.9.17.0.3',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.17.0.3'],
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

@overrideMethod(WWISE, 'WW_eventGlobal')
def _WWISE_WW_eventGlobal(base, event):
    return base(_checkAndReplace(event))

@overrideMethod(WWISE, 'WW_eventGlobalPos')
def _WWISE_WW_eventGlobalPos(base, event, pos):
    return base(_checkAndReplace(event), pos)

@overrideMethod(WWISE, 'WW_getSoundObject')
def _WWISE_WW_getSoundObject(base, objectName, *args, **kwargs):
    return base(_checkAndReplace(objectName), *args, **kwargs)

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

import bankManager

import sixthSense
import fireAlert
import ammoBay
import enemySighted
import battleEnd
import test