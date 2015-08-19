""" XVM (c) www.modxvm.com 2013-2015 """

import os
import sys
import re
import traceback
import threading
import math
from pprint import pprint

import BigWorld
import Vehicle
from gui import game_control
from gui.battle_control import g_sessionProvider

import config
from logger import *


def touch(fname, times=None):
    with open(fname, 'a'):
        os.utime(fname, times)


def rm(fname):
    if os.path.isfile(fname):
        os.remove(fname)


def hide_guid(txt):
    return re.sub('([0-9A-Fa-f]{8}-)[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{8}([0-9A-Fa-f]{4})',
                  '\\1****-****-****-********\\2', txt)


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


def getVehicleInfo(vehId):
    return g_sessionProvider.getCtx().getArenaDP().getVehicleInfo(vehId)


def getVehicleStats(vehId):
    return g_sessionProvider.getCtx().getArenaDP().getVehicleStats(vehId)


# 0 - equal, -1 - v1<v2, 1 - v1>v2, -2 - error
def compareVersions(v1, v2):
    try:
        v1 = v1.replace('-', '.')
        v2 = v2.replace('-', '.')

        aa = v1.split('.')
        while len(aa) < 4:
            aa.append('0')

        ba = v2.split('.')
        while len(ba) < 4:
            ba.append('0')

        for i in xrange(4):
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
