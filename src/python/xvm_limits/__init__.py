""" XVM (c) https://modxvm.com 2013-2021 """

#####################################################################
# constants

class XVM_LIMITS_COMMAND(object):
    SET_GOLD_LOCK_STATUS = "xvm_limits.set_gold_lock_status"
    SET_FREEXP_LOCK_STATUS = "xvm_limits.set_freexp_lock_status"
    SET_CRYSTAL_LOCK_STATUS = "xvm_limits.set_crystal_lock_status"


#####################################################################
# imports

import traceback

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
from gui.Scaleform.daapi.view.lobby.recruitWindow.RecruitWindow import RecruitWindow
from gui.Scaleform.daapi.view.lobby.PersonalCase import PersonalCase
from gui.Scaleform.daapi.view.lobby.exchange.ExchangeFreeToTankmanXpWindow import ExchangeFreeToTankmanXpWindow
from gui.Scaleform.daapi.view.lobby.customization.main_view import MainView
from gui.Scaleform.genConsts.CURRENCIES_CONSTANTS import CURRENCIES_CONSTANTS
from gui.shared.formatters import text_styles
from gui.shared.money import Currency
from gui.shared.tooltips.common import HeaderMoneyAndXpTooltipData
from helpers import dependency
from skeletons.gui.shared import IItemsCache

from xfw import *

from xvm_main.python.consts import XVM_EVENT
from xvm_main.python.logger import *
import xvm_main.python.config as config


#####################################################################
# globals

cfg_hangar_enableGoldLocker = False
cfg_hangar_enableFreeXpLocker = False
cfg_hangar_enableCrystalLocker = False

gold_enable = True
freeXP_enable = True
crystal_enable = True
TechTree_handler = None
Research_handler = None
TechnicalMaintenance_handler = None
RecruitWindow_handler = None
PersonalCase_handlers = []
ExchangeFreeToTankmanXpWindow_handlers = []
MainView_handler = None


#####################################################################
# initialization/finalization

def start():
    g_eventBus.addListener(XFW_COMMAND.XFW_CMD, onXfwCommand)

BigWorld.callback(0, start)

def onConfigLoaded(self, e=None):
    global cfg_hangar_enableGoldLocker
    global cfg_hangar_enableFreeXpLocker
    global cfg_hangar_enableCrystalLocker
    cfg_hangar_enableGoldLocker = config.get('hangar/enableGoldLocker', False) == True
    cfg_hangar_enableFreeXpLocker = config.get('hangar/enableFreeXpLocker', False) == True
    cfg_hangar_enableCrystalLocker = config.get('hangar/enableCrystalLocker', False) == True

g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, onConfigLoaded)

@registerEvent(game, 'fini')
def fini():
    g_eventBus.removeListener(XFW_COMMAND.XFW_CMD, onXfwCommand)
    g_eventBus.removeListener(XVM_EVENT.CONFIG_LOADED, onConfigLoaded)


#####################################################################
# onXfwCommand

# returns: (result, status)
def onXfwCommand(cmd, *args):
    try:
        if cmd == XVM_LIMITS_COMMAND.SET_GOLD_LOCK_STATUS:
            global gold_enable
            gold_enable = not args[0]
            handlersInvalidate('invalidateGold()', TechTree_handler, Research_handler)
            handlersInvalidate('onGoldChange(0)', TechnicalMaintenance_handler)
            handlersInvalidate('onGoldChange(0)', RecruitWindow_handler)
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
    except Exception, ex:
        err(traceback.format_exc())
        return (None, True)
    return (None, False)

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
    except Exception, ex:
        err(traceback.format_exc())


#####################################################################
# handlers

# enable or disable active usage of gold
@overrideMethod(shop, 'canBuyGoldForItemThroughWeb')
def canBuyGoldForItemThroughWeb(base, itemID, *args, **kwargs):
    if not cfg_hangar_enableGoldLocker or gold_enable:
        return base(itemID, *args, **kwargs)
    return False

@overrideMethod(shop, 'canBuyGoldForVehicleThroughWeb')
def canBuyGoldForVehicleThroughWeb(base, vehicle, *args, **kwargs):
    if not cfg_hangar_enableGoldLocker or gold_enable:
        return base(vehicle, *args, **kwargs)
    return False

# enable or disable usage of gold
@overrideMethod(StatsRequester, 'gold')
def StatsRequester_gold(base, self):
    if not cfg_hangar_enableGoldLocker or gold_enable:
        return max(self.actualGold, 0)
    return 0

# enable or disable usage of free experience
@overrideMethod(StatsRequester, 'freeXP')
def StatsRequester_freeXP(base, self):
    if not cfg_hangar_enableFreeXpLocker or freeXP_enable:
        return max(self.actualFreeXP, 0)
    return 0

