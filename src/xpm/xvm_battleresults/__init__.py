""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '3.1.0',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.8.1'],
    # optional
}

#####################################################################

import traceback
import BigWorld
from xfw import *
from xvm_main.python.logger import *
import xvm_main.python.config as config

#####################################################################
# Events

def BattleResultsWindow_as_setDataS(base, self, data):
    try:
        from gui.shared import g_itemsCache
        personalCommonData = self._xvm_data['personalCommonData']

        origCrewXP = personalCommonData['tmenXP']
        premCrewXP = personalCommonData['tmenXP']
        if personalCommonData['isPremium']:
            origCrewXP = personalCommonData['tmenXP'] / (personalCommonData['premiumXPFactor10'] / 10.0)
        else:
            premCrewXP = personalCommonData['tmenXP'] * (personalCommonData['premiumXPFactor10'] / 10.0)
        typeCompDescr = personalCommonData['typeCompDescr']
        ownVehicle = g_itemsCache.items.getItemByCD(typeCompDescr)
        if ownVehicle and ownVehicle.isPremium:
            origCrewXP *= 1.5
            premCrewXP *= 1.5

        xdata = {
            '__xvm': True, # XVM data marker
            'origXP': self._xvm_data.get('xpTotal', -1),
            'premXP': self._xvm_data.get('xpPremTotal', -1),
            'shots': personalCommonData['shots'],
            'hits': personalCommonData['directHits'],
            'damageDealt': personalCommonData['damageDealt'],
            'damageAssisted': personalCommonData['damageAssistedRadio'] + personalCommonData['damageAssistedTrack'],
            'damageAssistedCount': getTotalAssistCount(data),
            'damageAssistedRadio': personalCommonData['damageAssistedRadio'],
            'damageAssistedTrack': personalCommonData['damageAssistedTrack'],
            'damageAssistedNames': self._xvm_data.get('damageAssistedNames', None),
            'damageDealtNames': self._xvm_data.get('damageDealtNames', None),
            'armorNames': self._xvm_data.get('armorNames', None),
            'piercings': personalCommonData['piercings'],
            'kills': personalCommonData['kills'],
            'origCrewXP': origCrewXP,
            'premCrewXP': premCrewXP,
            'spotted': personalCommonData['spotted'],
            'damageBlockedByArmor': personalCommonData['damageBlockedByArmor'],
            'armorCount': personalCommonData['noDamageDirectHitsReceived'], #number on picture
            'ricochetsCount': getTotalRicochetsCount(personalCommonData),
            'nonPenetrationsCount': personalCommonData['noDamageDirectHitsReceived'],
            'critsCount': calcDetails(data, 'critsCount'),
            'creditsNoPremTotalStr': data['personal']['creditsData'][0][-1]['col1'],
            'creditsPremTotalStr': data['personal']['creditsData'][0][-1]['col3'],
        }
        
        # Use first vehicle item for transferring XVM data.
        # Cannot add to data object because DAAPIDataClass is not dynamic.
        data['vehicles'].insert(0, xdata)
    except Exception as ex:
        err(traceback.format_exc())
    return base(self, data)

# save personalCommonData: more info there
def _BattleResultsWindow__populateAccounting_event(self, commonData, personalCommonData, personalData, playersData, personalDataOutput):
    if not hasattr(self, '_xvm_data'):
        self._xvm_data = {}
    self._xvm_data['personalCommonData'] = personalCommonData

# get string 'damageAssistedNames'
def _BattleResultsWindow__getAssistInfo(base, self, iInfo, valsStr):
    result = base(self, iInfo, valsStr)
    if not hasattr(self, '_xvm_data'):
        self._xvm_data = {}
    if 'damageAssistedNames' in result:
        self._xvm_data['damageAssistedNames'] = result['damageAssistedNames']
    return result

