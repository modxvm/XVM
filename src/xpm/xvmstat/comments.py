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
        res = self._doRequest('getComments', None, True, cachedOnly)
        return res if isinstance(res, str) else simplejson.dumps(res)

    def setXvmUserComments(self, value):
        res = self._doRequest('addComments', value, False, False)
        return res if isinstance(res, str) else simplejson.dumps(res)

    def _doRequest(self, cmd, body, useCache, cachedOnly):
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

            req = '{0}/{1}'.format(cmd, t)
            server = XVM_STAT_SERVERS[randint(0, len(XVM_STAT_SERVERS) - 1)]
            (response, duration, errStr) = loadUrl(server, req, body=body)

            if not response:
                return {'error':'NO_RESPONSE', 'errStr':errStr}

            response = response.strip()
            if response in ('', '[]', '{}'):
                response = None
            #log(utils.hide_guid(response))
            self.cached_token = t
            self.cached_data = response
            return response
        except Exception, ex:
            errStr = str(ex)
            err(traceback.format_exc())
            return {'error':'EXCEPTION', 'errStr':errStr}

_comments = _Comments()
