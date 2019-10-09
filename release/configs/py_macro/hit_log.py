from xvm import hitLog


@xvm.export('xvm.hitLog.log', deterministic=False)
def hitLog_log():
    return hitLog.hLog()


@xvm.export('xvm.hitLog.log.bg', deterministic=False)
def hitLog_log_bg():
    return hitLog.hLog_bg()


@xvm.export('xvm.hitLog.log.x', deterministic=False)
def hitLog_log_x():
    return hitLog.hLog_x()


@xvm.export('xvm.hitLog.log.y', deterministic=False)
def hitLog_log_y():
    return hitLog.hLog_y()
