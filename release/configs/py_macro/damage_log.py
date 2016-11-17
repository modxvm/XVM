import traceback
from xvm import damageLog


@xvm.export('xvm.damageLog.dLog', deterministic=False)
def damageLog_dLog():
    return damageLog.dLog()


@xvm.export('xvm.damageLog.lastHit', deterministic=False)
def damageLog_lastHit():
    return damageLog.lastHit()


@xvm.export('xvm.damageLog.fire', deterministic=False)
def damageLog_fire():
    return damageLog.fire()

