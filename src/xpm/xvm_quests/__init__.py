""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '3.1.0',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.8'],
    # optional
}

#####################################################################

import BigWorld

from xfw import *
from xvm_main.python.logger import *


#####################################################################
# constants

class LINKAGES(object):
    UI_LINKAGE_COMMON_QUESTS = "xvm.quests_ui::UI_CommonQuestsView"


#####################################################################
# event handlers

def EventsWindow_loadView(base, self, linkage, alias):
    from gui.Scaleform.genConsts.QUESTS_ALIASES import QUESTS_ALIASES

    # TODO
    #if linkage == QUESTS_ALIASES.COMMON_QUESTS_VIEW_LINKAGE:
    #    linkage = LINKAGES.UI_LINKAGE_COMMON_QUESTS
    #    alias = LINKAGES.UI_LINKAGE_COMMON_QUESTS
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
