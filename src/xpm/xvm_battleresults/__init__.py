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
from xfw import *
from xvm_main.python.logger import *
import xvm_main.python.config as config

#####################################################################
# Events

def init(self):
    if not hasattr(self, '_xvm_data'):
        self._xvm_data = {}
    self._xvm_data['xpTotal'] = []
    self._xvm_data['xpPremTotal'] = []
    self._xvm_data['personalData'] = None

def BattleResultsWindow_as_setDataS(base, self, data):
    try:
        from gui.shared import g_itemsCache
        xdataList = {
            '__xvm': True, # XVM data marker
            'damageAssistedNames': self._xvm_data.get('damageAssistedNames', None),
            'damageDealtNames': self._xvm_data.get('damageDealtNames', None),
            'armorNames': self._xvm_data.get('armorNames', None),
            'data': [],
        }
        isFallout = 0 if data['common']['falloutMode'] is None else 1
        if isFallout:
            xdata_fallout_total = {
                'origXP': self._xvm_data['xpTotal'][0],
                'premXP': self._xvm_data['xpPremTotal'][0],
                'shots': 0,
                'hits': 0,
                'damageDealt': 0,
                'damageAssisted': 0,
                'damageAssistedCount': getTotalAssistCount(data['personal']['details'][0]),
                'damageAssistedRadio': 0,
                'damageAssistedTrack': 0,
                'piercings': 0,
                'kills': 0,
                'origCrewXP': 0,
                'premCrewXP': 0,
                'spotted': 0,
                'damageBlockedByArmor': 0,
                'armorCount': 0, #number on picture
                'ricochetsCount': 0,
                'nonPenetrationsCount': 0,
                'critsCount': calcDetails(data['personal']['details'][0], 'critsCount'),
                'creditsNoPremTotalStr': data['personal']['creditsData'][0][-1]['col1'],
                'creditsPremTotalStr': data['personal']['creditsData'][0][-1]['col3'],
            }

        for index, (typeCompDescr, personalData) in enumerate(self._xvm_data['personalData']):
            origCrewXP = personalData['tmenXP']
            premCrewXP = personalData['tmenXP']
            if personalData['isPremium']:
                origCrewXP = personalData['tmenXP'] / (personalData['premiumXPFactor10'] / 10.0)
            else:
                premCrewXP = personalData['tmenXP'] * (personalData['premiumXPFactor10'] / 10.0)
            ownVehicle = g_itemsCache.items.getItemByCD(typeCompDescr)
            if ownVehicle and ownVehicle.isPremium:
                origCrewXP = int(origCrewXP * 1.5)
                premCrewXP = int(premCrewXP * 1.5)
            
            if isFallout:
                xdata_fallout_total['shots'] += personalData['shots']
                xdata_fallout_total['hits'] += personalData['directHits']
                xdata_fallout_total['damageDealt'] += personalData['damageDealt']
                xdata_fallout_total['damageAssisted'] += (personalData['damageAssistedRadio'] + personalData['damageAssistedTrack'])
                xdata_fallout_total['damageAssistedRadio'] += personalData['damageAssistedRadio']
                xdata_fallout_total['damageAssistedTrack'] += personalData['damageAssistedTrack']
                xdata_fallout_total['piercings'] += personalData['piercings']
                xdata_fallout_total['kills'] += personalData['kills']
                xdata_fallout_total['origCrewXP'] += origCrewXP
                xdata_fallout_total['premCrewXP'] += premCrewXP
                xdata_fallout_total['spotted'] += personalData['spotted']
                xdata_fallout_total['damageBlockedByArmor'] += personalData['damageBlockedByArmor']
                xdata_fallout_total['armorCount'] += personalData['noDamageDirectHitsReceived'] #number on picture
                xdata_fallout_total['ricochetsCount'] += getTotalRicochetsCount(personalData)
                xdata_fallout_total['nonPenetrationsCount'] += personalData['noDamageDirectHitsReceived']
            xdataList['data'].append({
                'origXP': self._xvm_data['xpTotal'][index + isFallout],
                'premXP': self._xvm_data['xpPremTotal'][index + isFallout],
                'shots': personalData['shots'],
                'hits': personalData['directHits'],
                'damageDealt': personalData['damageDealt'],
                'damageAssisted': personalData['damageAssistedRadio'] + personalData['damageAssistedTrack'],
                'damageAssistedCount': getTotalAssistCount(data['personal']['details'][index + isFallout]),
                'damageAssistedRadio': personalData['damageAssistedRadio'],
                'damageAssistedTrack': personalData['damageAssistedTrack'],
                'piercings': personalData['piercings'],
                'kills': personalData['kills'],
                'origCrewXP': origCrewXP,
                'premCrewXP': premCrewXP,
                'spotted': personalData['spotted'],
                'damageBlockedByArmor': personalData['damageBlockedByArmor'],
                'armorCount': personalData['noDamageDirectHitsReceived'], #number on picture
                'ricochetsCount': getTotalRicochetsCount(personalData),
                'nonPenetrationsCount': personalData['noDamageDirectHitsReceived'],
                'critsCount': calcDetails(data['personal']['details'][index + isFallout], 'critsCount'),
                'creditsNoPremTotalStr': data['personal']['creditsData'][index + isFallout][-1]['col1'],
                'creditsPremTotalStr': data['personal']['creditsData'][index + isFallout][-1]['col3'],
            })
        if isFallout:
            xdataList['data'].insert(0, xdata_fallout_total)
        # Use first vehicle item for transferring XVM data.
        # Cannot add to data object because DAAPIDataClass is not dynamic.
        data['vehicles'].insert(0, xdataList)
    except Exception as ex:
        err(traceback.format_exc())
    return base(self, data)

