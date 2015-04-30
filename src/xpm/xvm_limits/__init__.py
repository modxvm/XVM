""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO (mandatory)

XFW_MOD_VERSION = '3.0.0'
XFW_MOD_URL = 'http://www.modxvm.com/'
XFW_MOD_UPDATE_URL = 'http://www.modxvm.com/en/download-xvm/'
XFW_GAME_VERSIONS = ['0.9.7']

#####################################################################
# constants

class XVM_LIMITS_COMMAND(object):
    SET_GOLD_LOCK_STATUS = "xvm_limits.set_gold_lock_status"
    SET_FREEXP_LOCK_STATUS = "xvm_limits.set_freexp_lock_status"


#####################################################################

import BigWorld
import traceback
from xfw import *
from xvm_main.python.logger import *
import xvm_main.python.config as config
import xvm_main.python.userprefs as userprefs

#####################################################################
# initialization/finalization

def start():
    from gui.shared import g_eventBus
    g_eventBus.addListener(XFWCOMMAND.XFW_CMD, onXfwCommand)

def fini():
    from gui.shared import g_eventBus
    g_eventBus.removeListener(XFWCOMMAND.XFW_CMD, onXfwCommand)


#####################################################################
# event handlers

gold_enable = True
freeXP_enable = True
TechTree_handler = None
Research_handler = None
VehicleCustomization_handler = None
TechnicalMaintenance_handler = None
PremiumForm_handler = None
Shop_handler = None
RecruitWindow_handler = None
PersonalCase_handler = None

#enable or disable active usage of gold (does not affect auto-refill ammo/equip)
def StatsRequester_gold(base, self):
    if not config.config['hangar']['enableGoldLocker'] or gold_enable:
        return max(self.actualGold, 0)
    return 0

#enable or disable usage of free experience
def StatsRequester_freeXP(base, self):
    if not config.config['hangar']['enableFreeXpLocker'] or freeXP_enable:
        return max(self.actualFreeXP, 0)
    return 0

#by default use credits for equipment
def FittingItem__init__(base, self, intCompactDescr, proxy = None, isBoughtForCredits = None):
    if isBoughtForCredits is None:
        isBoughtForCredits = config.config['hangar']['defaultBoughtForCredits']
    base(self, intCompactDescr, proxy, isBoughtForCredits)

#by default use credits for ammo
def Vehicle_parseShells(base, self, layoutList, defaultLayoutList, proxy):
    try:
        from gui.shared.gui_items import GUI_ITEM_TYPE
        if proxy is not None:
            invData = proxy.inventory.getItems(GUI_ITEM_TYPE.VEHICLE, self.inventoryID)
            if invData is not None:
                if 'shellsLayout' in invData and self.shellsLayoutIdx not in invData['shellsLayout']:
                    # nothing is saved for this configuration - new gun
                    for n in xrange(0, len(defaultLayoutList), 2):
                        defaultLayoutList[n] = abs(defaultLayoutList[n])
                        if config.config['hangar']['defaultBoughtForCredits']:
                            defaultLayoutList[n] *= -1
    except Exception as ex:
        err(traceback.format_exc())

    return base(self, layoutList, defaultLayoutList, proxy)


##############################################################
# handlers of windows that use gold / freeXP

def TechTree_populate(self, *args, **kwargs):
    global TechTree_handler
    TechTree_handler = self
    
def TechTree_dispose(self, *args, **kwargs):
    global TechTree_handler
    TechTree_handler = None

def Research_populate(self, *args, **kwargs):
    global Research_handler
    Research_handler = self
    
def Research_dispose(self, *args, **kwargs):
    global Research_handler
    Research_handler = None

def VehicleCustomization_populate(self, *args, **kwargs):
    global VehicleCustomization_handler
    VehicleCustomization_handler = self
    
def VehicleCustomization_dispose(self, *args, **kwargs):
    global VehicleCustomization_handler
    VehicleCustomization_handler = None

def TechnicalMaintenance_populate(self, *args, **kwargs):
    global TechnicalMaintenance_handler
    TechnicalMaintenance_handler = self
    
def TechnicalMaintenance_dispose(self, *args, **kwargs):
    global TechnicalMaintenance_handler
    TechnicalMaintenance_handler = None

def PremiumForm_populate(self, *args, **kwargs):
    global PremiumForm_handler
    PremiumForm_handler = self
    
def PremiumForm_dispose(self, *args, **kwargs):
    global PremiumForm_handler
    PremiumForm_handler = None

def Shop_populate(self, *args, **kwargs):
    global Shop_handler
    Shop_handler = self

def Shop_dispose(self, *args, **kwargs):
    global Shop_handler
    Shop_handler = None

def RecruitWindow_populate(self, *args, **kwargs):
    global RecruitWindow_handler
    RecruitWindow_handler = self
    
def RecruitWindow_dispose(self, *args, **kwargs):
    global RecruitWindow_handler
    RecruitWindow_handler = None

def PersonalCase_populate(self, *args, **kwargs):
    global PersonalCase_handler
    PersonalCase_handler = self
    
def PersonalCase_dispose(self, *args, **kwargs):
    global PersonalCase_handler
    PersonalCase_handler = None    

# run function that updates gold/freeXP status in active handlers
def handlerInvalidate(function, *handlers):
    from gui.shared import g_itemsCache
    for handler in handlers:
        if handler: # is active
            eval('handler.%s' % function)


