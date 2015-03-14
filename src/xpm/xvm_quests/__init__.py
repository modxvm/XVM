""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO (mandatory)

XFW_MOD_VERSION    = "2.0.0"
XFW_MOD_URL        = "http://www.modxvm.com/"
XFW_MOD_UPDATE_URL = "http://www.modxvm.com/en/download-xvm/"
XFW_GAME_VERSIONS  = ["0.9.6","0.9.7"]

#####################################################################

import BigWorld

from xfw import *
from xvm_main.python.logger import *

#####################################################################
# constants

UI_LINKAGE = "xvm.quests::UI_QuestsTileChainsView"

#####################################################################
# event handlers

def EventsWindow_loadView(base, self, linkage, alias):
    from gui.Scaleform.genConsts.QUESTS_ALIASES import QUESTS_ALIASES
    if linkage == QUESTS_ALIASES.TILE_CHAINS_VIEW_LINKAGE:
        linkage = UI_LINKAGE
        alias = UI_LINKAGE
    base(self, linkage, alias)

def EventsWindow_onRegisterFlashComponent(base, self, viewPy, alias):
    if alias in UI_LINKAGE:
        viewPy._setMainView(self)
    base(self, viewPy, alias)

#####################################################################
# Register events

def _RegisterEvents():
    import gui.Scaleform.daapi.settings.config as config
    from gui.Scaleform.framework import ViewSettings
    from gui.Scaleform.daapi.view.lobby.server_events import QuestsTileChainsView
    from gui.Scaleform.framework import ViewTypes
    from gui.Scaleform.framework import ScopeTemplates
    from gui.Scaleform.framework import g_entitiesFactories
    config.VIEWS_SETTINGS += (ViewSettings(UI_LINKAGE, QuestsTileChainsView, None,
                                           ViewTypes.COMPONENT, None, ScopeTemplates.DEFAULT_SCOPE),)
    g_entitiesFactories.initSettings(config.VIEWS_SETTINGS)

    from gui.Scaleform.daapi.view.lobby.server_events.EventsWindow import EventsWindow
    OverrideMethod(EventsWindow, '_loadView', EventsWindow_loadView)
    OverrideMethod(EventsWindow, '_onRegisterFlashComponent', EventsWindow_onRegisterFlashComponent)

BigWorld.callback(0, _RegisterEvents)
