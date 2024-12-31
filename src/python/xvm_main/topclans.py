"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

import config
from logger import *

# PUBLIC

def getClanInfo(clanAbbrev):
    global _clansInfo
    if _clansInfo is None:
        return None
    rankWGM = None
    rankWSH = None
    topWGM = _clansInfo.getTopWGMClanInfo(clanAbbrev)
    if topWGM is not None:
        if not (0 < topWGM['rank'] <= config.networkServicesSettings.topClansCountWgm):
            topWGM = None
    topWSH = _clansInfo.getTopWSHClanInfo(clanAbbrev)
    if topWSH is not None:
        if not (0 < topWSH['rank'] <= config.networkServicesSettings.topClansCountWsh):
            topWSH = None
    # get minimal rank
    if topWGM is None and topWSH is None:
        return _clansInfo.getPersistClanInfo(clanAbbrev)
    else:
        if topWGM is None:
            return topWSH
        elif topWSH is None:
            return topWGM
        else:
            return min(topWGM, topWSH, key=lambda x: x['rank'])

def clear():
    global _clansInfo
    _clansInfo = None

def update(data):
    if data is None:
        data = {}

    global _clansInfo
    _clansInfo = _ClansInfo(data)

class _ClansInfo(object):
    __slots__ = ('_persist', '_topWGM', '_topWSH')

    def __init__(self, data):
        # fix data
        # TODO: rename topClans to topClansWGM in XVM API
        if 'topClansWGM' not in data and 'topClans' in data:
            data['topClansWGM'] = data['topClans']
            del data['topClans']

        self._persist = data.get('persistClans', {})
        self._topWGM = data.get('topClansWGM', {})
        self._topWSH = data.get('topClansWSH', {})

        # DEBUG
        #log(_clansInfo)
        #self._topWGM['KTFI'] = {"rank":9,"clan_id":38503,"emblem":"http://static.modxvm.com/emblems/persist/{size}/38503.png"}
        #self._topWSH['KTFI'] = {"rank":4,"clan_id":38503,"emblem":"http://static.modxvm.com/emblems/persist/{size}/38503.png"}
        #self._persist['KTFI'] = {"rank":0,"clan_id":38503,"emblem":"http://static.modxvm.com/emblems/persist/{size}/38503.png"}
        #/DEBUG

    def getPersistClanInfo(self, clanAbbrev):
        return self._persist.get(clanAbbrev, None)

    def getTopWGMClanInfo(self, clanAbbrev):
        return self._topWGM.get(clanAbbrev, None)

    def getTopWSHClanInfo(self, clanAbbrev):
        return self._topWSH.get(clanAbbrev, None)

_clansInfo = None