# get string 'armorNames'
def _BattleResultsWindow__getArmorUsingInfo(base, self, iInfo, valsStr):
    result = base(self, iInfo, valsStr)
    if not hasattr(self, '_xvm_data'):
        self._xvm_data = {}
    if 'armorNames' in result:
        self._xvm_data['armorNames'] = result['armorNames']
    return result

# get string 'getDamageInfo'
def _BattleResultsWindow__getDamageInfo(base, self, iInfo, valsStr):
    result = base(self, iInfo, valsStr)
    if not hasattr(self, '_xvm_data'):
        self._xvm_data = {}
    if 'damageDealtNames' in result:
        self._xvm_data['damageDealtNames'] = result['damageDealtNames']
    return result

# save xp
def _BattleResultsWindow__calculateTotalXp(base, self, pData, aogasFactor, dailyXpFactor, premXpFactor, igrXpFactor, refSystemFactor, isPremium, baseXp, baseOrderXp, baseBoosterXP, eventXP, hasViolation, usePremFactor = False):
    result = base(self, pData, aogasFactor, dailyXpFactor, premXpFactor, igrXpFactor, refSystemFactor, isPremium, baseXp, baseOrderXp, baseBoosterXP, eventXP, hasViolation, usePremFactor)
    if not hasattr(self, '_xvm_data'):
        self._xvm_data = {}
    if not usePremFactor:
        self._xvm_data['xpTotal'] = result
    else:
        self._xvm_data['xpPremTotal'] = result
    return result

# wait for loading xvm_battleresults_ui.swf
def shared_events_showBattleResults(base, arenaUniqueID, dataProvider, cnt=0):
    is_swf = 'swf_file_name' in xfw_mods_info.info.get('xvm_battleresults', {})
    if cnt < 5 and is_swf and not 'xvm_battleresults_ui.swf' in xfw_mods_info.loaded_swfs:
        BigWorld.callback(0, lambda:shared_events_showBattleResults(base, arenaUniqueID, dataProvider, cnt+1))
        return

    base(arenaUniqueID, dataProvider)


#####################################################################
# Utility

def calcDetails(data, field):
    try:
        n = 0
        for detail in data['personal']['details'][0]:
            n += int(detail[field])
        return n
    except Exception as ex:
        err(traceback.format_exc())
        return 0

def getTotalAssistCount(data):
    try:
        n = 0
        for detail in data['personal']['details'][0]:
            if detail['damageAssisted'] > 0:
                n += 1
        return n
    except Exception as ex:
        err(traceback.format_exc())
        return 0

def getTotalRicochetsCount(personalCommonData):
    try:
        n = 0
        for detail in personalCommonData['details'].values():
            n += detail['rickochetsReceived']
        return n
    except Exception as ex:
        err(traceback.format_exc())
        return 0

#####################################################################
# Register events

def _RegisterEvents():
    from gui.Scaleform.daapi.view.BattleResultsWindow import BattleResultsWindow
    OverrideMethod(BattleResultsWindow, 'as_setDataS', BattleResultsWindow_as_setDataS)
    RegisterEvent(BattleResultsWindow, '_BattleResultsWindow__populateAccounting', _BattleResultsWindow__populateAccounting_event)
    OverrideMethod(BattleResultsWindow, '_BattleResultsWindow__getAssistInfo', _BattleResultsWindow__getAssistInfo)
    OverrideMethod(BattleResultsWindow, '_BattleResultsWindow__getArmorUsingInfo', _BattleResultsWindow__getArmorUsingInfo)
    OverrideMethod(BattleResultsWindow, '_BattleResultsWindow__getDamageInfo', _BattleResultsWindow__getDamageInfo)
    OverrideMethod(BattleResultsWindow, '_BattleResultsWindow__calculateTotalXp',  _BattleResultsWindow__calculateTotalXp)

    from gui.shared import event_dispatcher as shared_events
    OverrideMethod(shared_events, '_showBattleResults', shared_events_showBattleResults)

BigWorld.callback(0, _RegisterEvents)
