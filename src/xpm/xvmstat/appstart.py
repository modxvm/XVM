""" xvm (c) sirmax 2013-2014 """

from gui.Scaleform.framework import g_entitiesFactories, ViewSettings, ViewTypes, ScopeTemplates
from gui.Scaleform.framework.entities.View import View

from logger import *

_alias = 'xvm'
_url = '../../../xvm/mods/xvm.swf'
_viewType = ViewTypes.SERVICE_LAYOUT
_scopeTemplate = ScopeTemplates.GLOBAL_SCOPE
_settings = ViewSettings(_alias, View, _url, _viewType, None, _scopeTemplate)
g_entitiesFactories.addSettings(_settings)

app = None

def AppStarted(event):
    #debug('AppStarted')

    import BigWorld
    import BattleReplay
    from ConnectionManager import connectionManager

    global app
    if BattleReplay.g_replayCtrl.autoStartBattleReplay() or connectionManager.isConnected():
        app.loadView(_alias)
    else:
        BigWorld.callback(0.001, lambda: app.loadView(_alias))
