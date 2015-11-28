""" XVM (c) www.modxvm.com 2013-2015 """

# PUBLIC

def getToken():
    _exec('GET', 'getToken/{token}/{id}')

def getVersion():
    _exec('GET', 'getVersion/{token}/{id}')

def getVersionWithLimit(limit=50):
    _exec('GET', 'getVersionWithLimit/{token}/{id}/{limit}', params={'limit':limit})

def getStats(request):
    _exec('GET', 'getStats/{token}/{request}', params={'request':request})

def getStatsReplay(request):
    _exec('GET', 'getStatsReplay/{token}/{request}', params={'request':request})

def getStatsById(id):
    _exec('GET', 'getStatsById/{token}/{id}', params={'id':id})

def getStatsByNick(region, nick):
    _exec('GET', 'getStatsByNick/{token}/{region}/{nick}', params={'region':region,'nick':nick})

def getOnlineUsersCount():
    _exec('GET', 'getOnlineUsersCount/{id}', showLog=False)


# PRIVATE

from random import randint

from xfw import *
import simplejson

from constants import *
from logger import *
from loadurl import loadUrl

def _exec(method, req, data=None, showLog=True, api=XVM.API_VERSION, params={}):
    url = XVM.SERVERS[randint(0, len(XVM.SERVERS) - 1)]
    url = url.format(API=api, REQ=req)
    for k, v in params.iteritems():
        url = url.replace('{'+k+'}', '' if v is None else str(v))

    playerId = getCurrentPlayerId() if not isReplay() else userprefs.get('tokens.lastPlayerId')
    if playerId is None:
        playerId = 0

    token=None # TODO
    
    url = url.format(id=playerId, token=token)

    (response, duration, errStr) = loadUrl(url, None, data)

    return None if response is None else simplejson.loads(response)
