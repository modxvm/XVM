""" xvm (c) sirmax 2013-2014 """

def is_replay():
    import BattleReplay
    return BattleReplay.g_replayCtrl.isPlaying
