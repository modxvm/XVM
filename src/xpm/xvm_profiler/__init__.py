""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '3.1.0',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.13'],
    # optional
}


#####################################################################
# imports

import cProfile, pstats, StringIO

import BigWorld
import game
from Avatar import PlayerAvatar
from gui.Scaleform.Flash import Flash

from xfw import *
from xvm_main.python.logger import *

import as2profiler


#####################################################################
# constants

# for AS2
class XVM_PROFILER_AS2COMMAND(object):
    PROF_METHOD_START = "prof_method_start"
    PROF_METHOD_END = "prof_method_end"


#####################################################################
# as2profiler

_BATTLE_SWF = 'battle.swf'
_VMM_SWF = 'VehicleMarkersManager.swf'
_SWFS = [_BATTLE_SWF, _VMM_SWF]


@registerEvent(Flash, '__init__')
def FlashInit(self, swf, className='Flash', args=None, path=None):
    self.swf = swf
    if self.swf not in _SWFS:
        return
    self.addExternalCallback('xvm.cmd', lambda *args: onXvmCommand(self, *args))


@registerEvent(Flash, 'beforeDelete')
def FlashBeforeDelete(self):
    if self.swf not in _SWFS:
        return
    # log("FlashBeforeDelete: " + self.swf)
    self.removeExternalCallback('xvm.cmd')


@registerEvent(game, 'fini')
def fini():
    if IS_DEVELOPMENT:
        showPythonResult()


#####################################################################
# onXvmCommand

def onXvmCommand(proxy, id, cmd, *args):
    try:
        if cmd == XVM_PROFILER_AS2COMMAND.PROF_METHOD_START:
            as2profiler.g_as2profiler.methodStart(args[0])
        if cmd == XVM_PROFILER_AS2COMMAND.PROF_METHOD_END:
            as2profiler.g_as2profiler.methodEnd(args[0])
    except Exception, ex:
        err(traceback.format_exc())


#####################################################################
# cProfile

_pr = cProfile.Profile()
if IS_DEVELOPMENT:
    _pr.enable()


# on map load (battle loading)
@registerEvent(PlayerAvatar, 'onEnterWorld')
def PlayerAvatar_onEnterWorld(self, *args):
    def en():
        as2profiler.g_as2profiler.init()

        global _pr
        log('xvm_profiler enabled')
        _pr.enable()
    BigWorld.callback(10, en)


# on map close
@registerEvent(PlayerAvatar, 'onLeaveWorld')
def PlayerAvatar_onLeaveWorld(self, *args):
    as2profiler.g_as2profiler.showResult()

    showPythonResult()


_shown = False
def showPythonResult():
    global _shown
    if not _shown:
        _shown = True
        global _pr
        _pr.disable()
        s = StringIO.StringIO()
        sortby = 'cumulative'
        p = pstats.Stats(_pr, stream=s).sort_stats(sortby)
        p.print_stats('(xfw|xvm)', 15)
        log(s.getvalue())
