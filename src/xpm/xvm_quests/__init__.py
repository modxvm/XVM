""" XVM (c) www.modxvm.com 2013-2017 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '0.9.17.1',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.17.1'],
    # optional
}


#####################################################################
# imports

import traceback

import BigWorld
from gui.Scaleform.genConsts.QUEST_TASK_FILTERS_TYPES import QUEST_TASK_FILTERS_TYPES
from gui.Scaleform.daapi.view.lobby.server_events.QuestsTileChainsView import _QuestsTileChainsView, _QuestsFilter

from xfw import *

from xvm_main.python.logger import *
from xvm_main.python.xvm import l10n
import xvm_main.python.userprefs as userprefs


#####################################################################
# constants

class FILTERS(object):
    HIDE_WITH_HONORS = 5
    STARTED = 6
    INCOMPLETE = 7


#####################################################################
# handlers

_QuestsFilter._FILTER_BY_STATE.update({
    FILTERS.HIDE_WITH_HONORS: lambda q: not q.isFullCompleted(True),
    FILTERS.STARTED: lambda q: q.isInProgress(),
    FILTERS.INCOMPLETE: lambda q: q.isInProgress() or (q.isCompleted() and not q.isFullCompleted(True))})


@overrideMethod(_QuestsTileChainsView, 'as_setHeaderDataS')
def _QuestsTileChainsView_as_setHeaderDataS(base, self, data):
    if data:
        data['filters']['taskTypeFilterData'].insert(2, {'label': l10n('Hide with honors'),
                                                         'data': FILTERS.HIDE_WITH_HONORS})
        data['filters']['taskTypeFilterData'].insert(3, {'label': l10n('Started'),
                                                         'data': FILTERS.STARTED})
        data['filters']['taskTypeFilterData'].insert(4, {'label': l10n('Incomplete'),
                                                         'data': FILTERS.INCOMPLETE})
    return base(self, data)


@overrideMethod(_QuestsTileChainsView, '_QuestsTileChainsView__getCurrentFilters')
def _QuestsTileChainsView__getCurrentFilters(base, self):

    if self._navInfo.selectedPQ.filters is None:
        try:
            settings = _GetSettings()
            return (settings.get('vehType', -1), settings.get('questState', QUEST_TASK_FILTERS_TYPES.ALL))
        except Exception:
            warn(traceback.format_exc())
    return base(self)


@registerEvent(_QuestsTileChainsView, '_QuestsTileChainsView__updateTileData')
def _QuestsTileChainsView__updateTileData(self, vehType, questState, selectItemID = -1):
    _SaveSettings(vehType, questState)


# PRIVATE

def _PREFS_NAME():
    return 'xvm_quests/%s/filters' % getCurrentAccountDBID()


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
    #log("{} {}".format(vehType, questState))
    try:
        settings = {
            'ver':XFW_MOD_INFO['VERSION'],
            'vehType':vehType,
            'questState':questState,
        }
        userprefs.set(_PREFS_NAME(), settings)
    except Exception:
        err(traceback.format_exc())
