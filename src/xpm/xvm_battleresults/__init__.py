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
from gui.shared import g_itemsCache, REQ_CRITERIA
    
#####################################################################
# Events

def BattleResultsWindow_as_setDataS(base, self, data):
    try:
        ownResult = findOwnResult(data)
        (hits, pierced) = ownResult['statValues'][0][1]['value'].split('/')
        ownVehicleName = ownResult['tankIcon'].split('/')[-1].split('.')[0].replace('-', ':')
        ownVehicle = g_itemsCache.items.getVehicles(REQ_CRITERIA.VEHICLE.SPECIFIC_BY_NAME(ownVehicleName)).values()[0]
        origXP = int(data['personal']['xpData'][0][-1]['col1'].split(' ')[0])
        premXP = int(data['personal']['xpData'][0][-1]['col3'].split(' ')[0])
        origCrewXP = origXP
        premCrewXP = premXP
        if ownVehicle.isPremium:
            origCrewXP *= 1.5
            premCrewXP *= 1.5

        xdata = {
            '__xvm': True, # XVM data marker
            'typeCompDescr': 0, # needed?
            'origXP': origXP,
            'premXP': premXP,
            'shots': int(ownResult['statValues'][0][0]['value']),
            'hits': int(hits),
            'damageDealt': ownResult['damageDealt'],
            'damageAssisted': ownResult['damageAssisted'][0],
            'damageAssistedCount': getTotalAssistCount(data),
            'damageAssistedRadio': 0, # needed?
            'damageAssistedTrack': 0, # needed?
            'damageAssistedNames': 0, # needed?
            'piercings': int(pierced),
            'kills': ownResult['kills'],
            'origCrewXP': origCrewXP,
            'premCrewXP': premCrewXP,
            'spotted': calcDetails(data, 'spotted'),
            #'armorCount': calcDetails(data, 'armorTotalItems'), #blocked damage count
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

def findOwnResult(data):
    try:
        for result in data['team1']:
            if result['isSelf']:
                return result
        for result in data['team2']: # might happen player in team2?
            if result['isSelf']:
                return result
    except Exception as ex:
        err(traceback.format_exc())

#####################################################################
# Register events

def _RegisterEvents():
    from gui.Scaleform.daapi.view.BattleResultsWindow import BattleResultsWindow
    OverrideMethod(BattleResultsWindow, 'as_setDataS', BattleResultsWindow_as_setDataS)

BigWorld.callback(0, _RegisterEvents)
