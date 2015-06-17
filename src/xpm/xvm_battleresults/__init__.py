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
# Globals
g_personalCommonData = None
g_damageAssistedNames = None
#g_data = None 
#g_xdata = None

#####################################################################
# Events

def BattleResultsWindow_as_setDataS(base, self, data):
    try:
        from gui.shared import g_itemsCache
        #global g_data, g_xdata
        #g_data = data
        origXP = int(data['personal']['xpData'][0][-1]['col1'].split(' ')[0])
        premXP = int(data['personal']['xpData'][0][-1]['col3'].split(' ')[0])

        origCrewXP = g_personalCommonData['tmenXP']
        premCrewXP = g_personalCommonData['tmenXP']
        if g_personalCommonData['isPremium']:
            origCrewXP = g_personalCommonData['tmenXP'] / (g_personalCommonData['premiumXPFactor10'] / 10.0)
        else:
            premCrewXP = g_personalCommonData['tmenXP'] * (g_personalCommonData['premiumXPFactor10'] / 10.0)
        typeCompDescr = g_personalCommonData['typeCompDescr']
        ownVehicle = g_itemsCache.items.getItemByCD(typeCompDescr)
        if ownVehicle and ownVehicle.isPremium:
            origCrewXP *= 1.5
            premCrewXP *= 1.5

        xdata = {
            '__xvm': True, # XVM data marker
            'typeCompDescr': typeCompDescr, # not used
            'origXP': origXP,
            'premXP': premXP,
            'shots': g_personalCommonData['shots'],
            'hits': g_personalCommonData['directHits'],
            'damageDealt': g_personalCommonData['damageDealt'],
            'damageAssisted': g_personalCommonData['damageAssistedRadio'] + g_personalCommonData['damageAssistedTrack'],
            'damageAssistedCount': getTotalAssistCount(data),
            'damageAssistedRadio': g_personalCommonData['damageAssistedRadio'],
            'damageAssistedTrack': g_personalCommonData['damageAssistedTrack'],
            'damageAssistedNames': g_damageAssistedNames,
            'piercings': g_personalCommonData['piercings'],
            'kills': g_personalCommonData['kills'],
            'origCrewXP': origCrewXP,
            'premCrewXP': premCrewXP,
            'spotted': g_personalCommonData['spotted'],
            #'armorCount': calcDetails(data, 'armorTotalItems'), #blocked damage count
            'critsCount': calcDetails(data, 'critsCount'),
            'creditsNoPremTotalStr': data['personal']['creditsData'][0][-1]['col1'],
            'creditsPremTotalStr': data['personal']['creditsData'][0][-1]['col3'],
        }
        #g_xdata = xdata
        # Use first vehicle item for transferring XVM data.
        # Cannot add to data object because DAAPIDataClass is not dynamic.
        data['vehicles'].insert(0, xdata)
    except Exception as ex:
        err(traceback.format_exc())
    return base(self, data)

# save personalCommonData: more info there
def _BattleResultsWindow__populateAccounting_event(self, commonData, personalCommonData, personalData, playersData, personalDataOutput):
    global g_personalCommonData
    g_personalCommonData = personalCommonData

# get string of assisting
def _BattleResultsWindow__getAssistInfo(base, self, iInfo, valsStr):
    result = base(self, iInfo, valsStr)
    global g_damageAssistedNames
    if 'damageAssistedNames' in result and not g_damageAssistedNames:
        g_damageAssistedNames = result['damageAssistedNames']
    return result
    

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

#####################################################################
# Register events

def _RegisterEvents():
    from gui.Scaleform.daapi.view.BattleResultsWindow import BattleResultsWindow
    OverrideMethod(BattleResultsWindow, 'as_setDataS', BattleResultsWindow_as_setDataS)
    RegisterEvent(BattleResultsWindow, '_BattleResultsWindow__populateAccounting', _BattleResultsWindow__populateAccounting_event)
    OverrideMethod(BattleResultsWindow, '_BattleResultsWindow__getAssistInfo', _BattleResultsWindow__getAssistInfo)

BigWorld.callback(0, _RegisterEvents)
