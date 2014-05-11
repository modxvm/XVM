""" XVM (c) www.modxvm.com 2013-2014 """

# PUBLIC

def getWN8ExpectedData():
    global _wn8ExpectedData
    if _wn8ExpectedData is None:
        _wn8ExpectedData = _load()
    return _wn8ExpectedData

# PRIVATE

__WN8_EXPECTED_DATA_URL = 'http://stat.modxvm.com/wn8.json'

from pprint import pprint
import traceback

import simplejson as json

from logger import *
from loadurl import loadUrl

_wn8ExpectedData = None

def _load():
    res = None
    try:
        (response, duration) = loadUrl(__WN8_EXPECTED_DATA_URL)
        if not response:
            #err('Empty response or parsing error')
            pass
        else:
            try:
                data = None if response in ('', '[]') else json.loads(response)
                res = json.dumps(data)
            except Exception, ex:
                err('  Bad answer: ' + response)
                res = None
    except Exception, ex:
        err(traceback.format_exc())

    return res


import BigWorld
def _init():
    _wn8ExpectedData = _load()
BigWorld.callback(1, _init)
