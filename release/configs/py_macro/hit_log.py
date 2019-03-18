from xvm_main.python.logger import *
from xvm import hitLog


@xvm.export('xvm.hitLog.hLog', deterministic=False)
def hitLog_hLog():
    return hitLog.getLog()


@xvm.export('xvm.hitLog.hLogBackground', deterministic=False)
def hitLog_hLogBackground():
    return hitLog.getLogBackground()


@xvm.export('xvm.hitLog.hLog_x', deterministic=False)
def hitLog_hLog_x():
    return hitLog.getLogX()


@xvm.export('xvm.hitLog.hLog_y', deterministic=False)
def hitLog_hLog_y():
    return hitLog.getLogY()
