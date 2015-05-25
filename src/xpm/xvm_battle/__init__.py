""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO (mandatory)

XFW_MOD_VERSION    = '3.0.0'
XFW_MOD_URL        = 'http://www.modxvm.com/'
XFW_MOD_UPDATE_URL = 'http://www.modxvm.com/en/download-xvm/'
XFW_GAME_VERSIONS  = ['0.9.8']

#####################################################################

import traceback
import BigWorld
from xfw import *
from xvm_main.python.logger import *
import xvm_main.python.config as config

#####################################################################
# Register events

def _RegisterEvents():
    import fragCorrelationPanel
    from gui.Scaleform.daapi.view.battle.score_panel import _FragCorrelationPanel
    OverrideMethod(_FragCorrelationPanel, 'updateScore', fragCorrelationPanel.FragCorrelationPanel_updateScore)

    import minimap
    from gui.Scaleform.Minimap import Minimap
    RegisterEvent(Minimap, 'start', minimap.Minimap_start)
    OverrideMethod(Minimap, '_Minimap__callEntryFlash', minimap.Minimap__callEntryFlash)
    RegisterEvent(Minimap, '_Minimap__addEntryLit', minimap.Minimap__addEntryLit)

BigWorld.callback(0, _RegisterEvents)
