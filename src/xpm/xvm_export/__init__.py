""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '3.1.0',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.8.1','0.9.9'],
    # optional
}

#####################################################################

import BigWorld

from xfw import *
from xvm_main.python.logger import *

import fps

#####################################################################
# event handlers

# on map load (battle loading)
def PlayerAvatar_onEnterWorld(self, *args):
    fps.start()

# on map close
def PlayerAvatar_onLeaveWorld(self, *args):
    fps.stop()

#####################################################################
# Register events

def _RegisterEvents():
    from Avatar import PlayerAvatar
    RegisterEvent(PlayerAvatar, 'onEnterWorld', PlayerAvatar_onEnterWorld)
    RegisterEvent(PlayerAvatar, 'onLeaveWorld', PlayerAvatar_onLeaveWorld)

BigWorld.callback(0, _RegisterEvents)
