""" XVM (c) www.modxvm.com 2013-2015 """

import os
import sys
import re
import traceback
import threading
import math
from pprint import pprint

import BigWorld

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

def openWebBrowser(url, allowInternalBrowser=True):
    openBrowser = BigWorld.wg_openWebBrowser
    if allowInternalBrowser:
        from gui.WindowsManager import g_windowsManager
        browser = g_windowsManager.window.browser
        if browser is not None:
            openBrowser = browser.openBrowser
    openBrowser(url)

def getVehicleByName(name):
    import Vehicle
    for v in BigWorld.entities.values():
        if isinstance(v, Vehicle.Vehicle) and v.publicInfo['name'] == name:
            return v
    return None

def getVehicleByHandle(handle):
    import Vehicle
    for v in BigWorld.entities.values():
        if isinstance(v, Vehicle.Vehicle) and hasattr(v, 'marker') and v.marker == handle:
            return v
    return None

def getVehicleInfo(vehId):
    from gui.battle_control import g_sessionProvider
    return g_sessionProvider.getCtx().getArenaDP().getVehicleInfo(vehId)

def getVehicleStats(vehId):
    from gui.battle_control import g_sessionProvider
    return g_sessionProvider.getCtx().getArenaDP().getVehicleStats(vehId)

# 0 - equal, -1 - v1<v2, 1 - v1>v2, -2 - error
def compareVersions(v1, v2):
    try:
        v1 = v1.replace('-', '.')
        v2 = v2.replace('-', '.')

        a = v1.split('.')
        while len(a) < 4:
            a.append('0')

        b = v2.split('.')
        while len(b) < 4:
            b.append('0')

        for i in xrange(4):
            da = a[i].isdigit()
            db = b[i].isdigit()
            if not da and not db:
                return 0 if a[i] == b[i] else -1 if a[i] < b[i] else 1
            if not da:
                return -1
            if not db:
                return 1
            if int(a[i]) < int(b[i]):
                return -1
            if int(a[i]) > int(b[i]):
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