# enable or disable usage of bond
@overrideMethod(StatsRequester, 'crystal')
def StatsRequester_crystal(base, self):
    if not cfg_hangar_enableCrystalLocker or crystal_enable:
        return max(self.actualCrystal, 0)
    return 0

@overrideMethod(HeaderMoneyAndXpTooltipData, '_getValue')
def _getValue(base, self):
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

@overrideMethod(MoneyBalance, '_MoneyBalance__setStats')
def MoneyBalance__setStats(base, self, model):
    base(self, model)
    model.setCredits(int(self._stats.actualMoney.getSignValue(Currency.CREDITS)))
    model.setGold(int(self._stats.actualMoney.getSignValue(Currency.GOLD)))
    model.setCrystals(int(self._stats.actualMoney.getSignValue(Currency.CRYSTAL)))

@overrideMethod(FullScreenDialogView, '_FullScreenDialogView__setStats')
def FullScreenDialogView__setStats(base, self, model):
    base(self, model)
    model.setCredits(int(self._stats.actualMoney.getSignValue(Currency.CREDITS)))
    model.setGolds(int(self._stats.actualMoney.getSignValue(Currency.GOLD)))
    model.setCrystals(int(self._stats.actualMoney.getSignValue(Currency.CRYSTAL)))

##############################################################
# handlers of windows that use gold/freeXP/crystal

@registerEvent(TechTree, '_populate')
def TechTree_populate(self, *args, **kwargs):
    global TechTree_handler
    TechTree_handler = self

@registerEvent(TechTree, '_dispose')
def TechTree_dispose(self, *args, **kwargs):
    global TechTree_handler
    TechTree_handler = None

@registerEvent(Research, '_populate')
def Research_populate(self, *args, **kwargs):
    global Research_handler
    Research_handler = self

@registerEvent(Research, '_dispose')
def Research_dispose(self, *args, **kwargs):
    global Research_handler
    Research_handler = None

@registerEvent(RecruitWindow, '_populate')
def RecruitWindow_populate(self, *args, **kwargs):
    global RecruitWindow_handler
    RecruitWindow_handler = self

@registerEvent(RecruitWindow, '_dispose')
def RecruitWindow_dispose(self, *args, **kwargs):
    global RecruitWindow_handler
    RecruitWindow_handler = None

@registerEvent(PersonalCase, '_populate')
def PersonalCase_populate(self, *args, **kwargs):
    global PersonalCase_handlers
    PersonalCase_handlers.append(self)

@registerEvent(PersonalCase, '_dispose')
def PersonalCase_dispose(self, *args, **kwargs):
    global PersonalCase_handlers
    if self in PersonalCase_handlers:
        PersonalCase_handlers.remove(self)
    else:
        err('PersonalCase window is disposed without being populated')

@registerEvent(ExchangeFreeToTankmanXpWindow, '_populate')
def ExchangeFreeToTankmanXpWindow_populate(self, *args, **kwargs):
    global ExchangeFreeToTankmanXpWindow_handlers
    ExchangeFreeToTankmanXpWindow_handlers.append(self)

@registerEvent(ExchangeFreeToTankmanXpWindow, '_dispose')
def ExchangeFreeToTankmanXpWindow_dispose(self, *args, **kwargs):
    global ExchangeFreeToTankmanXpWindow_handlers
    if self in ExchangeFreeToTankmanXpWindow_handlers:
        ExchangeFreeToTankmanXpWindow_handlers.remove(self)
    else:
        err('ExchangeFreeToTankmanXpWindow window is disposed without being populated')

@registerEvent(MainView, '_populate')
def MainView_populate(self, *args, **kwargs):
    global MainView_handler
    MainView_handler = self

@registerEvent(MainView, '_dispose')
def MainView_dispose(self, *args, **kwargs):
    global MainView_handler
    MainView_handler = None

@overrideMethod(tooltips, 'getUnlockPrice')
@dependency.replace_none_kwargs(itemsCache=IItemsCache)
def getUnlockPrice(base, compactDescr, parentCD = None, vehicleLevel = UNKNOWN_VEHICLE_LEVEL, itemsCache = None):
    isAvailable, cost, need, defCost, discount = base(compactDescr, parentCD, vehicleLevel)
    if cfg_hangar_enableFreeXpLocker and not freeXP_enable:
        need += itemsCache.items.stats.actualFreeXP
    return (isAvailable, cost, need, defCost, discount)

# "reimport"
import gui.shared.tooltips.module as tooltips_module
import gui.shared.tooltips.vehicle as tooltips_vehicle
tooltips_module.getUnlockPrice = tooltips.getUnlockPrice
tooltips_vehicle.getUnlockPrice = tooltips.getUnlockPrice

# force call invalidateFreeXP to update actualFreeXP on vehicle change
# TODO:1.4.1
#@overrideMethod(Research, 'onResearchItemsDrawn')
#def Research_onResearchItemsDrawn(base, self):
#    base(self)
#    self.invalidateFreeXP()
