""" xvm (c) sirmax 2013-2014 """

import os

def is_replay():
    import BattleReplay
    return BattleReplay.g_replayCtrl.isPlaying

def touch(fname, times=None):
    with open(fname, 'a'):
        os.utime(fname, times)

def rm(fname):
    if os.path.isfile(fname):
        os.remove(fname)
