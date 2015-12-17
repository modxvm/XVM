""" XVM (c) www.modxvm.com 2013-2015 """

# PUBLIC

def getToken():
    (data, errStr) = _exec('getToken/{token}/{id}')
    return (data, errStr)

def getVersion():
    (data, errStr) = _exec('getVersion/{token}/{id}')
    return data

def getVersionWithLimit(limit=50):
    (data, errStr) = _exec('getVersionWithLimit/{token}/{id}/{limit}', params={'limit':limit})
    return data

def getStats(request):
    (data, errStr) = _exec('getStats/{token}/{request}', params={'request':request})
    return data

def getStatsReplay(request):
    (data, errStr) = _exec('getStatsReplay/{token}/{request}', params={'request':request})
    return data

def getStatsById(id):
    (data, errStr) = _exec('getStatsById/{token}/{id}', params={'id':id})
    return data

def getStatsByNick(region, nick):
    (data, errStr) = _exec('getStatsByNick/{token}/{region}/{nick}', params={'region':region,'nick':nick})
    return data

def getOnlineUsersCount():
    (data, errStr) = _exec('getOnlineUsersCount/{id}', showLog=False)
    return data


# PRIVATE

from random import randint

from xfw import *
import simplejson

from constants import *
from logger import *
from loadurl import loadUrl
import config
import userprefs

def _exec(req, data=None, showLog=True, api=XVM.API_VERSION, params={}):
    try:
        url = XVM.SERVERS[randint(0, len(XVM.SERVERS) - 1)]
        url = url.format(API=api, REQ=req)
        for k, v in params.iteritems():
            url = url.replace('{'+k+'}', '' if v is None else str(v))

        playerId = getCurrentPlayerId() if not isReplay() else userprefs.get('tokens.lastPlayerId')
        if playerId is None:
            playerId = 0

        token = config.token.token
        if token is None:
            token = ''

        url = url.format(id=playerId, token=token)

        (response, duration, errStr) = loadUrl(url, None, data)

        return (None if response is None else simplejson.loads(response), errStr)
    except Exception as ex:
        err(traceback.format_exc())
        return None
