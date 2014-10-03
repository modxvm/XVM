""" XVM (c) www.modxvm.com 2013-2014 """

# PUBLIC

def getXvmUserComments():
    return _comments.getXvmUserComments()

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

    def getXvmUserComments(self):
        try:
            t = token.getToken()
            if t is None:
                return {'error':'NO_INITIALIZED'}
            if t == '':
                return {'error':'NO_TOKEN'}

            if self.cached_token is not None and self.cached_token == t:
                return self.cached_data

            req = "getComments/%s" % t
            server = XVM_STAT_SERVERS[randint(0, len(XVM_STAT_SERVERS) - 1)]
            (response, duration, errStr) = loadUrl(server, req)

            if not response:
                return {'error':'NO_RESPONSE', 'errStr':errStr}

            try:
                response = response.strip()
                data = {} if response in ('', '[]') else simplejson.loads(response)
                #log(utils.hide_guid(response))
                self.cached_token = t
                self.cached_data = data
                return data
            except Exception, ex:
                errStr = 'Bad answer: ' + response
                err('  ' + errStr)
                return {'error':'BAD_ANSWER', 'errStr':errStr}
        except Exception, ex:
            errStr = str(ex)
            err(traceback.format_exc())
            return {'error':'EXCEPTION', 'errStr':errStr}

    def setXvmUserComments(self, value):
        try:
            t = token.getToken()
            if t is None:
                return {'error':'NO_INITIALIZED'}
            if t == '':
                return {'error':'NO_TOKEN'}

            req = "addComments/%s/%s" % (t, urllib.quote(value, safe=''))
            server = XVM_STAT_SERVERS[randint(0, len(XVM_STAT_SERVERS) - 1)]
            (response, duration, errStr) = loadUrl(server, req, False)

            if not response:
                return {'error':'NO_RESPONSE', 'errStr':errStr}

            try:
                response = response.strip()
                data = {} if response in ('', '[]') else simplejson.loads(response)
                #log(utils.hide_guid(response))
                self.cached_token = t
                self.cached_data = data
                return data
            except Exception, ex:
                errStr = 'Bad answer: ' + response
                err('  ' + errStr)
                err(traceback.format_exc())
                return {'error':'BAD_ANSWER', 'errStr':errStr}
        except Exception, ex:
            errStr = str(ex)
            err(traceback.format_exc())
            return {'error':'EXCEPTION', 'errStr':errStr}

_comments = _Comments()
