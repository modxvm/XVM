""" XVM (c) www.modxvm.com 2013-2017 """

#####################################################################
# imports

import cProfile, pstats, StringIO

import BigWorld
import game
from Avatar import PlayerAvatar
from gui.shared import g_eventBus

from xfw import *
from xvm_main.python.consts import XVM_PROFILER_COMMAND
from xvm_main.python.logger import *

from swfprofiler import g_swfprofiler


#####################################################################
# initialization/finalization

def start():
    g_eventBus.addListener(XVM_PROFILER_COMMAND.BEGIN, g_swfprofiler.begin)
    g_eventBus.addListener(XVM_PROFILER_COMMAND.END, g_swfprofiler.end)

BigWorld.callback(0, start)

@registerEvent(game, 'fini')
def fini():
    g_eventBus.removeListener(XVM_PROFILER_COMMAND.BEGIN, g_swfprofiler.begin)
    g_eventBus.removeListener(XVM_PROFILER_COMMAND.END, g_swfprofiler.end)

    # show results on client close
    showPythonResult()


#####################################################################
# cProfile

_pr = cProfile.Profile()
_pr.enable()

# on map load (battle loading)
@registerEvent(PlayerAvatar, 'onBecomePlayer')
def _PlayerAvatar_onBecomePlayer(self):
    def en():
        g_swfprofiler.init()
        global _pr
        log('xvm_profiler enabled')
        _pr.enable()
    #BigWorld.callback(10, en)
    en()

# on map close
@registerEvent(PlayerAvatar, 'onBecomeNonPlayer')
def _PlayerAvatar_onBecomeNonPlayer(self):
    g_swfprofiler.showResult()
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
        p.print_stats('(xfw|xvm)', 20)
        log(s.getvalue())
