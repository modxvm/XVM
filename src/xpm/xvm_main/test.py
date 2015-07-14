""" XVM (c) www.modxvm.com 2013-2015 """

#############################
# Command

def onHangarInit():
    pass
    # debug
    #runTest(('battleResults', '148242232916309.dat'))


def runTest(args):
    if args is None:
        return
    cmd = args[0]

    if cmd == 'battleResults':
        _showBattleResults(int(args[1][:-4]))


#############################
# Imports

import os
import cPickle
import traceback
import BigWorld
from logger import *


#############################
# BattleResults

def _showBattleResults(arenaUniqueID):
    from gui.shared import event_dispatcher as shared_events
    shared_events.showMyBattleResults(arenaUniqueID)


def BattleResultsCache_get(base, self, arenaUniqueID, callback):
    fileHandler = None
    try:
        filename = '{0}.dat'.format(arenaUniqueID)
        if not os.path.exists(filename):
            base(self, arenaUniqueID, callback)
        else:
            fileHandler = open(filename, 'rb')
            version, battleResults = cPickle.load(fileHandler)
            if battleResults is not None:
                if callback is not None:
                    import AccountCommands
                    from account_helpers import BattleResultsCache
                    callback(AccountCommands.RES_CACHE, BattleResultsCache.convertToFullForm(battleResults))
    except Exception, ex:
        err(traceback.format_exc())
        base(self, arenaUniqueID, callback)

    if fileHandler is not None:
        fileHandler.close()


#############################
# Register events

def _RegisterEvents():
    from account_helpers import BattleResultsCache
    OverrideMethod(BattleResultsCache.BattleResultsCache, 'get', BattleResultsCache_get)
BigWorld.callback(0, _RegisterEvents)
