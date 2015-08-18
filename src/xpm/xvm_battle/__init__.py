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
# imports

import traceback

import BigWorld

from xfw import *

from xvm_main.python.logger import *
import xvm_main.python.config as config

import fragCorrelationPanel
import minimap

#####################################################################
# hooks

import gui.Scaleform.daapi.view.battle.score_panel as score_panel
OverrideMethod(score_panel._FragCorrelationPanel, 'updateScore', fragCorrelationPanel.FragCorrelationPanel_updateScore)
OverrideMethod(score_panel, '_markerComparator', fragCorrelationPanel._markerComparator)

from gui.Scaleform.Minimap import Minimap
RegisterEvent(Minimap, 'start', minimap.Minimap_start)
OverrideMethod(Minimap, '_Minimap__callEntryFlash', minimap.Minimap__callEntryFlash)
RegisterEvent(Minimap, '_Minimap__addEntryLit', minimap.Minimap__addEntryLit)
