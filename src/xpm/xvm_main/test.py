""" XVM (c) www.modxvm.com 2013-2015 """

#############################
# Command

def onHangarInit():
    pass
    # debug
    runTest(('battleResults', '3461757960825113.dat'))


def runTest(args):
    if args is None:
        return
    cmd = args[0]

    if cmd == 'battleResults':
        _showBattleResults(int(args[1][:-4]))

###

import os
import cPickle
import traceback
from logger import *

# BattleResults

def _showBattleResults(arenaUniqueID):
    fileHandler = None
    try:
        filename = '{0}.dat'.format(arenaUniqueID)
        if os.path.exists(filename):
            fileHandler = open(filename, 'rb')
            version, battleResults = cPickle.load(fileHandler)
            if battleResults is not None:
                from account_helpers import BattleResultsCache
                from gui.shared import event_dispatcher as shared_events
                shared_events.showBattleResultsFromData(BattleResultsCache.convertToFullForm(battleResults))
    except Exception, ex:
        err(traceback.format_exc())

    if fileHandler is not None:
        fileHandler.close()
