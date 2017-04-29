import time
import traceback
import BigWorld

# Import logger
from xvm_main.python.logger import *

# Import config. Usage example: config.get('definition/author', 'XVM team')
import xvm_main.python.config as config

from xvm import utils

# Date and time

import locale
d = {}
loc = locale.getdefaultlocale()[1]

@xvm.export('xvm.formatDate', deterministic=False)
def xvm_formatDate(formatDate):
    def createDict(value, formatDate):
        global d
        s = time.strftime('%{}'.format(value[0])).decode(loc)
        d[value] = s.title() if value[1] == 'u' else s.lower()
        return formatDate.replace('%{}'.format(value), '{%s}' % value)

    global d
    d = {}
    formatDate = formatDate.decode('utf8').encode(loc)
    if '%au' in formatDate:
        formatDate = createDict('au', formatDate)
    if '%al' in formatDate:
        formatDate = createDict('al', formatDate)
    if '%Au' in formatDate:
        formatDate = createDict('Au', formatDate)
    if '%Al' in formatDate:
        formatDate = createDict('Au', formatDate)
    if '%bu' in formatDate:
        formatDate = createDict('bu', formatDate)
    if '%bl' in formatDate:
        formatDate = createDict('bl', formatDate)
    if '%Bu' in formatDate:
        formatDate = createDict('Bu', formatDate)
    if '%Bl' in formatDate:
        formatDate = createDict('Bl', formatDate)
    t = time.strftime(formatDate).decode(loc)
    return t.format(**d)


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

# Dynamic color

@xvm.export('xvm.dynamic_color_rating', deterministic=False)
def dynamic_color_rating(rating, value):
    return utils.dynamic_color_rating(rating, value)


# TotalHP

from xvm import total_hp

@xvm.export('xvm.total_hp.ally', deterministic=False)
def total_hp_ally(norm=None):
    return total_hp.ally(norm)

@xvm.export('xvm.total_hp.enemy', deterministic=False)
def total_hp_enemy(norm=None):
    return total_hp.enemy(norm)

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
    _avgDamage = total_hp.avgDamage(dmg_total)
    return "%s%s" % (header, _avgDamage) if _avgDamage is not None else None

@xvm.export('xvm.total_hp.mainGun', deterministic=False)
def total_hp_mainGun(header, dmg_total):
    _mainGun = total_hp.mainGun(dmg_total)
    return "%s%s" % (header, _mainGun) if _mainGun is not None else None

@xvm.export('xvm.total_hp.getAvgDamage', deterministic=False)
def total_hp_getAvgDamage(a, b, dmg_total):
    return a if total_hp.avgDamage(dmg_total) is not None else b

@xvm.export('xvm.total_hp.getMainGun', deterministic=False)
def total_hp_getMainGun(a, b, dmg_total):
    return a if total_hp.mainGun(dmg_total) is not None else b


#Screen size

@xvm.export('xvm.screenWidth')
def xvm_screenWidth():
    return BigWorld.screenWidth()


@xvm.export('xvm.screenHeight')
def xvm_screenHeight():
    return BigWorld.screenHeight()


@xvm.export('xvm.screenVCenter')
def xvm_screenVCenter():
    return BigWorld.screenHeight() // 2


@xvm.export('xvm.screenHCenter')
def xvm_screenHCenter():
    return BigWorld.screenWidth() // 2


# xvm2sup

from xvm import xvm2sup

@xvm.export('xvm.xvm2sup')
def xvm2sup_xvm2sup(x=None, default=''):
    res = xvm2sup.xvm2sup(x)
    return res if res is not None else default
