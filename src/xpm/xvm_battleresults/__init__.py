""" XVM (c) https://modxvm.com 2013-2021 """

#####################################################################
# imports

import traceback
import simplejson

import BigWorld
from gui.shared import event_dispatcher
from gui.Scaleform.daapi.view.battle_results_window import BattleResultsWindow
from gui.Scaleform.daapi.view.bootcamp.BCBattleResult import BCBattleResult
from gui.Scaleform.genConsts.BATTLE_RESULTS_PREMIUM_STATES import BATTLE_RESULTS_PREMIUM_STATES
from gui.battle_results import composer
from gui.battle_results.components import base
from gui.battle_results.components.personal import DynamicPremiumState
from gui.battle_results.settings import BATTLE_RESULTS_RECORD
from gui.shared.crits_mask_parser import critsParserGenerator
from helpers import dependency
from skeletons.gui.shared import IItemsCache

from xfw import *
from xfw_actionscript.python import swf_loaded_info

from xvm_main.python.logger import *
import xvm_main.python.config as config


# wait for loading xvm_battleresults_ui.swf
@overrideMethod(event_dispatcher, 'showBattleResultsWindow')
def event_dispatcher_showBattleResultsWindow_proxy(base, arenaUniqueID):
    event_dispatcher_showBattleResultsWindow(base, arenaUniqueID)

def event_dispatcher_showBattleResultsWindow(base, arenaUniqueID, cnt=0):
    if cnt < 5 and not swf_loaded_info.swf_loaded_get('xvm_lobby_ui.swf'):
        BigWorld.callback(0, lambda: event_dispatcher_showBattleResultsWindow(base, arenaUniqueID, cnt + 1))
    else:
        base(arenaUniqueID)

@overrideMethod(BattleResultsWindow, 'as_setDataS')
def BattleResultsWindow_as_setDataS(base, self, data):
    try:
        linkage = data['tabInfo'][0]['linkage']

        if linkage == 'EpicStatsUI' and not config.get('battleResults/showStandardFrontLineInterface', True):
            linkage = 'CommonStats'

        if linkage == 'CommonStats':
            linkage = 'com.xvm.lobby.ui.battleresults::UI_CommonStats'

        if linkage == 'com.xvm.lobby.ui.battleresults::UI_CommonStats':
            data['tabInfo'][0]['linkage'] = linkage
            # Use data['common']['regionNameStr'] value to transfer XVM data.
            # Cannot add in data object because DAAPIDataClass is not dynamic.
            #log(data['xvm_data'])
            data['xvm_data']['regionNameStr'] = data['common']['regionNameStr']
            data['xvm_data']['arenaUniqueID'] = str(self._BattleResultsWindow__arenaUniqueID)
            data['common']['regionNameStr'] = simplejson.dumps(data['xvm_data'], separators=(',',':'))

        del data['xvm_data']
    except Exception as ex:
        err(traceback.format_exc())
    return base(self, data)

@overrideMethod(BCBattleResult, 'as_setDataS')
def BCBattleResult_as_setDataS(base, self, data):
    try:
        del data['xvm_data']
    except Exception as ex:
        err(traceback.format_exc())
    return base(self, data)

@overrideMethod(DynamicPremiumState, 'getVO')
def _DynamicPremiumState_getVO(base, self):
    res = base(self)
    if self._value in [BATTLE_RESULTS_PREMIUM_STATES.PREMIUM_ADVERTISING, BATTLE_RESULTS_PREMIUM_STATES.PREMIUM_INFO]:
        self._value = BATTLE_RESULTS_PREMIUM_STATES.PREMIUM_EARNINGS
        return super(DynamicPremiumState, self).getVO()
    #res = self._value = BATTLE_RESULTS_PREMIUM_STATES.PREMIUM_BONUS
    return res

#####################################################################
# collect data for XVM

