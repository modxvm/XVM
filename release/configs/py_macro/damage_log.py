from xvm import damageLog


@xvm.export('xvm.damageLog.dLog', deterministic=False)
@xvm.export('xvm.damageLog.log', deterministic=False)
def damageLog_log():
    return damageLog.dLog()


@xvm.export('xvm.damageLog.dLogBackground', deterministic=False)
@xvm.export('xvm.damageLog.log.bg', deterministic=False)
def damageLog_log_bg():
    return damageLog.dLog_bg()


@xvm.export('xvm.damageLog.dLog_shadow', deterministic=False)
@xvm.export('xvm.damageLog.log.shadow', deterministic=False)
def damageLog_log_shadow(setting):
    return damageLog.dLog_shadow(setting)


@xvm.export('xvm.damageLog.dLog_x', deterministic=False)
@xvm.export('xvm.damageLog.log.x', deterministic=False)
def damageLog_log_x():
    return damageLog.dLog_x()


@xvm.export('xvm.damageLog.dLog_y', deterministic=False)
@xvm.export('xvm.damageLog.log.y', deterministic=False)
def damageLog_log_y():
    return damageLog.dLog_y()


@xvm.export('xvm.damageLog.lastHit', deterministic=False)
def damageLog_lastHit():
    return damageLog.lastHit()


@xvm.export('xvm.damageLog.lastHit_shadow', deterministic=False)
@xvm.export('xvm.damageLog.lastHit.shadow', deterministic=False)
def damageLog_lastHit_shadow(setting):
    return damageLog.lastHit_shadow(setting)


@xvm.export('xvm.damageLog.lastHit_x', deterministic=False)
@xvm.export('xvm.damageLog.lastHit.x', deterministic=False)
def damageLog_lastHit_x():
    return damageLog.lastHit_x()


@xvm.export('xvm.damageLog.lastHit_y', deterministic=False)
@xvm.export('xvm.damageLog.lastHit.y', deterministic=False)
def damageLog_lastHit_y():
    return damageLog.lastHit_y()


@xvm.export('xvm.damageLog.fire', deterministic=False)
def damageLog_fire():
    return damageLog.fire()


@xvm.export('xvm.isImpact', deterministic=False)
def damageLog_isImpact():
    return 'Impact' if damageLog.isImpact else None
