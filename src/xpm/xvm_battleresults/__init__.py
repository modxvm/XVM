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
import simplejson

import BigWorld
from gui.shared import event_dispatcher, g_itemsCache
from gui.Scaleform.daapi.view.battle_results_window import BattleResultsWindow
from gui.battle_results import composer
from gui.battle_results.components import base
from gui.battle_results.settings import BATTLE_RESULTS_RECORD

from xfw import *

from xvm_main.python.logger import *
import xvm_main.python.config as config


# wait for loading xvm_battleresults_ui.swf
@overrideMethod(event_dispatcher, 'showBattleResultsWindow')
def event_dispatcher_showBattleResultsWindow_proxy(base, arenaUniqueID):
    event_dispatcher_showBattleResultsWindow(base, arenaUniqueID)

def event_dispatcher_showBattleResultsWindow(base, arenaUniqueID, cnt=0):
    is_swf = 'swf_file_name' in xfw_mods_info.info.get('xvm_battleresults', {})
    if cnt < 2 or (cnt < 5 and is_swf and not 'xvm_battleresults_ui.swf' in xfw_mods_info.loaded_swfs):
        BigWorld.callback(0, lambda:event_dispatcher_showBattleResultsWindow(base, arenaUniqueID, cnt+1))
    else:
        base(arenaUniqueID)

@overrideMethod(BattleResultsWindow, 'as_setDataS')
def BattleResultsWindow_as_setDataS(base, self, data):
    try:
        # Use data['common']['regionNameStr'] value to transfer XVM data.
        # Cannot add in data object because DAAPIDataClass is not dynamic.
        #log(data['xvm_data'])
        data['xvm_data']['regionNameStr'] = data['common']['regionNameStr']
        data['common']['regionNameStr'] = simplejson.dumps(data['xvm_data'])
        del data['xvm_data']
    except Exception as ex:
        err(traceback.format_exc())
    return base(self, data)


#####################################################################
# collect data for XVM

class XvmDataBlock(base.StatsBlock):
    __slots__ = ('xvm_data')

    def __init__(self, meta = None, field = '', *path):
        super(XvmDataBlock, self).__init__(meta, field, *path)
        self.xvm_data = []

    def getVO(self):
        return {
            '__xvm': True, # XVM data marker
            'regionNameStr':'',
            'data': self.xvm_data}

    def setRecord(self, result, reusable):
        xdata_total = {
            'origXP': 0, #self._xvm_data['xpTotal'][0],
            'premXP': 0, #self._xvm_data['xpPremTotal'][0],
            'origCrewXP': 0,
            'premCrewXP': 0,
            'damageDealt': 0,
            'damageAssisted': 0,
            'damageAssistedCount': 0,
            'damageAssistedRadio': 0,
            'damageAssistedTrack': 0,
            'damageBlockedByArmor': 0,
            'shots': 0,
            'hits': 0,
            'piercings': 0,
            'kills': 0,
            'spotted': 0,
            'critsCount': 0,
            'ricochetsCount': 0,
            'nonPenetrationsCount': 0,
            'creditsNoPremTotalStr': 0, #data['personal']['creditsData'][0][-1]['col1'],
            'creditsPremTotalStr': 0} #data['personal']['creditsData'][0][-1]['col3']}

        for typeCompDescr, vData in reusable.personal.getVehicleCDsIterator(result):
            #log(vData)
            origCrewXP = vData['tmenXP']
            premCrewXP = vData['tmenXP']
            if vData['isPremium']:
                origCrewXP = vData['tmenXP'] / (vData['premiumXPFactor10'] / 10.0)
            else:
                premCrewXP = vData['tmenXP'] * (vData['premiumXPFactor10'] / 10.0)
            ownVehicle = g_itemsCache.items.getItemByCD(typeCompDescr)
            if ownVehicle and ownVehicle.isPremium:
                origCrewXP = int(origCrewXP * 1.5)
                premCrewXP = int(premCrewXP * 1.5)

            data = {
                'origXP': 0, #self._xvm_data['xpTotal'][index + 1],
                'premXP': 0, #self._xvm_data['xpPremTotal'][index + 1],
                'origCrewXP': origCrewXP,
                'premCrewXP': premCrewXP,
                'damageDealt': vData['damageDealt'],
                'damageAssisted': vData['damageAssistedRadio'] + vData['damageAssistedTrack'],
                'damageAssistedCount': calcDetailsCount(vData['details'], ['damageAssistedRadio', 'damageAssistedTrack']),
                'damageAssistedRadio': vData['damageAssistedRadio'],
                'damageAssistedTrack': vData['damageAssistedTrack'],
                'damageBlockedByArmor': vData['damageBlockedByArmor'],
                'shots': vData['shots'],
                'hits': vData['directHits'],
                'piercings': vData['piercings'],
                'kills': vData['kills'],
                'spotted': vData['spotted'],
                'critsCount': calcDetailsSum(vData['details'], 'crits'),
                'ricochetsCount': calcDetailsSum(vData['details'], 'rickochetsReceived'),
                'nonPenetrationsCount': vData['noDamageDirectHitsReceived'],
                'creditsNoPremTotalStr': '', #data['personal']['creditsData'][0][-1]['col1'],
                'creditsPremTotalStr': '', #data['personal']['creditsData'][0][-1]['col3']}
            }
            self.xvm_data.append(data)
            appendTotalData(xdata_total, data)

        self.xvm_data.insert(0, xdata_total)

def appendTotalData(total, data):
    total['origCrewXP'] += data['origCrewXP']
    total['premCrewXP'] += data['premCrewXP']
    total['damageDealt'] += data['damageDealt']
    total['damageAssisted'] += data['damageAssisted']
    total['damageAssistedCount'] += data['damageAssistedCount']
    total['damageAssistedRadio'] += data['damageAssistedRadio']
    total['damageAssistedTrack'] += data['damageAssistedTrack']
    total['damageBlockedByArmor'] += data['damageBlockedByArmor']
    total['shots'] += data['shots']
    total['hits'] += data['hits']
    total['piercings'] += data['piercings']
    total['kills'] += data['kills']
    total['spotted'] += data['spotted']
    total['critsCount'] += data['critsCount']
    total['ricochetsCount'] += data['ricochetsCount']
    total['nonPenetrationsCount'] += data['nonPenetrationsCount']

_XVM_DATA_STATS_BLOCK = XvmDataBlock(base.DictMeta(), 'xvm_data', BATTLE_RESULTS_RECORD.PERSONAL)

@overrideMethod(composer.StatsComposer, '__init__')
def _StatsComposer__init__(base, self, *args):
    try:
        base(self, *args)
        self._block._meta._meta.update({'xvm_data':{}})
        self._block._meta._unregistered.add('xvm_data')
        self._block.addNextComponent(_XVM_DATA_STATS_BLOCK.clone())
    except:
        err(traceback.format_exc())

## save xp
#@overrideMethod(BattleResultsWindow, '_BattleResultsWindow__buildPersonalDataSource')
#def _BattleResultsWindow__buildPersonalDataSource(base, self, personalData, playerAvatarData):
#    result = base(self, personalData, playerAvatarData)
#    for data in result:
#        self._xvm_data['xpTotal'].append(data[1]['xpWithoutPremTotal'])
#        self._xvm_data['xpPremTotal'].append(data[1]['xpWithPremTotal'])
#    return result

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
                log(detail[field])
                if field in detail and detail[field] > 0:
                    n += 1
                    break;
        return n
    except Exception as ex:
        err(traceback.format_exc())
        return 0
