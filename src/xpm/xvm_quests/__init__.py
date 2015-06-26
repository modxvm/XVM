""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '3.1.0',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.9'],
    # optional
}

#####################################################################

import traceback
import BigWorld
from gui.Scaleform.genConsts.QUEST_TASK_FILTERS_TYPES import QUEST_TASK_FILTERS_TYPES

from xfw import *
from xvm_main.python.logger import *
from xvm_main.python.xvm import l10n
import xvm_main.python.userprefs as userprefs

#####################################################################
# constants

class LINKAGES(object):
    UI_LINKAGE_COMMON_QUESTS = "xvm.quests_ui::UI_CommonQuestsView"

class FILTERS(object):
    HIDE_WITH_HONORS = "hideWithHonors"
    STARTED = "started"

#####################################################################
# event handlers

def EventsWindow_loadView(base, self, linkage, alias):
    from gui.Scaleform.genConsts.QUESTS_ALIASES import QUESTS_ALIASES

    ui_required = False
    if linkage == QUESTS_ALIASES.COMMON_QUESTS_VIEW_LINKAGE:
        linkage = LINKAGES.UI_LINKAGE_COMMON_QUESTS
        alias = LINKAGES.UI_LINKAGE_COMMON_QUESTS
        ui_required = True

    if ui_required:
        if not 'xvm_quests_ui.swf' in xfw_mods_info.loaded_swfs:
            BigWorld.callback(0, lambda:base(self, linkage, alias))
            return

    base(self, linkage, alias)


def QuestsTileChainsView_as_setHeaderDataS(base, self, data):
    if data:
        data['filters']['taskTypeFilterData'].insert(2, {'label': l10n('Hide with honors'),
                                                         'data': FILTERS.HIDE_WITH_HONORS})
        data['filters']['taskTypeFilterData'].insert(3, {'label': l10n('Started'),
                                                         'data': FILTERS.STARTED})
    return base(self, data)


def QuestsTileChainsView__getCurrentFilters(base, self):
    if self._navInfo.potapov.filters is None:
        try:
            settings = _GetSettings()
            return (settings.get('vehType', -1), settings.get('questState', QUEST_TASK_FILTERS_TYPES.ALL))
        except Exception:
            warn(traceback.format_exc())
    return base(self)


def QuestsTileChainsView__updateTileData(self, vehType, questState, selectItemID = -1):
    _SaveSettings(vehType=vehType, questState=questState)


# PRIVATE

def _PREFS_NAME():
    return 'xvm_quests/%s/filters' % getCurrentPlayerId()


def _GetSettings():
    try:
        settings = userprefs.get(_PREFS_NAME(), None)
        if settings is None:
            return {}
        else:
            if not isinstance(settings, dict) or 'ver' not in settings:
                raise Exception('Bad settings format')

            # # snippet for format fixing
            # ver = settings['ver']
            # if ver == '3.x.y':
            #     ver = '3.x.z'

            return settings
    except Exception:
        warn(traceback.format_exc())
        _SaveSettings()
    return {}


def _SaveSettings(vehType=-1, questState=QUEST_TASK_FILTERS_TYPES.ALL):
    #log("{} {} {}".format(vehType, questState))
    try:
        settings = {
            'ver':XFW_MOD_INFO['VERSION'],
            'vehType':vehType,
            'questState':questState,
        }
        userprefs.set(_PREFS_NAME(), settings)
    except Exception:
        err(traceback.format_exc())

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

    from gui.Scaleform.daapi.view.lobby.server_events import QuestsTileChainsView
    OverrideMethod(QuestsTileChainsView, 'as_setHeaderDataS', QuestsTileChainsView_as_setHeaderDataS)
    OverrideMethod(QuestsTileChainsView, '_QuestsTileChainsView__getCurrentFilters', QuestsTileChainsView__getCurrentFilters)
    RegisterEvent(QuestsTileChainsView, '_QuestsTileChainsView__updateTileData', QuestsTileChainsView__updateTileData)

    from gui.Scaleform.daapi.view.lobby.server_events.QuestsTileChainsView import _QuestsFilter
    _QuestsFilter._FILTER_BY_STATE[FILTERS.HIDE_WITH_HONORS] = lambda q: not q.isFullCompleted(True)
    _QuestsFilter._FILTER_BY_STATE[FILTERS.STARTED] = lambda q: q.isInProgress()

BigWorld.callback(0, _RegisterEvents)
