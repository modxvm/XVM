""" xvm (c) sirmax 2013-2014 """

import os
import sys
import traceback

from logger import *

def is_replay():
    import BattleReplay
    return BattleReplay.g_replayCtrl.isPlaying

def touch(fname, times=None):
    with open(fname, 'a'):
        os.utime(fname, times)

def rm(fname):
    if os.path.isfile(fname):
        os.remove(fname)

def stack_trace():
    code = ['\n*** STACKTRACE - START ***']
    for threadId, stack in sys._current_frames().items():
        code.append("# ThreadID: %s" % threadId)
        for filename, lineno, name, line in traceback.extract_stack(stack):
            code.append('File: "%s", line %d, in %s' % (filename, lineno, name))
            if line:
                code.append("  %s" % (line.strip()))
    code.append('*** STACKTRACE - END ***"')
    debug('\n'.join(code))
