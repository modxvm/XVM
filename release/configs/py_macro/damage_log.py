import traceback
from xvm import utils
from xvm import myDamageLog


@xvm.export('xvm.myDamageLog.dLog', deterministic=False)
def myDamageLog_dLog():
    return myDamageLog.dLog()


@xvm.export('xvm.myDamageLog.lastHit', deterministic=False)
def myDamageLog_lastHit():
    return myDamageLog.lastHit()


@xvm.export('xvm.myDamageLog.timerReload', deterministic=False)
def myDamageLog_timerReload():
    return myDamageLog.timerReload()

