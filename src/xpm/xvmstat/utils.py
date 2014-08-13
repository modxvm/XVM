""" XVM (c) www.modxvm.com 2013-2014 """

import os
import sys
import re
import traceback
import threading
from pprint import pprint

import BigWorld

from logger import *

def touch(fname, times=None):
    with open(fname, 'a'):
        os.utime(fname, times)

def rm(fname):
    if os.path.isfile(fname):
        os.remove(fname)

def hide_guid(txt):
    return re.sub('([0-9A-Fa-f]{8}-)[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}(-[0-9A-Fa-f]{12})', \
        '\\1****-****-****\\2', txt)

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
    from gui.BattleContext import g_battleContext
    return g_battleContext.arenaDP.getVehicleInfo(vehId)

def getVehicleStats(vehId):
    from gui.BattleContext import g_battleContext
    return g_battleContext.arenaDP.getVehicleStats(vehId)
