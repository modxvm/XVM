""" XVM (c) www.modxvm.com 2013-2015 """

# TODO: load data from server

# PUBLIC

def getXteffData(vehId):
    global _xteffData
    if _xteffData is None:
        _xteffData = _load()
    return _xteffData.get(str(vehId), None)


# PRIVATE

import os
import traceback
import simplejson

from xfw import *
from logger import *

_xteffData = None

def _load():
    res = load_config('res_mods/mods/shared_resources/xvm/res/data/xteff.json')
    return res if res is not None else {}


import BigWorld
def _init():
    global _xteffData
    _xteffData = _load()
BigWorld.callback(1, _init)
