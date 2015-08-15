""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '3.1.0',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.9','0.9.10'],
    # optional
}

#####################################################################

import traceback

import BigWorld
from gui.shared.SoundEffectsId import SoundEffectsId
from gui.shared.utils.sound import Sound

from xfw import *

import xvm_main.python.config as config
from xvm_main.python.logger import *

#####################################################################
# event handlers

def Battle_showSixthSenseIndicator(self, isShow):
    try:
        vehId = BigWorld.entities[BigWorld.player().playerVehicleID].typeDescriptor.type.compactDescr
        if vehId == 59393: # Rudy
            Sound('/rudy/dog/dog').play()
        else:
            soundId = config.get('sounds/sixthSense')
            if soundId is not None and soundId != '':
                Sound(soundId).play()
    except:
        err(traceback.format_exc())

def _test():
    log('test')
    soundId = config.get('sounds/sixthSense')
    if soundId is not None and soundId != '':
        Sound(soundId).play()
    BigWorld.callback(1, _test)

#####################################################################
# Register events

def _RegisterEvents():
    #import FMOD
    #FMOD.loadEventProject('../mods/shared_resources/xvm/res/audio/xvm')
    #loadSuccessfully = FMOD.loadSoundBankIntoMemoryFromPath('../mods/shared_resources/xvm/res/audio/xvm.fsb')
    #log('ok: {}'.format(loadSuccessfully))
    #log(FMOD.getSoundBanks())

    from gui.Scaleform.Battle import Battle
    RegisterEvent(Battle, '_showSixthSenseIndicator', Battle_showSixthSenseIndicator)

    #BigWorld.callback(10, _test)

BigWorld.callback(0, _RegisterEvents)
