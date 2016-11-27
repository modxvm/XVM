""" XVM (c) www.modxvm.com 2013-2016 """

# PUBLIC

def getWGEvent1Rank(vehCD, accountDBID):
    global _wg_event_1_data
    if _wg_event_1_data is not None:
        vdata = _wg_event_1_data.get(vehCD)
        if vdata:
            return vdata.get(accountDBID, None)
    return None


# PRIVATE

import cPickle
import traceback
import BigWorld
import simplejson
from logger import *
import filecache


_WG_EVENT_1_URL = 'http://stat.modxvm.com/wg_event_1_{}.dat'.format(GAME_REGION.lower())

_wg_event_1_data = None

def _init():
    #log('start loading')
    filecache.get_url(_WG_EVENT_1_URL, _init_callback)

def _init_callback(url, bytes):
    res = {}
    try:
        #log('loaded ' + str(len(str(bytes))) + ' bytes')
        if not bytes:
            # err('Empty response or parsing error')
            pass
        else:
            #log('loaded ' + str(len(str(bytes))) + ' bytes')
            global _wg_event_1_data
            _wg_event_1_data = cPickle.loads(bytes)
            _wg_event_1_data[3921][46815695] = 1
    except Exception, ex:
        err(traceback.format_exc())

    return res

BigWorld.callback(0, _init)
