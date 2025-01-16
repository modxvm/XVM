"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

# CPython
import logging
import json
from pprint import pprint

# BigWorld
import BigWorld
from gui.shared import event_dispatcher
from gui.Scaleform.daapi.view.battle_results_window import BattleResultsWindow
from gui.Scaleform.genConsts.BATTLE_RESULTS_PREMIUM_STATES import BATTLE_RESULTS_PREMIUM_STATES
from gui.battle_results import composer
from gui.battle_results.components import base
from gui.battle_results.components.personal import DynamicPremiumState

# XFW
from xfw.events import overrideMethod

# XFW Actionscript
from xfw_actionscript.python import swf_loaded_info

# XVM Main
import xvm_main.python.config as config

# XVM BattleResults
from .data_block import XvmDataBlock



#
# Globals
#

_XVM_DATA_STATS_BLOCK = None



#
# event_dispatcher
#

# wait for loading xvm_battleresults_ui.swf
def event_dispatcher_showBattleResultsWindow_proxy(base, arenaUniqueID, *args, **kwargs):
    event_dispatcher_showBattleResultsWindow(base, arenaUniqueID, 0, *args, **kwargs)

def event_dispatcher_showBattleResultsWindow(base, arenaUniqueID, cnt, *args, **kwargs):
    if cnt < 5 and not swf_loaded_info.swf_loaded_get('xvm_lobby_ui.swf'):
        BigWorld.callback(0, lambda: event_dispatcher_showBattleResultsWindow(base, arenaUniqueID, cnt + 1, *args, **kwargs))
    else:
        base(arenaUniqueID)



#
# BattleResultsWindow
#

def BattleResultsWindow_as_setDataS(base, self, data):
    try:
        linkage = data['tabInfo'][0]['linkage']

        if linkage == 'EpicStatsUI' and not config.get('battleResults/showStandardFrontLineInterface', True):
            linkage = 'CommonStats'

        #
        # TODO 1.16.1: disable BattleResulsts
        #
        # if linkage == 'CommonStats':
        #    linkage = 'com.xvm.lobby.ui.battleresults::UI_CommonStats'

        if linkage == 'com.xvm.lobby.ui.battleresults::UI_CommonStats':
            data['tabInfo'][0]['linkage'] = linkage
            # Use data['common']['regionNameStr'] value to transfer XVM data.
            # Cannot add in data object because DAAPIDataClass is not dynamic.
            #log(data['xvm_data'])
            data['xvm_data']['regionNameStr'] = data['common']['regionNameStr']
            data['xvm_data']['arenaUniqueID'] = str(self._BattleResultsWindow__arenaUniqueID)
            data['common']['regionNameStr'] = json.dumps(data['xvm_data'], separators=(',',':'))
    
        if 'xvm_data' in data:
            del data['xvm_data']
    except Exception:
        logging.getLogger('XVM/BattleResults').exception('BattleResultsWindow_as_setDataS')
    return base(self, data)



#
# DynamicPremiumState
#

def _DynamicPremiumState_getVO(base, self):
    res = base(self)
    if self._value in [BATTLE_RESULTS_PREMIUM_STATES.PREMIUM_ADVERTISING, BATTLE_RESULTS_PREMIUM_STATES.PREMIUM_INFO]:
        self._value = BATTLE_RESULTS_PREMIUM_STATES.PREMIUM_EARNINGS
        return super(DynamicPremiumState, self).getVO()
    #res = self._value = BATTLE_RESULTS_PREMIUM_STATES.PREMIUM_BONUS
    return res



#
# StatsComposer
#

def _StatsComposer__init__(base, self, *args):
    try:
        base(self, *args)
        self._block._meta._meta.update({'xvm_data':{}})
        self._block._meta._unregistered.add('xvm_data')
        self._block.addNextComponent(_XVM_DATA_STATS_BLOCK.clone())
    except:
        logging.getLogger('XVM/BattleResults').exception('_StatsComposer__init__')



#
# PlayerSatisfactionWidget/ShowRateSatisfactionCmp
#

def _ShowRateSatisfactionCmp_convert(base, self, value, reusable):
    if not config.get('battleResults/showPlayerSatisfactionWidget', True):
        return False
    return base(self, value, reusable)



#
# XFW API
#

__initialized = False

def xfw_module_init():
    global __initialized
    if not __initialized:
        global _XVM_DATA_STATS_BLOCK
        _XVM_DATA_STATS_BLOCK = XvmDataBlock(base.DictMeta(), 'xvm_data')

        overrideMethod(event_dispatcher, 'showBattleResultsWindow')(event_dispatcher_showBattleResultsWindow_proxy)
        overrideMethod(BattleResultsWindow, 'as_setDataS')(BattleResultsWindow_as_setDataS)
        overrideMethod(DynamicPremiumState, 'getVO')(_DynamicPremiumState_getVO)
        overrideMethod(composer.StatsComposer, '__init__')(_StatsComposer__init__)
        if getRegion() != 'RU':
            from gui.battle_results.components.common import ShowRateSatisfactionCmp

            overrideMethod(ShowRateSatisfactionCmp, '_convert')(_ShowRateSatisfactionCmp_convert)
        __initialized = True


def xfw_module_fini():
    global __initialized
    if __initialized:
        __initialized = False


def xfw_is_module_loaded():
    global __initialized
    return __initialized
