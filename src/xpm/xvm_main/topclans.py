""" XVM (c) www.modxvm.com 2013-2017 """

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
        if not (0 < topWGM['rank'] <= config.networkServicesSettings.topClansCount):
            topWGM = None
    if topWSH is not None:
        if not (0 < topWSH['rank'] <= config.networkServicesSettings.topClansCount):
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

    # DEBUG
    #log(_clansInfo)
    #_clansInfo.persist['FOREX'] = {"rank":0,"clan_id":38503,"emblem":"http://stat.modxvm.com/emblems/persist/{size}/38503.png"}
    #/DEBUG

class _ClansInfo(object):
    __slots__ = ('_persist', '_topWGM', '_topWSH')

    def __init__(self, data):
        self._persist = data.get('persistClans', {})
        self._topWGM = data.get('topClansWGM', {})
        self._topWSH = data.get('topClansWSH', {})

        # fix data
        # TODO: rename cid to clan_id in XVM API
        # TODO: make rank as int and clan_id as long in XVM API
        def _fix(d):
            for k, v in d.items():
                v['rank'] = int(v['rank'])
                v['clan_id'] = long(v['cid'])
                del v['cid']
        _fix(self._persist)
        _fix(self._topWGM)
        _fix(self._topWSH)

    def getPersistClanInfo(self, clanAbbrev):
        return self._persist.get(clanAbbrev, None)

    def getTopWGMClanInfo(self, clanAbbrev):
        return self._topWGM.get(clanAbbrev, None)

    def getTopWSHClanInfo(self, clanAbbrev):
        return self._topWSH.get(clanAbbrev, None)

_clansInfo = None
