""" xvm (c) sirmax 2013-2014 """

import os
import sys
import traceback
import threading

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
        debug('Thread: %s' % t.getName())

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
