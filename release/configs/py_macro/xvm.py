"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

# stdlib
import datetime
import locale

# WoT
import BigWorld
from skeletons.gui.app_loader import IAppLoader
from skeletons.account_helpers.settings_core import ISettingsCore
from helpers import dependency

# XFW
from xfw import *

# XVM Main
from xvm_main.logger import *
import xvm_main.config as config

# XVM PyMacro
from xvm import total_hp
from xvm import xvm2sup
from xvm import utils



#
# Globals
#

_default_encoding = locale.getpreferredencoding()
# Fallback to explicit UTF-8 encoding usage on Windows
# if the beta global UTF-8 support is enabled in Region settings
if _default_encoding == 'cp65001':
    _default_encoding = 'utf-8'

# Resolve native method due to Lesta rename (wg_ prefix removal)
firstDayOfWeek = BigWorld.wg_firstDayOfWeek if IS_WG else BigWorld.firstDayOfWeek



#
# Constants
#

_DIRECTIVES = [ 'au', 'al', 'Au', 'Al', 'bu', 'bl', 'Bu', 'Bl', # double
                'a', 'A', 'b', 'B', 'p' ] # single



#
# Macroses
#

# Date and time
# https://docs.python.org/2/library/time.html#time.strftime

@xvm.export('xvm.formatDate', deterministic=False)
def xvm_formatDate(formatDate):
    dt = datetime.datetime.now()
    weekday = (dt.weekday() - firstDayOfWeek() + 7) % 7
    app = dependency.instance(IAppLoader).getApp()
    d = {}

    def getValue(value, isUpper, isLower):
        if value == 'a':
            return app.utilsManager.getWeekDayNames(False, isUpper, isLower)[weekday]
        elif value == 'A':
            return app.utilsManager.getWeekDayNames(True, isUpper, isLower)[weekday]
        elif value == 'b':
            return app.utilsManager.getMonthsNames(False, isUpper, isLower)[dt.month-1]
        elif value == 'B':
            return app.utilsManager.getMonthsNames(True, isUpper, isLower)[dt.month-1]
        elif value == 'p':
            if app.utilsManager.isTwelveHoursFormat():
                return 'AM' if dt.hour < 12 else 'PM'
            else:
                return ''

    def processDirective(value, formatDate):
        directive = '%' + value
        if directive in formatDate:
            isUpper = False
            isLower = False
            if len(value) > 1:
                if value[1] == 'u':
                    isUpper = True
                else:
                    isLower = True
            s = getValue(value[0], isUpper, isLower)
            d[value] = s
            formatDate = formatDate.replace('%{}'.format(value), '{%s}' % value)
        return formatDate

    formatDate = formatDate.decode('utf-8').encode(_default_encoding)
    for directive in _DIRECTIVES:
        formatDate = processDirective(directive, formatDate)
    t = dt.strftime(formatDate).decode(_default_encoding)
    return t.format(**d)


# Dynamic color

@xvm.export('xvm.dynamic_color_rating')
def dynamic_color_rating(rating, value=None):
    return utils.dynamic_color_rating(rating, value)


@xvm.export('xvm.color_rating')
def color_rating(rating, value=None):
    return utils.color_rating(rating, value)


# Converting

@xvm.export('xvm.arabic_to_roman')
def arabic_to_roman(data=None):
    return utils.arabic_to_roman(data)


# TotalHP

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


# Screen size and scale

def getInterfaceScale():
    settingsCore = dependency.instance(ISettingsCore)
    scale = settingsCore.interfaceScale.get()
    return scale


@xvm.export('xvm.screenWidth', deterministic=False)
def xvm_screenWidth():
    scale = getInterfaceScale()
    return int(BigWorld.screenWidth() / scale)


@xvm.export('xvm.screenHeight', deterministic=False)
def xvm_screenHeight():
    scale = getInterfaceScale()
    return int(BigWorld.screenHeight() / scale)


@xvm.export('xvm.screenScale', deterministic=False)
def xvm_screenScale():
    scale = getInterfaceScale()
    return scale


@xvm.export('xvm.screenVCenter', deterministic=False)
def xvm_screenVCenter():
    scale = getInterfaceScale()
    return int(BigWorld.screenHeight() / scale / 2)


@xvm.export('xvm.screenHCenter', deterministic=False)
def xvm_screenHCenter():
    scale = getInterfaceScale()
    return int(BigWorld.screenWidth() / scale / 2)


@xvm.export('xvm.XFromRight', deterministic=False)
def xvm_XFromRight(x=0):
    scale = getInterfaceScale()
    screenWidth = int(BigWorld.screenWidth() / scale)
    try:
        return screenWidth - float(x)
    except ValueError:
        return screenWidth


@xvm.export('xvm.YFromBottom', deterministic=False)
def xvm_YFromBottom(y=0):
    scale = getInterfaceScale()
    screenHeight = int(BigWorld.screenHeight() / scale)
    try:
        return screenHeight - float(y)
    except ValueError:
        return screenHeight


# xvm2sup
# XVM Scale

@xvm.export('xvm.xvm2sup')
def xvm2sup_xvm2sup(x=None, default=''):
    res = xvm2sup.xvm2sup(x)
    return res if res is not None else default
