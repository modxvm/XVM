""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO (mandatory)

XFW_MOD_VERSION    = '3.0.0'
XFW_MOD_URL        = 'http://www.modxvm.com/'
XFW_MOD_UPDATE_URL = 'http://www.modxvm.com/en/download-xvm/'
XFW_GAME_VERSIONS  = ['0.9.8']

#####################################################################

import BigWorld

from xfw import *
from xvm_main.python.logger import *


#####################################################################
# constants

class LINKAGES(object):
    UI_LINKAGE_COMMON_QUESTS = "xvm.quests.UI::UI_CommonQuestsView"


#####################################################################
# event handlers

def EventsWindow_loadView(base, self, linkage, alias):
    from gui.Scaleform.genConsts.QUESTS_ALIASES import QUESTS_ALIASES

    if linkage == QUESTS_ALIASES.COMMON_QUESTS_VIEW_LINKAGE:
        linkage = LINKAGES.UI_LINKAGE_COMMON_QUESTS
        alias = LINKAGES.UI_LINKAGE_COMMON_QUESTS
    base(self, linkage, alias)


#####################################################################
# Register events

def _RegisterEvents():
    import gui.Scaleform.daapi.settings.config as config
    from gui.Scaleform.framework import ViewSettings
    from gui.Scaleform.daapi.view.lobby.server_events import QuestsCurrentTab, QuestsTileChainsView
    from gui.Scaleform.framework import ViewTypes
    from gui.Scaleform.framework import ScopeTemplates
    from gui.Scaleform.framework import g_entitiesFactories

    config.VIEWS_SETTINGS += (ViewSettings(LINKAGES.UI_LINKAGE_COMMON_QUESTS, QuestsCurrentTab, None,
                                           ViewTypes.COMPONENT, None, ScopeTemplates.DEFAULT_SCOPE),)
    g_entitiesFactories.initSettings(config.VIEWS_SETTINGS)

    from gui.Scaleform.daapi.view.lobby.server_events.EventsWindow import EventsWindow
    OverrideMethod(EventsWindow, '_loadView', EventsWindow_loadView)

BigWorld.callback(0, _RegisterEvents)
