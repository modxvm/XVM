""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO (mandatory)

XFW_MOD_VERSION    = "2.0.0"
XFW_MOD_URL        = "http://www.modxvm.com/"
XFW_MOD_UPDATE_URL = "http://www.modxvm.com/en/download-xvm/"
XFW_GAME_VERSIONS  = ["0.9.6"]

#####################################################################

import cProfile, pstats, StringIO

import BigWorld

from xfw import *
from xvm_main.python.logger import *

#####################################################################
# event handlers

_pr = cProfile.Profile()

# on map load (battle loading)
def PlayerAvatar_onEnterWorld(self, *args):
    def en():
        global _pr
        log('xvm_profiler enabled')
        _pr.enable()
    BigWorld.callback(10, en)

# on map close
def PlayerAvatar_onLeaveWorld(self, *args):
    global _pr
    _pr.disable()

    s = StringIO.StringIO()
    sortby = 'cumulative'
    p = pstats.Stats(_pr, stream=s).sort_stats(sortby)
    p.print_stats('(xfw|xvm)')
    #p.print_callers('updateBattleState')
    log(s.getvalue())

#####################################################################
# Register events

def _RegisterEvents():
    from Avatar import PlayerAvatar
    RegisterEvent(PlayerAvatar, 'onEnterWorld', PlayerAvatar_onEnterWorld)
    RegisterEvent(PlayerAvatar, 'onLeaveWorld', PlayerAvatar_onLeaveWorld)

if IS_DEVELOPMENT:
    BigWorld.callback(0, _RegisterEvents)
