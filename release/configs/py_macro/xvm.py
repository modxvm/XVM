
import traceback

# Import logger
from xvm_main.python.logger import *

# Import config. Usage example: config.get('definition/author', 'XVM team')
import xvm_main.python.config as config

from xvm import utils

# Team Strength

@xvm.export('xvm.team_strength')
def xvm_team_strength(a, e):
    try:
        invalid_values = ['', '-']
        if a in invalid_values or e in invalid_values:
            return ''
        sign = '&gt;' if float(a) > float(e) else '&lt;' if float(a) < float(e) else '='
        ca = utils.brighten_color(int(config.get('colors/system/ally_alive'), 0), 50)
        ce = utils.brighten_color(int(config.get('colors/system/enemy_alive'), 0), 50)
        value = '<font color="#{:06x}">{}</font> {} <font color="#{:06x}">{}</font>'.format(ca, a, sign, ce, e)
        return value
    except Exception as ex:
        debug(traceback.format_exc())
        return ''


# TotalHP

from xvm import total_hp

@xvm.export('xvm.total_hp.ally', deterministic=False)
def total_hp_ally():
    return total_hp.ally()

@xvm.export('xvm.total_hp.enemy', deterministic=False)
def total_hp_enemy():
    return total_hp.enemy()

@xvm.export('xvm.total_hp.color', deterministic=False)
def total_hp_color():
    return total_hp.color()

@xvm.export('xvm.total_hp.sign', deterministic=False)
def total_hp_sign():
    return total_hp.sign()

@xvm.export('xvm.total_hp.text', deterministic=False)
def total_hp_text():
    return total_hp.text()

@xvm.export('xvm.total_hp.avgDamage', deterministic=False)
def total_hp_avgDamage(header, dmg_total):
    return "%s%s" % (header, total_hp.avgDamage(dmg_total)) if total_hp.avgDamage(dmg_total) is not None else ''

@xvm.export('xvm.total_hp.mainGun', deterministic=False)
def total_hp_mainGun(header, dmg_total):
    _mainGun = total_hp.mainGun(dmg_total)
    return "%s%s" % (header, _mainGun) if _mainGun is not None else ''

@xvm.export('xvm.total_hp.getAvgDamage', deterministic=False)
def total_hp_getAvgDamage(a, b, dmg_total):
    return a if total_hp.avgDamage(dmg_total) is not None else b

@xvm.export('xvm.total_hp.getMainGun', deterministic=False)
def total_hp_getMainGun(a, b, dmg_total):
    return a if total_hp.mainGun(dmg_total) is not None else b

# xvm2sup

from xvm import xvm2sup

@xvm.export('xvm.xvm2sup')
def xvm2sup_xvm2sup(x=None, default=''):
    res = xvm2sup.xvm2sup(x)
    return res if res is not None else default
