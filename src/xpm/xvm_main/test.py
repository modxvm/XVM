""" XVM (c) www.modxvm.com 2013-2016 """

#############################
# Command

def onHangarInit():
    # debug
    if IS_DEVELOPMENT:
        import glob
        files = glob.glob("[0-9]*.dat")
        if files:
            for fn in files:
                log('[TEST]  battle result: {}'.format(fn))
                runTest(('battleResults', fn))
    pass


def runTest(args):
    if args is None:
        return
    cmd = args[0]

    if cmd == 'battleResults':
        _showBattleResults(int(args[1][:-4]))


#############################
# imports

import os
import cPickle
import traceback

import BigWorld
import AccountCommands
from account_helpers import BattleResultsCache
from gui.shared import event_dispatcher as shared_events

from xfw import *

from logger import *


#############################
# BattleResults

def _showBattleResults(arenaUniqueID):
    shared_events.showMyBattleResults(arenaUniqueID)


@overrideMethod(BattleResultsCache.BattleResultsCache, 'get')
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
                    callback(AccountCommands.RES_CACHE, BattleResultsCache.convertToFullForm(battleResults))
    except Exception, ex:
        err(traceback.format_exc())
        base(self, arenaUniqueID, callback)

    if fileHandler is not None:
        fileHandler.close()
