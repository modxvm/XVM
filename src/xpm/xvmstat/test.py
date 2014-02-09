""" xvm (c) sirmax 2013-2014 """

#############################
# Command

def runTest(args):
    if args is None:
        return
    cmd = args[0]

    if cmd == 'battleResults':
        _showBattleResults(args[1])

###

# BattleResults

import BigWorld
import cPickle
import traceback
from gui.mods.xpm import *
from logger import *

def _showBattleResults(arenaUniqueID):
    OverrideMethod(BigWorld.player().battleResultsCache, 'get', _getBattleResults)

    from gui.shared import events
    from gui.shared import g_eventBus
    g_eventBus.handleEvent(events.ShowWindowEvent(events.ShowWindowEvent.SHOW_BATTLE_RESULTS, {
        'arenaUniqueID': int(arenaUniqueID) }))

def _getBattleResults(base, arenaUniqueID, callback):
    try:
        fileHandler = open('%s.dat' % arenaUniqueID, 'rb')
        (version, battleResults) = cPickle.load(fileHandler)
        if battleResults is not None:
            if callback is not None:
                import AccountCommands
                from account_helpers.battleresultscache import convertToFullForm
                callback(AccountCommands.RES_CACHE, convertToFullForm(battleResults))
        return
    except Exception, ex:
        err('_getBattleResults() exception: ' + traceback.format_exc(ex))
        base(arenaUniqueID, callback)
