""" XVM (c) www.modxvm.com 2013-2016 """

import os
import sys
import re
import traceback
import threading
import math
from pprint import pprint
from bisect import bisect_left

import BigWorld
import Vehicle
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider
from gui import game_control

from xfw import *

import config
from consts import XVM_PATH
from logger import *
import userprefs


def touch(fname, times=None):
    with open(fname, 'a'):
        os.utime(fname, times)


def rm(fname):
    if os.path.isfile(fname):
        os.remove(fname)


def hide_guid(txt):
    return re.sub('([0-9A-Fa-f]{8}-)[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{8}([0-9A-Fa-f]{4})',
                  '\\1****-****-****-********\\2', str(txt))


def show_threads():
    for t in threading.enumerate():
        log('Thread: %s' % t.getName())


def openWebBrowser(url, useInternalBrowser=False):
    openBrowser = BigWorld.wg_openWebBrowser
    if useInternalBrowser:
        browser = game_control.g_instance.browser
        if browser is not None:
            openBrowser = browser.load
    openBrowser(url)


def getVehicleByName(name):
    for v in BigWorld.entities.values():
        if isinstance(v, Vehicle.Vehicle) and v.publicInfo['name'] == name:
            return v
    return None


def getVehicleByHandle(handle):
    for v in BigWorld.entities.values():
        if isinstance(v, Vehicle.Vehicle) and hasattr(v, 'marker') and v.marker == handle:
            return v
    return None


def getVehicleInfo(vehicleID):
    sessionProvider = dependency.instance(IBattleSessionProvider)
    return sessionProvider.getArenaDP().getVehicleInfo(vehicleID)


def getVehicleStats(vehicleID):
    sessionProvider = dependency.instance(IBattleSessionProvider)
    return sessionProvider.getArenaDP().getVehicleStats(vehicleID)


# 0 - equal, -1 - v1<v2, 1 - v1>v2, -2 - error
def compareVersions(v1, v2):
    try:
        aa = v1.replace('-', '.').split('.')
        ba = v2.replace('-', '.').split('.')
        while len(aa) < 4 or len(aa) < len(ba):
            aa.append('0')
        while len(ba) < 4 or len(ba) < len(aa):
            ba.append('0')
        #debug('{} <=> {}'.format(aa, ba))
        for i in xrange(len(aa)):
            a = aa[i]
            b = ba[i]
            da = a.isdigit()
            db = b.isdigit()
            if a == 'dev':
                return -1
            if b == 'dev':
                return 1
            if not da and not db:
                return 0 if a == b else -1 if a < b else 1
            if not da:
                return -1
            if not db:
                return 1
            if int(a) < int(b):
                return -1
            if int(a) > int(b):
                return 1
    except Exception, ex:
        # err(traceback.format_exc())
        return -2
    return 0


def getDynamicColorValue(type, value, prefix='#'):
    if value is None or math.isnan(value):
        return ''

    cfg = config.get('colors/%s' % type)
    if not cfg:
        return ''

    color = next((int(x['color'], 0) for x in cfg if value <= float(x['value'])), 0xFFFFFF)

    return "{0}{1:06x}".format(prefix, color)


def fixPath(path):
    if path:
        path = path.replace('\\', '/')
        if path[-1] != '/':
            path += '/'
    return path


def getAccountDBID():
    accountDBID = getCurrentAccountDBID() if not isReplay() else None
    if accountDBID is None:
        accountDBID = userprefs.get('tokens/lastAccountDBID')
    return accountDBID


def getMapSize():
    (b, l), (t, r) = BigWorld.player().arena.arenaType.boundingBox
    return t - b


# Fix <img src='xvm://...'> to <img src='img://XVM_IMG_RES_ROOT/...'> (res_mods/mods/shared_resources/xvm/res)
# Fix <img src='cfg://...'> to <img src='img://XVM_IMG_CFG_ROOT/...'> (res_mods/configs/xvm)
def fixImgTag(path):
    return path.replace('xvm://', 'img://' + XVM_PATH.XVM_IMG_RES_ROOT).replace('cfg://', 'img://' + XVM_PATH.XVM_IMG_CFG_ROOT)

# Fix 'xvm://*' to './res_mods/mods/shared_resources/xvm/*'
# Fix 'cfg://*' to './res_mods/configs/xvm/*'
# Fix '*' to 'basepath/*'
def fixXvmPath(path, basepath = None):
    if path[:6].lower() == "xvm://":
        path = path.replace("xvm://","./res_mods/mods/shared_resources/xvm/", 1)
    elif path[:6].lower() == "cfg://":
        path = path.replace("cfg://","./res_mods/configs/xvm/", 1)
    elif basepath:
        path = fixPath(basepath)+path
    return path.replace('\\', '/')

def takeClosest(myList, myNumber):
    """
    Assumes myList is sorted. Returns closest value to myNumber.

    If two numbers are equally close, return the smallest number.
    """
    pos = bisect_left(myList, myNumber)
    if pos == 0:
        return myList[0]
    if pos == len(myList):
        return myList[-1]
    before = myList[pos - 1]
    after = myList[pos]
    if after - myNumber < myNumber - before:
       return after
    else:
       return before
