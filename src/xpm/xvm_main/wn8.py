""" XVM (c) www.modxvm.com 2013-2014 """

# PUBLIC

def getWN8ExpectedData(vehId):
    global _wn8ExpectedData
    if _wn8ExpectedData is None:
        _wn8ExpectedData = _load()
    return _wn8ExpectedData.get(str(vehId), None)


# PRIVATE

__WN8_EXPECTED_DATA_URL = 'http://stat.modxvm.com/wn8.json'

from pprint import pprint
import traceback

import simplejson

from logger import *
from loadurl import loadUrl

_wn8ExpectedData = None

def _load():
    res = {}
    try:
        (response, duration, errStr) = loadUrl(__WN8_EXPECTED_DATA_URL)
        if not response:
            #err('Empty response or parsing error')
            pass
        else:
            try:
                data = None if response in ('', '[]') else simplejson.loads(response)
                res = {}
                for x in data['data']:
                    n = x['IDNum']
                    del x['IDNum']
                    res[n] = x
            except Exception, ex:
                err('  Bad answer: ' + response)
                res = {}
    except Exception, ex:
        err(traceback.format_exc())

    return res


import BigWorld
def _init():
    global _wn8ExpectedData
    _wn8ExpectedData = _load()
BigWorld.callback(1, _init)
