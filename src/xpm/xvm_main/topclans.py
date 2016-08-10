""" XVM (c) www.modxvm.com 2013-2016 """

import config
from logger import *

# PUBLIC

def getClanInfo(clanAbbrev):
    def _get(clanAbbrev):
        global _clansInfo
        if not _clansInfo:
            return None
        top = _clansInfo['top'].get(clanAbbrev, None)
        if top:
            rank = int(top.get('rank', None))
            if rank:
                if 0 < rank <= config.networkServicesSettings.topClansCount:
                    return top
        return _clansInfo['persist'].get(clanAbbrev, None)

    res = _get(clanAbbrev)
    if res:
        res['rank'] = int(res['rank'])
        res['cid'] = int(res['cid'])
    return res

def clear():
    global _clansInfo
    _clansInfo = None

def update(data={}):
    if data is None:
        data = {}
    global _clansInfo
    _clansInfo = {
        'top': data.get('topClans', {}),
        'persist': data.get('persistClans', {})}

    # DEBUG
    #log(clans)
    # clans['persist']['FOREX'] = {"rank":0,"cid":38503,"emblem":"http://stat.modxvm.com/emblems/persist/{size}/38503.png"}
    # /DEBUG

_clansInfo = None
