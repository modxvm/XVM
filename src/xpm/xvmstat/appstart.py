""" XVM (c) www.modxvm.com 2013-2014 """

import BigWorld
import BattleReplay
from gui.WindowsManager import g_windowsManager
from ConnectionManager import connectionManager
from gui.Scaleform.framework import g_entitiesFactories, ViewSettings, ViewTypes, ScopeTemplates
from gui.Scaleform.framework.entities.View import View

from logger import *

_alias = 'xvm'
_url = '../../../xvm/mods/xvm.swf'
_viewType = ViewTypes.SERVICE_LAYOUT
_scopeTemplate = ScopeTemplates.GLOBAL_SCOPE
_settings = ViewSettings(_alias, View, _url, _viewType, None, _scopeTemplate)
g_entitiesFactories.addSettings(_settings)

def AppStarted(event):
    #debug('AppStarted')
    app = g_windowsManager.window
    if app is not None:
        #if BattleReplay.g_replayCtrl.autoStartBattleReplay() or connectionManager.isConnected():
        #    _loadView()
        #else:
            BigWorld.callback(0, _loadView)

def _loadView():
    try:
        #debug('loadView')
        g_windowsManager.window.loadView(_alias)
    except Exception, ex:
        err(traceback.format_exc())
