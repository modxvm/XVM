""" xvm (c) sirmax 2013 """

#############################
# Command

def runTest(args):
    if args is None:
        return
    cmd = args[0]

    if cmd == 'battleResults':
        _showBattleResults()

###

# BattleResults

import BigWorld
import cPickle
from gui.mods.xpm import *
from logger import *

BATTLE_RESULTS_TEST_ARENA_ID = 83008761304453998L

def _showBattleResults():
    OverrideMethod(BigWorld.player().battleResultsCache, 'get', _getBattleResults)

    from gui.shared import events
    from gui.shared import g_eventBus
    g_eventBus.handleEvent(events.ShowWindowEvent(events.ShowWindowEvent.SHOW_BATTLE_RESULTS, {
        'arenaUniqueID': BATTLE_RESULTS_TEST_ARENA_ID }))

def _getBattleResults(base, arenaUniqueID, callback):
    if arenaUniqueID == BATTLE_RESULTS_TEST_ARENA_ID:
        fileHandler = open('%s.dat' % arenaUniqueID, 'rb')
        (version, battleResults) = cPickle.load(fileHandler)
        if battleResults is not None:
            if callback is not None:
                import AccountCommands
                from account_helpers.battleresultscache import convertToFullForm
                callback(AccountCommands.RES_CACHE, convertToFullForm(battleResults))
    else:
        base(arenaUniqueID, callback)
