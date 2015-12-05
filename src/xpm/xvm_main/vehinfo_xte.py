""" XVM (c) www.modxvm.com 2013-2015 """

# TODO: load data from server

import vehinfo
from logger import *


# PUBLIC

def getReferenceValues(vehId):
    xte = _getXTEData(vehId)
    if xte is None or xte['td'] == xte['ad'] or xte['tf'] == xte['af']:
        return None
    return {'avgD': xte['ad'], 'avgF': xte['af'], 'topD': xte['td'], 'topF': xte['tf']}


def calculateXTE(vehId, dmg_per_battle, frg_per_battle):
    xte = _getXTEData(vehId)
    if xte is None or xte['td'] == xte['ad'] or xte['tf'] == xte['af']:
        vdata = vehinfo.getVehicleInfoData(vehId)
        if vdata is None:
            debug('NOTE: No vehicle info for vehicle id = {}'.format(vehId))
        else:
            debug('NOTE: No xte data for vehicle [{}] {}'.format(vehId, vdata['key']))
        return -1

    # constants
    CD = 3.0
    CF = 1.0

    # input
    avgD = float(xte['ad'])
    topD = float(xte['td'])
    avgF = float(xte['af'])
    topF = float(xte['tf'])

    # calculation
    dD = dmg_per_battle - avgD
    dF = frg_per_battle - avgF
    minD = avgD * 0.4
    minF = avgF * 0.4
    d = max(0, 1 + dD / (topD - avgD) if dmg_per_battle >= avgD else 1 + dD / (avgD - minD))
    f = max(0, 1 + dF / (topF - avgF) if frg_per_battle >= avgF else 1 + dF / (avgF - minF))

    t = (d * CD + f * CF) / (CD + CF) * 1000.0

    # calculate XVM Scale
    if t < 1:
        return 0
    return next((i for i,v in enumerate(xte['x']) if v > t), 100)


# PRIVATE

import os
import traceback

import BigWorld

from xfw import *

from logger import *


_xteData = None


def _getXTEData(vehId):
    global _xteData
    if _xteData is None:
        _xteData = _load()
    return _xteData.get(str(vehId), None)

def _load():
    res = load_config('res_mods/mods/shared_resources/xvm/res/data/xte.json')
    return res if res is not None else {}


def _init():
    global _xteData
    _xteData = _load()
BigWorld.callback(0, _init)
