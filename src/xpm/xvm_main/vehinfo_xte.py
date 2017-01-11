""" XVM (c) www.modxvm.com 2013-2017 """

# TODO: load data from server

import vehinfo
from logger import *


# PUBLIC

def getReferenceValues(vehCD):
    data = _getData(vehCD)
    if data is None or data['td'] == data['ad'] or data['tf'] == data['af']:
        return None
    return {'avgD': data['ad'], 'avgF': data['af'], 'topD': data['td'], 'topF': data['tf']}


def calculateXTE(vehCD, dmg_per_battle, frg_per_battle):
    data = _getData(vehCD)
    if data is None or data['td'] == data['ad'] or data['tf'] == data['af']:
        vdata = vehinfo.getVehicleInfoData(vehCD)
        if vdata is None:
            debug('NOTE: No vehicle info for vehicle id = {}'.format(vehCD))
        else:
            debug('NOTE: No xte data for vehicle [{}] {}'.format(vehCD, vdata['key']))
        return -1

    # constants
    CD = 3.0
    CF = 1.0

    # input
    avgD = float(data['ad'])
    topD = float(data['td'])
    avgF = float(data['af'])
    topF = float(data['tf'])

    # calculation
    dD = dmg_per_battle - avgD
    dF = frg_per_battle - avgF
    minD = avgD * 0.4
    minF = avgF * 0.4
    d = max(0, 1 + dD / (topD - avgD) if dmg_per_battle >= avgD else 1 + dD / (avgD - minD))
    f = max(0, 1 + dF / (topF - avgF) if frg_per_battle >= avgF else 1 + dF / (avgF - minF))

    t = (d * CD + f * CF) / (CD + CF) * 1000.0

    # calculate XVM Scale
    return next((i for i,v in enumerate(data['x']) if v > t), 100)


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
    res = load_config('res_mods/mods/shared_resources/xvm/res/data/xte.json')
    return res if res is not None else {}


def _init():
    global _data
    _data = _load()

BigWorld.callback(0, _init)
