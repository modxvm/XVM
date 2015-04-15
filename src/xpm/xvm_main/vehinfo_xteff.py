""" XVM (c) www.modxvm.com 2013-2015 """

# TODO: load data from server

import vehinfo
from logger import *

# PUBLIC

def calculateXe(vehId, dmg_per_battle, frg_per_battle):
    xteff = _getXteffData(vehId)
    if xteff is None or xteff['td'] == xteff['ad'] or xteff['tf'] == xteff['af']:
        vData = vehinfo.getVehicleInfoData(vehId)
        debug('NOTE: No xteff data for vehicle [{}] {}'.format(vehId, vData['key']))
        return

    # constants
    CD = 3.0
    CF = 1.0

    # input
    avgD = float(xteff['ad'])
    topD = float(xteff['td'])
    avgF = float(xteff['af'])
    topF = float(xteff['tf'])

    # calculation
    dD = dmg_per_battle - avgD
    dF = frg_per_battle - avgF
    minD = avgD * 0.4
    minF = avgF * 0.4
    d = max(0, 1 + dD / (topD - avgD) if dmg_per_battle >= avgD else 1 + dD / (avgD - minD))
    f = max(0, 1 + dF / (topF - avgF) if frg_per_battle >= avgF else 1 + dF / (avgF - minF))

    teff = (d * CD + f * CF) / (CD + CF) * 1000.0

    # calculate XVM Scale
    if teff < 1:
        return None
    return next((i for i,v in enumerate(xteff['x']) if v > teff), 100)


# PRIVATE

import os
import traceback
import simplejson

from xfw import *
from logger import *

_xteffData = None

def _getXteffData(vehId):
    global _xteffData
    if _xteffData is None:
        _xteffData = _load()
    return _xteffData.get(str(vehId), None)

def _load():
    res = load_config('res_mods/mods/shared_resources/xvm/res/data/xteff.json')
    return res if res is not None else {}


import BigWorld
def _init():
    global _xteffData
    _xteffData = _load()
BigWorld.callback(1, _init)
