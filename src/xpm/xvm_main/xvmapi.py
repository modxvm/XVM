""" XVM (c) https://modxvm.com 2013-2020 """

import simplejson
from consts import *
from xfw import getCurrentBattleInfo, urlSafeBase64Encode
import urllib

# PUBLIC

def getToken():
    (data, errStr) = _exec('getToken/{token}/{id}')
    return (data, errStr)

def getVersion(wgmLimit=50, wshLimit=50):
    (data, errStr) = _exec('getVersion/{id}/{ver}/{wgm}/{wsh}',
        params={'ver': urllib.quote('{0}#{1}'.format(XVM.XVM_VERSION, XVM.XVM_REVISION)), 'wgm': wgmLimit, 'wsh': wshLimit})
    return data

def getServerMessage():
    (data, errStr) = _exec('getServerMessage/{token}')
    return data

def getStats(request):
    (data, errStr) = _exec('getStats/{token}/{request}?battleInfo={battleInfo}', params={
        'request': request,
        'battleInfo': urlSafeBase64Encode(simplejson.dumps(getCurrentBattleInfo(), separators=(',', ':'), sort_keys=True))})
    return data

def getStatsReplay(request):
    (data, errStr) = _exec('getStatsReplay/{token}/{request}', params={'request': request})
    return data

def getStatsBattleResults(request, battleinfo):
    (data, errStr) = _exec('getStatsBattleResults/{token}/{request}?battleInfo={battleInfo}', params={
        'request': request,
        'battleInfo': urlSafeBase64Encode(simplejson.dumps(battleinfo, separators=(',', ':'), sort_keys=True))})
    return data

def getStatsByNick(region, nick):
    (data, errStr) = _exec('getStatsByNick/{token}/{region}/{nick}', params={'region': region,'nick': nick})
    return data

def getOnlineUsersCount():
    (data, errStr) = _exec('getOnlineUsersCount/{id}', showLog=False)
    return data


# PRIVATE

import sys
from random import randint
import traceback

from xfw import *
import simplejson

from logger import *
from loadurl import loadUrl
import config
import utils

def _exec(req, data=None, showLog=True, api=XVM.API_VERSION, params={}):
    url = None
    response = None
    errStr = None
    try:
        url = XVM.SERVERS[randint(0, len(XVM.SERVERS) - 1)]
        url = url.format(API=api, REQ=req)
        for k, v in params.iteritems():
            url = url.replace('{'+ k +'}', '' if v is None else str(v))

        accountDBID = utils.getAccountDBID()
        if accountDBID is None:
            accountDBID = 0

        token = config.token.token
        if token is None:
            token = '-'

        url = url.format(id=accountDBID, token=token)

        (response, duration, errStr) = loadUrl(url, body=data)

        return (None if not response else unicode_to_ascii(simplejson.loads(response)), errStr)
    except Exception as ex:
        err(traceback.format_exc())
        err('url = {}'.format(utils.hide_guid(url)))
        err('response = {}'.format(utils.hide_guid(response)))
        err('errStr = {}'.format(utils.hide_guid(errStr)))
        return (None, sys.exc_info()[0])
