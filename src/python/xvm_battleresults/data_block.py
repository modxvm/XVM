"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2016-2022 XVM Contributors
"""

#
# Imports
#

# Cpython
import logging

# BigWorld
from helpers import dependency
from skeletons.gui.shared import IItemsCache
from gui.battle_results.components import base
from gui.shared.crits_mask_parser import critsParserGenerator



#
# Helpers
#

def calcDetailsCount(details, fields):
    n = 0
    
    try:
        if details is not None:
            for detail in details.values():
                for field in fields:
                    if detail.get(field, 0) > 0:
                        n += 1
                        break
    except Exception:
        logging.getLogger('XVM/BattleResults').exception('calcDetailsCount')
        
    return n


def calcCritsCount(details):
    n = 0
    
    try:
        if details is not None:
            for detail in details.values():
                value = detail.get('crits', 0)
                if value > 0:
                    for subType, critType in critsParserGenerator(value):
                        n += 1
    except Exception:
        logging.getLogger('XVM/BattleResults').exception('calcCritsCount')

    return n


def calcDetailsSum(details, field):
    n = 0
            
    try:
        if details is not None:
            for detail in details.values():
                if field in detail:
                    n += int(detail[field])
    except Exception:
        logging.getLogger('XVM/BattleResults').exception('calcDetailsSum')

    return n



#
# Data Block
#

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

        for typeCompDescr, vData in reusable.personal.getVehicleCDsIterator(result):
            #log(vData)
            #log from 1.5.0.0: https://koreanrandom.com/forum/topic/49651-

            #TODO 1.5: add support for premiumPlus and premiumVip
            origXP = vData['xp']
            premXP = vData['xp']

            origCrewXP = 0
            premCrewXP = 0
            if 'tmenXP' in vData:
                origCrewXP = vData['tmenXP']
                premCrewXP = vData['tmenXP']
        
            if 'isPremium' in vData:
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

            details = None
            if 'details' in vData:
                details = vData['details']

            data = {
                'origXP': origXP,
                'premXP': premXP,
                'origCrewXP': origCrewXP,
                'premCrewXP': premCrewXP,
                'damageDealt': vData['damageDealt'],
                'damageAssisted': vData['damageAssistedRadio'] + vData['damageAssistedTrack'],
                'damageAssistedCount': calcDetailsCount(details, ['damageAssistedRadio', 'damageAssistedTrack']),
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
                'critsCount': calcCritsCount(details),
                'ricochetsCount': calcDetailsSum(details, 'rickochetsReceived'),
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
