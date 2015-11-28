""" XVM (c) www.modxvm.com 2013-2015 """

# PUBLIC

def getToken():
    return _exec('getToken/{token}/{id}')

def getVersion():
    return _exec('getVersion/{token}/{id}')

def getVersionWithLimit(limit=50):
    return _exec('getVersionWithLimit/{token}/{id}/{limit}', params={'limit':limit})

def getStats(request):
    return _exec('getStats/{token}/{request}', params={'request':request})

def getStatsReplay(request):
    return _exec('getStatsReplay/{token}/{request}', params={'request':request})

def getStatsById(id):
    return _exec('getStatsById/{token}/{id}', params={'id':id})

def getStatsByNick(region, nick):
    return _exec('getStatsByNick/{token}/{region}/{nick}', params={'region':region,'nick':nick})

def getOnlineUsersCount():
    return _exec('getOnlineUsersCount/{id}', showLog=False)


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

    return None if response is None else simplejson.loads(response)
