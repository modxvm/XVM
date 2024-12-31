"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

# stdlib
import logging
import pstats
import cProfile
import StringIO

# BigWorld
from Avatar import PlayerAvatar
from gui.shared import g_eventBus

# XFW
from xfw import *

# XVM Main
from xvm_main.python.consts import XVM_PROFILER_COMMAND

# XVM Profiler
from swfprofiler import g_swfprofiler



#
# Globals
#

_pr = None
_shown = False



#
# Handlers
#

# On battle enter
def _PlayerAvatar_onBecomePlayer(self):
    global _pr
    logging.getLogger('XVM/Profiler').info('Profiling started')
    g_swfprofiler.init()
    _pr.enable()


# On battle leave
def _PlayerAvatar_onBecomeNonPlayer(self):
    logging.getLogger('XVM/Profiler').info('Profiling ended')
    g_swfprofiler.show_result()
    show_python_result()



#
# Handlers/Shared
#

def show_python_result():
    global _shown, _pr
    if not _shown:
        _shown = True
        _pr.disable()
        stream = StringIO.StringIO()
        sort_by = 'cumulative'
        stats = pstats.Stats(_pr, stream=stream).sort_stats(sort_by)
        stats.print_stats('(xfw|xvm)', 20)
        logging.getLogger('XVM/Profiler').info(stream.getvalue())



#
# XFW API
#

__initialized = False

def xfw_module_init():
    global __initialized, _pr
    if not __initialized:
        if IS_DEVELOPMENT:
            _pr = cProfile.Profile()
            _pr.enable()

            registerEvent(PlayerAvatar, 'onBecomePlayer')(_PlayerAvatar_onBecomePlayer)
            registerEvent(PlayerAvatar, 'onBecomeNonPlayer')(_PlayerAvatar_onBecomeNonPlayer)

            g_eventBus.addListener(XVM_PROFILER_COMMAND.BEGIN, g_swfprofiler.begin)
            g_eventBus.addListener(XVM_PROFILER_COMMAND.END, g_swfprofiler.end)

        __initialized = True


def xfw_module_fini():
    global __initialized, _pr
    if __initialized:
        if IS_DEVELOPMENT:
            logging.getLogger('XVM/Profiler').info('Game finalization detected')
            show_python_result()
            _pr = None

            g_eventBus.removeListener(XVM_PROFILER_COMMAND.BEGIN, g_swfprofiler.begin)
            g_eventBus.removeListener(XVM_PROFILER_COMMAND.END, g_swfprofiler.end)

        __initialized = False


def xfw_is_module_loaded():
    global __initialized
    return __initialized
