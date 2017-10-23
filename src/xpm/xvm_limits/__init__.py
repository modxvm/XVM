""" XVM (c) https://modxvm.com 2013-2017 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '0.9.20.1',
    'URL':           'https://modxvm.com/',
    'UPDATE_URL':    'https://modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.20.1'],
    # optional
}


#####################################################################
# constants

class XVM_LIMITS_COMMAND(object):
    SET_GOLD_LOCK_STATUS = "xvm_limits.set_gold_lock_status"
    SET_FREEXP_LOCK_STATUS = "xvm_limits.set_freexp_lock_status"


#####################################################################
# imports

import traceback

import BigWorld
import game
from gui.shared import g_eventBus, tooltips
from gui.shared.gui_items import GUI_ITEM_TYPE
from gui.shared.gui_items.Vehicle import Vehicle
from gui.shared.money import Currency
from gui.shared.utils.requesters.StatsRequester import StatsRequester
from gui.Scaleform.daapi.view.lobby.techtree.TechTree import TechTree
from gui.Scaleform.daapi.view.lobby.techtree.Research import Research
from gui.Scaleform.daapi.view.lobby.hangar.TechnicalMaintenance import TechnicalMaintenance
from gui.Scaleform.daapi.view.lobby.PremiumWindow import PremiumWindow
from gui.Scaleform.daapi.view.lobby.store.Shop import Shop
from gui.Scaleform.daapi.view.lobby.recruitWindow.RecruitWindow import RecruitWindow
from gui.Scaleform.daapi.view.lobby.PersonalCase import PersonalCase
from gui.Scaleform.daapi.view.lobby.exchange.ExchangeFreeToTankmanXpWindow import ExchangeFreeToTankmanXpWindow
from gui.Scaleform.daapi.view.lobby.customization.main_view import MainView
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
cfg_hangar_defaultBoughtForCredits = False

gold_enable = True
freeXP_enable = True
TechTree_handler = None
Research_handler = None
TechnicalMaintenance_handler = None
PremiumWindow_handler = None
Shop_handler = None
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
    global cfg_hangar_defaultBoughtForCredits
    cfg_hangar_enableGoldLocker = config.get('hangar/enableGoldLocker', False) == True
    cfg_hangar_enableFreeXpLocker = config.get('hangar/enableFreeXpLocker', False) == True
    cfg_hangar_defaultBoughtForCredits = config.get('hangar/defaultBoughtForCredits', False) == True

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
            handlersInvalidate('_PremiumWindow__onUpdateHandler()', PremiumWindow_handler)
            handlersInvalidate('onGoldChange(0)', RecruitWindow_handler)
            handlersInvalidate('_update()', Shop_handler)
            handlersInvalidate("onClientChanged({'stats': 'gold'})", PersonalCase_handlers)
            handlersInvalidate("_MainView__setBuyingPanelData()", MainView_handler)
            return (None, True)
        elif cmd == XVM_LIMITS_COMMAND.SET_FREEXP_LOCK_STATUS:
            global freeXP_enable
            freeXP_enable = not args[0]
            handlersInvalidate('invalidateFreeXP()', TechTree_handler, Research_handler)
            handlersInvalidate("onClientChanged({'stats': 'freeXP'})", PersonalCase_handlers)
            handlersInvalidate('_ExchangeFreeToTankmanXpWindow__onFreeXpChanged()', ExchangeFreeToTankmanXpWindow_handlers)
            return (None, True)
    except Exception, ex:
        err(traceback.format_exc())
        return (None, True)
    return (None, False)

# run function that updates gold/freeXP status in active handlers
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

# enable or disable active usage of gold (does not affect auto-refill ammo/equip)
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

# by default use credits for equipment
@overrideMethod(TechnicalMaintenance, 'as_setEquipmentS')
def as_setEquipmentS(base, self, installed, setup, modules):
    if cfg_hangar_defaultBoughtForCredits:
        for module in modules:
            if module['compactDescr'] not in setup:
                module['currency'] = Currency.CREDITS
    base(self, installed, setup, modules)

# by default use credits for ammo
@overrideMethod(Vehicle, '_parseShells')
def Vehicle_parseShells(base, self, layoutList, defaultLayoutList, proxy):
    try:
        if proxy is not None:
            invData = proxy.inventory.getItems(GUI_ITEM_TYPE.VEHICLE, self._inventoryID)
            if invData is not None:
                if 'shellsLayout' in invData and self.shellsLayoutIdx not in invData['shellsLayout']:
                    # nothing is saved for this configuration - new gun
                    for n in xrange(0, len(defaultLayoutList), 2):
                        defaultLayoutList[n] = abs(defaultLayoutList[n])
                        if cfg_hangar_defaultBoughtForCredits:
                            defaultLayoutList[n] *= -1
    except Exception as ex:
        err(traceback.format_exc())

    return base(self, layoutList, defaultLayoutList, proxy)


##############################################################
# handlers of windows that use gold / freeXP

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

@registerEvent(TechnicalMaintenance, '_populate')
def TechnicalMaintenance_populate(self, *args, **kwargs):
    global TechnicalMaintenance_handler
    TechnicalMaintenance_handler = self

@registerEvent(TechnicalMaintenance, '_dispose')
def TechnicalMaintenance_dispose(self, *args, **kwargs):
    global TechnicalMaintenance_handler
    TechnicalMaintenance_handler = None

@registerEvent(PremiumWindow, '_populate')
def PremiumWindow_populate(self, *args, **kwargs):
    global PremiumWindow_handler
    PremiumWindow_handler = self

@registerEvent(PremiumWindow, '_dispose')
def PremiumWindow_dispose(self, *args, **kwargs):
    global PremiumWindow_handler
    PremiumWindow_handler = None

@registerEvent(Shop, '_populate')
def Shop_populate(self, *args, **kwargs):
    global Shop_handler
    Shop_handler = self

@registerEvent(Shop, '_dispose')
def Shop_dispose(self, *args, **kwargs):
    global Shop_handler
    Shop_handler = None

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
def tooltips_getUnlockPrice(base, compactDescr, parentCD = None):
    isAvailable, cost, need = base(compactDescr, parentCD)
    if cfg_hangar_enableFreeXpLocker and not freeXP_enable:
        need += dependency.instance(IItemsCache).items.stats.actualFreeXP
    return (isAvailable, cost, need)

# "reimport"
import gui.shared.tooltips.module as tooltips_module
import gui.shared.tooltips.vehicle as tooltips_vehicle
tooltips_module.getUnlockPrice = tooltips.getUnlockPrice
tooltips_vehicle.getUnlockPrice = tooltips.getUnlockPrice

# force call invalidateFreeXP to update actualFreeXP on vehicle change
@overrideMethod(Research, 'onResearchItemsDrawn')
def Research_onResearchItemsDrawn(base, self):
    base(self)
    self.invalidateFreeXP()
