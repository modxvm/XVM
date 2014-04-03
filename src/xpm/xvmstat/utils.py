""" xvm (c) sirmax 2013-2014 """

import os

def is_replay():
    import BattleReplay
    return BattleReplay.g_replayCtrl.isPlaying

def rm(filename):
    if os.path.isfile(filename):
        os.remove(filename)
