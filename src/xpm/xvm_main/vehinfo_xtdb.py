""" XVM (c) www.modxvm.com 2013-2015 """

# TODO: load data from server

import vehinfo
from logger import *


# PUBLIC

def calculateXTDB(vehId, dmg_per_battle):
    data = _getData(vehId)
    if data is None:
        return -1

    # calculate XVM Scale
    if dmg_per_battle < 1:
        return 0
    return next((i for i,v in enumerate(data['x']) if v > dmg_per_battle), 100)

def vehArrayXTDB(vehId):
    data = _getData(vehId)
    if data is None:
        return -1

    return data['x']


# PRIVATE

import os
import traceback

import BigWorld

from xfw import *

from logger import *


_data = None

def _getData(vehId):
    global _data
    if _data is None:
        _data = _load()
    return _data.get(str(vehId), None)


def _load():
    res = load_config('res_mods/mods/shared_resources/xvm/res/data/xtdb.json')
    return res if res is not None else {}


def _init():
    global _data
    _data = _load()

BigWorld.callback(0, _init)
