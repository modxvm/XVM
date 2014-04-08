""" xvm (c) sirmax 2013-2014 """

import os
import sys
import traceback
import threading
from pprint import pprint

import BigWorld

from logger import *

def is_replay():
    import BattleReplay
    return BattleReplay.g_replayCtrl.isPlaying

def touch(fname, times=None):
    with open(fname, 'a'):
        os.utime(fname, times)

def rm(fname):
    if os.path.isfile(fname):
        os.remove(fname)

def show_threads():
    for t in threading.enumerate():
        log('Thread: %s' % t.getName())

def getCurrentPlayerId():
    player = BigWorld.player()
    if hasattr(player, 'databaseID'):
        return player.databaseID

    arena = getattr(player, 'arena', None)
    if arena is not None:
        vehID = getattr(player, 'playerVehicleID', None)
        if vehID is not None and vehID in arena.vehicles:
            return arena.vehicles[vehID]['accountDBID']

    #print('===================')
    #pprint(vars(player))
    #print('===================')
    return None

def openWebBrowser(url, allowInternalBrowser=True):
    openBrowser = BigWorld.wg_openWebBrowser
    if allowInternalBrowser:
        from gui.WindowsManager import g_windowsManager
        browser = g_windowsManager.window.browser
        if browser is not None:
            openBrowser = browser.openBrowser
    openBrowser(url)
