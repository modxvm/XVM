""" XVM (c) www.modxvm.com 2013-2014 """

# PUBLIC

def getXvmUserComments(cachedOnly=False):
    return _comments.getXvmUserComments(cachedOnly)

def setXvmUserComments(value):
    return _comments.setXvmUserComments(value)

# PRIVATE

from random import randint
import traceback
import urllib

import simplejson

from constants import *
from loadurl import loadUrl
from logger import *
import token
import utils

class _Comments:
    def __init__(self):
        self.cached_data = None
        self.cached_token = None

    def getXvmUserComments(self, cachedOnly):
        res = self._doRequest('getComments/%TOKEN%', True, cachedOnly)
        return res if isinstance(res, str) else simplejson.dumps(str)

    def setXvmUserComments(self, value):
        # temporary fix!
        value = value.replace('"', '\\"')
        # /temporary fix!

        return self._doRequest('addComments/%TOKEN%/{0}'.format(urllib.quote(value, safe='')), False, False)

    def _doRequest(self, req, useCache, cachedOnly):
        try:
            t = token.getToken()
            if t is None:
                return {'error':'NOT_INITIALIZED'}
            if t == '':
                return {'error':'NO_TOKEN'}

            if useCache:
                if self.cached_token is not None and self.cached_token == t:
                    return self.cached_data

            if cachedOnly:
                return {'error':'NOT_CACHED'}

            req = req.replace('%TOKEN%', t)
            server = XVM_STAT_SERVERS[randint(0, len(XVM_STAT_SERVERS) - 1)]
            (response, duration, errStr) = loadUrl(server, req)

            if not response:
                return {'error':'NO_RESPONSE', 'errStr':errStr}

            try:
                response = response.strip()
                if response in ('', '[]', '{}'):
                    response = None
                #log(utils.hide_guid(response))
                self.cached_token = t
                self.cached_data = response
                return response
            except Exception, ex:
                errStr = 'Bad answer: ' + response
                err('  ' + errStr)
                return {'error':'BAD_ANSWER', 'errStr':errStr}
        except Exception, ex:
            errStr = str(ex)
            err(traceback.format_exc())
            return {'error':'EXCEPTION', 'errStr':errStr}

_comments = _Comments()