class XvmDataBlock(base.StatsBlock):
    __slots__ = ('xvm_data')

    itemsCache = dependency.descriptor(IItemsCache)

    def __init__(self, meta = None, field = '', *path):
        super(XvmDataBlock, self).__init__(meta, field, *path)
        self.xvm_data = []

    def getVO(self):
        return {
            '__xvm': True, # XVM data marker
            'regionNameStr': '',
            'arenaUniqueID': 0,
            'data': self.xvm_data}

    def setRecord(self, result, reusable):
        #log(result)
        xdata_total = {
            'origXP': 0,
            'premXP': 0,
            'origCrewXP': 0,
            'premCrewXP': 0,
            'damageDealt': 0,
            'damageAssisted': 0,
            'damageAssistedCount': 0,
            'damageAssistedRadio': 0,
            'damageAssistedTrack': 0,
            'damageAssistedStun': 0,
            'damageBlockedByArmor': 0,
            'shots': 0,
            'hits': 0,
            'piercings': 0,
            'kills': 0,
            'spotted': 0,
            'stunNum': 0,
            'stunDuration': 0,
            'critsCount': 0,
            'ricochetsCount': 0,
            'nonPenetrationsCount': 0}

        for typeCompDescr, vData in reusable.personal.getVehicleCDsIterator(result, reusable):
            #log(vData)
            #log from 1.5.0.0: https://koreanrandom.com/forum/topic/49651-

            #TODO 1.5: add support for premiumPlus and premiumVip
            origXP = vData['xp']
            premXP = vData['xp']
            origCrewXP = vData['tmenXP']
            premCrewXP = vData['tmenXP']
            if vData['isPremium']:
                origXP = vData['xp'] / (vData['premiumXPFactor100'] / 100.0)
                origCrewXP = vData['tmenXP'] / (vData['premiumXPFactor100'] / 100.0)
            else:
                premXP = vData['xp'] * (vData['premiumXPFactor100'] / 100.0)
                premCrewXP = vData['tmenXP'] * (vData['premiumXPFactor100'] / 100.0)
            ownVehicle = self.itemsCache.items.getItemByCD(typeCompDescr)
            if ownVehicle and ownVehicle.isPremium:
                origCrewXP = int(origCrewXP * 1.5)
                premCrewXP = int(premCrewXP * 1.5)

            data = {
                'origXP': origXP,
                'premXP': premXP,
                'origCrewXP': origCrewXP,
                'premCrewXP': premCrewXP,
                'damageDealt': vData['damageDealt'],
                'damageAssisted': vData['damageAssistedRadio'] + vData['damageAssistedTrack'],
                'damageAssistedCount': calcDetailsCount(vData['details'], ['damageAssistedRadio', 'damageAssistedTrack']),
                'damageAssistedRadio': vData['damageAssistedRadio'],
                'damageAssistedTrack': vData['damageAssistedTrack'],
                'damageAssistedStun': vData['damageAssistedStun'],
                'damageBlockedByArmor': vData['damageBlockedByArmor'],
                'shots': vData['shots'],
                'hits': vData['directHits'],
                'piercings': vData['piercings'],
                'kills': vData['kills'],
                'spotted': vData['spotted'],
                'stunNum': vData['stunNum'],
                'stunDuration': vData['stunDuration'],
                'critsCount': calcCritsCount(vData['details']),
                'ricochetsCount': calcDetailsSum(vData['details'], 'rickochetsReceived'),
                'nonPenetrationsCount': vData['noDamageDirectHitsReceived']
            }
            self.xvm_data.append(data)
            appendTotalData(xdata_total, data)

        self.xvm_data.insert(0, xdata_total)

def appendTotalData(total, data):
    total['origXP'] += data['origXP']
    total['premXP'] += data['premXP']
    total['origCrewXP'] += data['origCrewXP']
    total['premCrewXP'] += data['premCrewXP']
    total['damageDealt'] += data['damageDealt']
    total['damageAssisted'] += data['damageAssisted']
    total['damageAssistedCount'] += data['damageAssistedCount']
    total['damageAssistedRadio'] += data['damageAssistedRadio']
    total['damageAssistedTrack'] += data['damageAssistedTrack']
    total['damageAssistedStun'] += data['damageAssistedStun']
    total['damageBlockedByArmor'] += data['damageBlockedByArmor']
    total['shots'] += data['shots']
    total['hits'] += data['hits']
    total['piercings'] += data['piercings']
    total['kills'] += data['kills']
    total['spotted'] += data['spotted']
    total['stunNum'] += data['stunNum']
    total['stunDuration'] += data['stunDuration']
    total['critsCount'] += data['critsCount']
    total['ricochetsCount'] += data['ricochetsCount']
    total['nonPenetrationsCount'] += data['nonPenetrationsCount']

_XVM_DATA_STATS_BLOCK = XvmDataBlock(base.DictMeta(), 'xvm_data')

@overrideMethod(composer.StatsComposer, '__init__')
def _StatsComposer__init__(base, self, *args):
    try:
        base(self, *args)
        self._block._meta._meta.update({'xvm_data':{}})
        self._block._meta._unregistered.add('xvm_data')
        self._block.addNextComponent(_XVM_DATA_STATS_BLOCK.clone())
    except:
        err(traceback.format_exc())

#####################################################################
# utility

def calcDetailsSum(details, field):
    try:
        n = 0
        for detail in details.values():
            if field in detail:
                n += int(detail[field])
        return n
    except Exception as ex:
        err(traceback.format_exc())
        return 0

def calcDetailsCount(details, fields):
    try:
        n = 0
        for detail in details.values():
            for field in fields:
                if detail.get(field, 0) > 0:
                    n += 1
                    break;
        return n
    except Exception as ex:
        err(traceback.format_exc())
        return 0

def calcCritsCount(details):
    try:
        n = 0
        for detail in details.values():
            value = detail.get('crits', 0)
            if value > 0:
                for subType, critType in critsParserGenerator(value):
                    n += 1
        return n
    except Exception as ex:
        err(traceback.format_exc())
        return 0