# force getUnlockPrice to look at freeXP (which is affected by lock)
def tooltips_getUnlockPrice(*args, **kwargs):
    try:
        import gui.shared.tooltips as tooltips
        from gui.shared import g_itemsCache as g_itemsCache_orig
        # dirty create same names for use in original function
        class g_itemsCache():
            class items():
                class stats():
                    actualFreeXP = g_itemsCache_orig.items.stats.freeXP
                    unlocks = g_itemsCache_orig.items.stats.unlocks
                    vehiclesXPs = g_itemsCache_orig.items.stats.vehiclesXPs
        tooltips.g_itemsCache = g_itemsCache
    except Exception, ex:
        err(traceback.format_exc())

# force invalidateFreeXP to look at freeXP (which is affected by lock)
def Research_invalidateFreeXP(base, self):
    try:
        if self._isDAAPIInited():
            from gui.shared import g_itemsCache
            from gui.Scaleform.daapi.view.lobby.techtree.Research import Research
            self.as_setFreeXPS(g_itemsCache.items.stats.freeXP)
            super(Research, self).invalidateFreeXP()
    except Exception, ex:
        err(traceback.format_exc())
        base(self)

#####################################################################
# onXfwCommand

# returns: (result, status)
def onXfwCommand(cmd, *args):
    try:
        if cmd == XVM_LIMITS_COMMAND.SET_GOLD_LOCK_STATUS:
            global gold_enable
            gold_enable = not args[0]
            handlerInvalidate('invalidateGold()', TechTree_handler, Research_handler)
            handlerInvalidate('as_setGoldS(g_itemsCache.items.stats.gold)', VehicleCustomization_handler, TechnicalMaintenance_handler, PremiumForm_handler)
            handlerInvalidate('onGoldChange(0)', RecruitWindow_handler)
            handlerInvalidate('_update()', Shop_handler)
            handlerInvalidate("onClientChanged({'stats': 'gold'})", PersonalCase_handler)
            return (None, True)
        elif cmd == XVM_LIMITS_COMMAND.SET_FREEXP_LOCK_STATUS:
            global freeXP_enable
            freeXP_enable = not args[0]
            handlerInvalidate('invalidateFreeXP()', TechTree_handler, Research_handler)
            return (None, True)
    except Exception, ex:
        err(traceback.format_exc())
        return (None, True)
    return (None, False)

#####################################################################
# Register events

def _RegisterEvents():
    start()

    import game
    RegisterEvent(game, 'fini', fini)

    from gui.shared.utils.requesters.StatsRequester import StatsRequester
    OverrideMethod(StatsRequester, 'gold', StatsRequester_gold)
    OverrideMethod(StatsRequester, 'freeXP', StatsRequester_freeXP)

    from gui.shared.gui_items import FittingItem
    OverrideMethod(FittingItem, '__init__', FittingItem__init__)

    from gui.shared.gui_items.Vehicle import Vehicle
    OverrideMethod(Vehicle, '_parseShells', Vehicle_parseShells)

    from gui.Scaleform.daapi.view.lobby.techtree.TechTree import TechTree
    RegisterEvent(TechTree, '_populate', TechTree_populate)
    RegisterEvent(TechTree, '_dispose', TechTree_dispose)

    from gui.Scaleform.daapi.view.lobby.techtree.Research import Research
    RegisterEvent(Research, '_populate', Research_populate)
    RegisterEvent(Research, '_dispose', Research_dispose)

    from gui.Scaleform.daapi.view.lobby.customization.VehicleCustomization import VehicleCustomization
    RegisterEvent(VehicleCustomization, '_populate', VehicleCustomization_populate)
    RegisterEvent(VehicleCustomization, '_dispose', VehicleCustomization_dispose)

    from gui.Scaleform.daapi.view.lobby.hangar.TechnicalMaintenance import TechnicalMaintenance
    RegisterEvent(TechnicalMaintenance, '_populate', TechnicalMaintenance_populate)
    RegisterEvent(TechnicalMaintenance, '_dispose', TechnicalMaintenance_dispose)

    from gui.Scaleform.daapi.view.lobby.PremiumForm import PremiumForm
    RegisterEvent(PremiumForm, '_populate', PremiumForm_populate)
    RegisterEvent(PremiumForm, '_dispose', PremiumForm_dispose)

    from gui.Scaleform.daapi.view.lobby.store.Shop import Shop
    RegisterEvent(Shop, '_populate', Shop_populate)
    RegisterEvent(Shop, '_dispose', Shop_dispose)

    from gui.Scaleform.daapi.view.lobby.recruitWindow.RecruitWindow import RecruitWindow
    RegisterEvent(RecruitWindow, '_populate', RecruitWindow_populate)
    RegisterEvent(RecruitWindow, '_dispose', RecruitWindow_dispose)
    
    from gui.Scaleform.daapi.view.lobby.PersonalCase import PersonalCase
    RegisterEvent(PersonalCase, '_populate', PersonalCase_populate)
    RegisterEvent(PersonalCase, '_dispose', PersonalCase_dispose)

    import gui.shared.tooltips as tooltips
    RegisterEvent(tooltips, 'getUnlockPrice', tooltips_getUnlockPrice, True)

    OverrideMethod(Research, 'invalidateFreeXP', Research_invalidateFreeXP)

BigWorld.callback(0, _RegisterEvents)
