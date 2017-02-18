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
        isMultiTeamMode = 1 if reusable.common.isMultiTeamMode else 0
        if isMultiTeamMode:
            xdata_multiteam_total = {
                #'origXP': self._xvm_data['xpTotal'][0],
                #'premXP': self._xvm_data['xpPremTotal'][0],
                'origCrewXP': 0,
                'premCrewXP': 0,
                'shots': 0,
                'hits': 0,
                'damageAssistedRadio': 0,
                'damageAssistedTrack': 0,
                'damageBlockedByArmor': 0
            }
        
        for bases, enemies in reusable.getPersonalDetailsIterator(result):
            for info in bases:
                log(info)
                #origCrewXP = personalData['tmenXP']
                #premCrewXP = personalData['tmenXP']
                #if personalData['isPremium']:
                #    origCrewXP = personalData['tmenXP'] / (personalData['premiumXPFactor10'] / 10.0)
                #else:
                #    premCrewXP = personalData['tmenXP'] * (personalData['premiumXPFactor10'] / 10.0)
                #ownVehicle = g_itemsCache.items.getItemByCD(typeCompDescr)
                #if ownVehicle and ownVehicle.isPremium:
                #    origCrewXP = int(origCrewXP * 1.5)
                #    premCrewXP = int(premCrewXP * 1.5)
                #if isMultiTeamMode:
                #    xdata_multiteam_total['origCrewXP'] += origCrewXP
                #    xdata_multiteam_total['premCrewXP'] += premCrewXP
                #    xdata_multiteam_total['shots'] += personalData['shots']
                #    xdata_multiteam_total['hits'] += personalData['directHits']
                #    xdata_multiteam_total['damageAssistedRadio'] += personalData['damageAssistedRadio']
                #    xdata_multiteam_total['damageAssistedTrack'] += personalData['damageAssistedTrack']
                #    xdata_multiteam_total['damageBlockedByArmor'] += personalData['damageBlockedByArmor']
                self.xvm_data.append({
                    'origXP': 0, #self._xvm_data['xpTotal'][index + isMultiTeamMode],
                    'premXP': 0, #self._xvm_data['xpPremTotal'][index + isMultiTeamMode],
                    'origCrewXP': 0, #origCrewXP,
                    'premCrewXP': 0, #premCrewXP,
                    'shots': 0, #personalData['shots'],
                    'hits': 0, #personalData['directHits'],
                    'damageAssistedRadio': 0, #personalData['damageAssistedRadio'],
                    'damageAssistedTrack': 0, #personalData['damageAssistedTrack'],
                    'damageBlockedByArmor': 0 #personalData['damageBlockedByArmor']
                })
        if isMultiTeamMode:
            self.xvm_data.insert(0, xdata_multiteam_total)

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

## save personalCommonData: more info there
#@registerEvent(BattleResultsWindow, '_BattleResultsWindow__populateAccounting')
#def _BattleResultsWindow__populateAccounting(self, commonData, personalCommonData, personalData, *args):
#    self._xvm_data['personalData'] = personalData
#
## save xp
#@overrideMethod(BattleResultsWindow, '_BattleResultsWindow__buildPersonalDataSource')
#def _BattleResultsWindow__buildPersonalDataSource(base, self, personalData, playerAvatarData):
#    result = base(self, personalData, playerAvatarData)
#    for data in result:
#        self._xvm_data['xpTotal'].append(data[1]['xpWithoutPremTotal'])
#        self._xvm_data['xpPremTotal'].append(data[1]['xpWithPremTotal'])
#    return result
