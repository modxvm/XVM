""" XVM (c) www.modxvm.com 2013-2017 """

# TODO: load data from server

import vehinfo
from logger import *


# PUBLIC

def calculateXTDB(vehCD, dmg_per_battle):
    data = _getData(vehCD)
    if data is None:
        return -1

    # calculate XVM Scale
    return next((i for i,v in enumerate(data['x']) if v > dmg_per_battle), 100)

def vehArrayXTDB(vehCD):
    data = _getData(vehCD)
    if data is None:
        return []
    return data['x']


# PRIVATE

import os
import traceback

import BigWorld

from xfw import *

from logger import *


_data = None

def _getData(vehCD):
    global _data
    if _data is None:
        _data = _load()
    return _data.get(str(vehCD), None)


def _load():
    res = load_config('res_mods/mods/shared_resources/xvm/res/data/xtdb.json')
    return res if res is not None else {}


def _init():
    global _data
    _data = _load()

BigWorld.callback(0, _init)
