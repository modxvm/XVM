"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2023 XVM Contributors
"""

#
# Imports
#

# stdlib
import logging

# BigWorld
import BigWorld
import game
from gui import shop
from gui.impl import backport
from gui.impl.dialogs.sub_views.top_right.money_balance import MoneyBalance
from gui.impl.lobby.dialogs.full_screen_dialog_view import FullScreenDialogView
from gui.shared import g_eventBus, tooltips
from gui.shared.utils.requesters.StatsRequester import StatsRequester
from gui.Scaleform.daapi.view.lobby.techtree.settings import UNKNOWN_VEHICLE_LEVEL
from gui.Scaleform.daapi.view.lobby.techtree.techtree_page import TechTree
from gui.Scaleform.daapi.view.lobby.techtree.research_page import Research
from gui.Scaleform.daapi.view.lobby.customization.main_view import MainView
from gui.Scaleform.genConsts.CURRENCIES_CONSTANTS import CURRENCIES_CONSTANTS
from gui.shared.formatters import text_styles
from gui.shared.money import Currency
from gui.shared.tooltips.common import HeaderMoneyAndXpTooltipData
from helpers import dependency
from skeletons.gui.shared import IItemsCache
from gui.impl.lobby.crew.dialogs.enlarge_barracks_dialog import EnlargeBarracksDialog

# XFW
from xfw import *

# XVM
from xvm_main.python.consts import XVM_EVENT
from xvm_main.python.logger import *
import xvm_main.python.config as config



#
# Constants
#

class XVM_LIMITS_COMMAND(object):
    SET_GOLD_LOCK_STATUS = "xvm_limits.set_gold_lock_status"
    SET_FREEXP_LOCK_STATUS = "xvm_limits.set_freexp_lock_status"
    SET_CRYSTAL_LOCK_STATUS = "xvm_limits.set_crystal_lock_status"



#
# Configuration
#

cfg_hangar_enableGoldLocker = False
cfg_hangar_enableFreeXpLocker = False
cfg_hangar_enableCrystalLocker = False

def onConfigLoaded(self, e=None):
    global cfg_hangar_enableGoldLocker
    global cfg_hangar_enableFreeXpLocker
    global cfg_hangar_enableCrystalLocker
    cfg_hangar_enableGoldLocker = config.get('hangar/enableGoldLocker', False) == True
    cfg_hangar_enableFreeXpLocker = config.get('hangar/enableFreeXpLocker', False) == True
    cfg_hangar_enableCrystalLocker = config.get('hangar/enableCrystalLocker', False) == True



#
# Handlers/XFW
#

gold_enable = True
freeXP_enable = True
crystal_enable = True


# run function that updates gold/freeXP/crystal status in active handlers
def handlersInvalidate(function, *handlers):
    try:
        handlers_arr = []
        for element in handlers:
            if type(element) in [list, tuple]:
                handlers_arr.extend(element)
            else:
                handlers_arr.append(element)
        for handler in handlers_arr:
            if handler: # is active
                eval('handler.%s' % function)
    except Exception:
        logging.exception('xfw_limits/handlersInvalidate')


def onXfwCommand(cmd, *args):
    try:
        if cmd == XVM_LIMITS_COMMAND.SET_GOLD_LOCK_STATUS:
            global gold_enable
            gold_enable = not args[0]
            handlersInvalidate('invalidateGold()', TechTree_handler, Research_handler)
            handlersInvalidate("_PersonalCase__onClientChanged({'stats': 'gold'})", PersonalCase_handlers)
            handlersInvalidate("onBuyConfirmed(False)", MainView_handler)
            return (None, True)
        elif cmd == XVM_LIMITS_COMMAND.SET_FREEXP_LOCK_STATUS:
            global freeXP_enable
            freeXP_enable = not args[0]
            handlersInvalidate('invalidateFreeXP()', TechTree_handler, Research_handler)
            handlersInvalidate("_PersonalCase__onClientChanged({'stats': 'freeXP'})", PersonalCase_handlers)
            handlersInvalidate('_ExchangeFreeToTankmanXpWindow__onFreeXpChanged()', ExchangeFreeToTankmanXpWindow_handlers)
            return (None, True)
        elif cmd == XVM_LIMITS_COMMAND.SET_CRYSTAL_LOCK_STATUS:
            global crystal_enable
            crystal_enable = not args[0]
            handlersInvalidate("_PersonalCase__onClientChanged({'stats': 'crystal'})", PersonalCase_handlers)
            return (None, True)
    except Exception:
        logging.exception('xfw_limits/onXfwCommand')
        return (None, True)
    return (None, False)




#
# Handlers/Shop
#

# enable or disable active usage of gold
def shop_canBuyGoldForItemThroughWeb(base, itemID, *args, **kwargs):
    if not cfg_hangar_enableGoldLocker or gold_enable:
        return base(itemID, *args, **kwargs)
    return False


def shop_canBuyGoldForVehicleThroughWeb(base, vehicle, *args, **kwargs):
    if not cfg_hangar_enableGoldLocker or gold_enable:
        return base(vehicle, *args, **kwargs)
    return False



#
# Handlers/StatsRequester
#

# enable or disable usage of gold
def StatsRequester_gold(base, self):
    if not cfg_hangar_enableGoldLocker or gold_enable:
        return max(self.actualGold, 0)
    return 0

# enable or disable usage of free experience
def StatsRequester_freeXP(base, self):
    if not cfg_hangar_enableFreeXpLocker or freeXP_enable:
        return max(self.actualFreeXP, 0)
    return 0

# enable or disable usage of bond
def StatsRequester_crystal(base, self):
    if not cfg_hangar_enableCrystalLocker or crystal_enable:
        return max(self.actualCrystal, 0)
    return 0


#
# Handlers/HeaderMoneyAndXpTooltipData
#

def HeaderMoneyAndXpTooltipData_getValue(base, self):
    valueStr = '0'
    if self._btnType == CURRENCIES_CONSTANTS.GOLD:
        valueStr = text_styles.gold(backport.getIntegralFormat(max(self.itemsCache.items.stats.actualGold, 0)))
    elif self._btnType == CURRENCIES_CONSTANTS.CREDITS:
        valueStr = text_styles.credits(backport.getIntegralFormat(max(self.itemsCache.items.stats.actualCredits, 0)))
    elif self._btnType == CURRENCIES_CONSTANTS.CRYSTAL:
        valueStr = text_styles.crystal(backport.getIntegralFormat(max(self.itemsCache.items.stats.actualCrystal, 0)))
    elif self._btnType == CURRENCIES_CONSTANTS.EVENT_COIN:
        valueStr = text_styles.eventCoin(backport.getIntegralFormat(max(self.itemsCache.items.stats.actualEventCoin, 0)))
    elif self._btnType == CURRENCIES_CONSTANTS.FREE_XP:
        valueStr = text_styles.expText(backport.getIntegralFormat(max(self.itemsCache.items.stats.actualFreeXP, 0)))
    return valueStr



#
# Handlers/MoneyBalance
#

def MoneyBalance__setStats(base, self, model):
    base(self, model)
    model.setCredits(int(self._stats.actualMoney.getSignValue(Currency.CREDITS)))
    model.setGold(int(self._stats.actualMoney.getSignValue(Currency.GOLD)))
    model.setCrystals(int(self._stats.actualMoney.getSignValue(Currency.CRYSTAL)))



#
# Handlers/FullScreenDialogView
#

def FullScreenDialogView__setStats(base, self, model):
    base(self, model)
    model.setCredits(int(self._stats.actualMoney.getSignValue(Currency.CREDITS)))
    model.setGolds(int(self._stats.actualMoney.getSignValue(Currency.GOLD)))
    model.setCrystals(int(self._stats.actualMoney.getSignValue(Currency.CRYSTAL)))



#
# Handlers/TechTree
#

TechTree_handler = None

def TechTree_populate(base, self, *args, **kwargs):
    global TechTree_handler
    TechTree_handler = self
    return base(self, *args, **kwargs)

def TechTree_dispose(base, self, *args, **kwargs):
    global TechTree_handler
    TechTree_handler = None
    return base(self, *args, **kwargs)



#
# Handlers/Research
#

Research_handler = None

def Research_populate(base, self, *args, **kwargs):
    global Research_handler
    Research_handler = self
    return base(self, *args, **kwargs)

def Research_dispose(base, self, *args, **kwargs):
    global Research_handler
    Research_handler = None
    return base(self, *args, **kwargs)



#
# Handlers/MainView
#

MainView_handler = None

def MainView_populate(base, self, *args, **kwargs):
    global MainView_handler
    MainView_handler = self
    return base(self, *args, **kwargs)

def MainView_dispose(base, self, *args, **kwargs):
    global MainView_handler
    MainView_handler = None
    return base(self, *args, **kwargs)



#
# Handlers/Tooltips
#

@dependency.replace_none_kwargs(itemsCache=IItemsCache)
def tooltips_getUnlockPrice(base, compactDescr, parentCD=None, vehicleLevel=UNKNOWN_VEHICLE_LEVEL, blueprintCount=0, itemsCache=None):
    isAvailable, cost, need, defCost, discount = base(compactDescr, parentCD, vehicleLevel, blueprintCount, itemsCache=itemsCache)
    if cfg_hangar_enableFreeXpLocker and not freeXP_enable:
        need += itemsCache.items.stats.actualFreeXP
    return (isAvailable, cost, need, defCost, discount)



#
# XFW API
#

__initialized = False

def xfw_module_init():
    global __initialized
    if not __initialized:
        g_eventBus.addListener(XFW_COMMAND.XFW_CMD, onXfwCommand)
        g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, onConfigLoaded)

        overrideMethod(shop, 'canBuyGoldForItemThroughWeb')(shop_canBuyGoldForItemThroughWeb)
        overrideMethod(shop, 'canBuyGoldForVehicleThroughWeb')(shop_canBuyGoldForVehicleThroughWeb)

        overrideMethod(StatsRequester, 'gold')(StatsRequester_gold)
        overrideMethod(StatsRequester, 'freeXP')(StatsRequester_freeXP)
        overrideMethod(StatsRequester, 'crystal')(StatsRequester_crystal)

        overrideMethod(HeaderMoneyAndXpTooltipData, '_getValue')(HeaderMoneyAndXpTooltipData_getValue)

        overrideMethod(MoneyBalance, '_MoneyBalance__setStats')(MoneyBalance__setStats)

        overrideMethod(FullScreenDialogView, '_FullScreenDialogView__setStats')(FullScreenDialogView__setStats)

        overrideMethod(TechTree, '_populate')(TechTree_populate)
        overrideMethod(TechTree, '_dispose')(TechTree_dispose)

        overrideMethod(Research, '_populate')(Research_populate)
        overrideMethod(Research, '_dispose')(Research_dispose)

        overrideMethod(MainView, '_dispose')(MainView_populate)
        overrideMethod(MainView, '_dispose')(MainView_dispose) 

        overrideMethod(tooltips, 'getUnlockPrice')(tooltips_getUnlockPrice)
        import gui.shared.tooltips.module as tooltips_module
        import gui.shared.tooltips.vehicle as tooltips_vehicle
        tooltips_module.getUnlockPrice = tooltips.getUnlockPrice
        tooltips_vehicle.getUnlockPrice = tooltips.getUnlockPrice

        __initialized = True
    

def xfw_module_fini():
    global __initialized
    if __initialized:
        g_eventBus.removeListener(XFW_COMMAND.XFW_CMD, onXfwCommand)
        g_eventBus.removeListener(XVM_EVENT.CONFIG_LOADED, onConfigLoaded)
        __initialized = False


def xfw_is_module_loaded():
    global __initialized
    return __initialized
