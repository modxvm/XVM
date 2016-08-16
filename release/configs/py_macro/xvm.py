# Import from config file

from xvm_main.python.logger import *
import xvm_main.python.config as config

# Example: config.get('definition/author', 'XVM team')

from xvm import utils

# Team Strength

@xvm.export('xvm.team_strength')
def xvm_team_strength(a, e):
    try:
        if a == '' or e == '':
            return ''
        sign = '&gt;' if float(a) > float(e) else '&lt;' if float(a) < float(e) else '='
        ca = utils.brighten_color(int(config.get('colors/system/ally_alive'), 0), 50)
        ce = utils.brighten_color(int(config.get('colors/system/enemy_alive'), 0), 50)
        value = '<font color="#{:06x}">{}</font> {} <font color="#{:06x}">{}</font>'.format(ca, a, sign, ce, e)
        return value
    except Exception as ex:
        debug(ex)
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

# xvm2sup

from xvm import xvm2sup

@xvm.export('xvm.xvm2sup')
def xvm2sup_xvm2sup(x=None):
    return xvm2sup.xvm2sup(x)
