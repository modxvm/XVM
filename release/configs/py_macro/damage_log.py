import traceback
from xvm import damageLog


@xvm.export('xvm.damageLog.dLog', deterministic=False)
def damageLog_dLog():
    return damageLog.dLog()


@xvm.export('xvm.damageLog.dLog_shadow', deterministic=False)
def damageLog_dLog_shadow(setting):
    return damageLog.dLog_shadow(setting)


@xvm.export('xvm.damageLog.dLog_x', deterministic=False)
def xvm_damageLog_log_x():
    return damageLog._log.x


@xvm.export('xvm.damageLog.dLog_y', deterministic=False)
def xvm_damageLog_log_y():
    return damageLog._log.y


@xvm.export('xvm.damageLog.lastHit', deterministic=False)
def damageLog_lastHit():
    return damageLog.lastHit()


@xvm.export('xvm.damageLog.lastHit_shadow', deterministic=False)
def damageLog_lastHit_shadow(setting):
    return damageLog.lastHit_shadow(setting)


@xvm.export('xvm.damageLog.lastHit_x', deterministic=False)
def xvm_damageLog_lastHit_x():
    return damageLog._lastHit.x


@xvm.export('xvm.damageLog.lastHit_y', deterministic=False)
def xvm_damageLog_lastHit_y():
    return damageLog._lastHit.y


@xvm.export('xvm.damageLog.fire', deterministic=False)
def damageLog_fire():
    return damageLog.fire()

