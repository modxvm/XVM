""" XVM (c) www.modxvm.com 2013-2015 """

import config

# PUBLIC

def getClanInfo(clanAbbrev):
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

def clear():
    global _clansInfo
    _clansInfo = None


def update(data={}):
    if data is None:
        data = {}
    clans = {
        'top': data.get('topClans', {}),
        'persist': data.get('persistClans', {})}

    # DEBUG
    #log(clans)
    # clans['persist']['FOREX'] = {"rank":"0","cid":"38503","emblem":"http://stat.modxvm.com/emblems/persist/{size}/38503.png"}
    # /DEBUG

_clansInfo = None
