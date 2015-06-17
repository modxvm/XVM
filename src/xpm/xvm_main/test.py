""" XVM (c) www.modxvm.com 2013-2015 """

#############################
# Command

def onHangarInit():
    pass
    # debug
    #runTest(('battleResults', '868748764371175.dat'))


def runTest(args):
    if args is None:
        return
    cmd = args[0]

    if cmd == 'battleResults':
        _showBattleResults(int(args[1][:-4]))

###

# BattleResults

def _showBattleResults(arenaUniqueID):
    from gui.shared import event_dispatcher as shared_events
    shared_events.showMyBattleResults(arenaUniqueID)
