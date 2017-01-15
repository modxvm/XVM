""" XVM (c) www.modxvm.com 2013-2017 """

from consts import *

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

import sys
from random import randint

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
            url = url.replace('{'+k+'}', '' if v is None else str(v))

        accountDBID = utils.getAccountDBID()
        if accountDBID is None:
            accountDBID = 0

        token = config.token.token
        if token is None:
            token = ''

        url = url.format(id=accountDBID, token=token)

        (response, duration, errStr) = loadUrl(url, None, data)

        return (None if not response else unicode_to_ascii(simplejson.loads(response)), errStr)
    except Exception as ex:
        err(traceback.format_exc())
        err('url = {}'.format(utils.hide_guid(url)))
        err('response = {}'.format(utils.hide_guid(response)))
        err('errStr = {}'.format(utils.hide_guid(errStr)))
        return (None, sys.exc_info()[0])