# save personalCommonData: more info there
def _BattleResultsWindow__populateAccounting_event(self, commonData, personalCommonData, personalData, playersData, personalDataOutput, isFallout):
    self._xvm_data['personalData'] = personalData

# get string 'damageAssistedNames'
def _BattleResultsWindow__getAssistInfo(base, self, iInfo, valsStr):
    result = base(self, iInfo, valsStr)
    if 'damageAssistedNames' in result:
        self._xvm_data['damageAssistedNames'] = result['damageAssistedNames']
    return result

# get string 'armorNames'
def _BattleResultsWindow__getArmorUsingInfo(base, self, iInfo, valsStr):
    result = base(self, iInfo, valsStr)
    if 'armorNames' in result:
        self._xvm_data['armorNames'] = result['armorNames']
    return result

# get string 'getDamageInfo'
def _BattleResultsWindow__getDamageInfo(base, self, iInfo, valsStr):
    result = base(self, iInfo, valsStr)
    if 'damageDealtNames' in result:
        self._xvm_data['damageDealtNames'] = result['damageDealtNames']
    return result

# save xp
def _BattleResultsWindow__calculateTotalXp(base, self, pData, aogasFactor, dailyXpFactor, premXpFactor, igrXpFactor, refSystemFactor, isPremium, baseXp, baseOrderXp, baseBoosterXP, eventXP, hasViolation, usePremFactor = False):
    result = base(self, pData, aogasFactor, dailyXpFactor, premXpFactor, igrXpFactor, refSystemFactor, isPremium, baseXp, baseOrderXp, baseBoosterXP, eventXP, hasViolation, usePremFactor)
    if not usePremFactor:
        self._xvm_data['xpTotal'].append(result)
    else:
        self._xvm_data['xpPremTotal'].append(result)
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

def calcDetails(personal_details_list, field):
    try:
        n = 0
        for detail in personal_details_list:
            if field in detail:
                n += int(detail[field])
        return n
    except Exception as ex:
        err(traceback.format_exc())
        return 0

def getTotalAssistCount(personal_details_list):
    try:
        n = 0
        for detail in personal_details_list:
            if 'damageAssisted' in detail and detail['damageAssisted'] > 0:
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
    RegisterEvent(BattleResultsWindow, '_populate', init, True)
    RegisterEvent(BattleResultsWindow, '_BattleResultsWindow__populateAccounting', _BattleResultsWindow__populateAccounting_event)
    OverrideMethod(BattleResultsWindow, '_BattleResultsWindow__getAssistInfo', _BattleResultsWindow__getAssistInfo)
    OverrideMethod(BattleResultsWindow, '_BattleResultsWindow__getArmorUsingInfo', _BattleResultsWindow__getArmorUsingInfo)
    OverrideMethod(BattleResultsWindow, '_BattleResultsWindow__getDamageInfo', _BattleResultsWindow__getDamageInfo)
    OverrideMethod(BattleResultsWindow, '_BattleResultsWindow__calculateTotalXp',  _BattleResultsWindow__calculateTotalXp)

    from gui.shared import event_dispatcher as shared_events
    OverrideMethod(shared_events, '_showBattleResults', shared_events_showBattleResults)

BigWorld.callback(0, _RegisterEvents)
