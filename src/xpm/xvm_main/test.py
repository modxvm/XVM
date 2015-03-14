""" XVM (c) www.modxvm.com 2013-2015 """

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

def _showBattleResults(arenaUniqueID):
    from gui.shared import event_dispatcher as shared_events
    shared_events.showMyBattleResults(arenaUniqueID)
