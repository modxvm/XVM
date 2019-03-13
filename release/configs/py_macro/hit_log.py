from xvm_main.python.logger import *
from xvm import hitLog


@xvm.export('xvm.hitLog', deterministic=False)
def xvm_hitLog():
    return hitLog.getLog()


@xvm.export('xvm.hitLog_Background', deterministic=False)
def xvm_hitLog_Background():
    return hitLog.getLogBackground()


@xvm.export('xvm.hitLog_x', deterministic=False)
def xvm_hitLog_x():
    return hitLog.getLogX()


@xvm.export('xvm.hitLog_y', deterministic=False)
def xvm_hitLog_y():
    return hitLog.getLogY()
