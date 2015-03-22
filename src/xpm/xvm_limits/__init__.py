""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO (mandatory)

XFW_MOD_VERSION = '2.0.0'
XFW_MOD_URL = 'http://www.modxvm.com/'
XFW_MOD_UPDATE_URL = 'http://www.modxvm.com/en/download-xvm/'
XFW_GAME_VERSIONS = ['0.9.6','0.9.7']

#####################################################################

import BigWorld

from xfw import *
from xvm_main.python.logger import *
import xvm_main.python.config as config

#####################################################################
# event handlers

gold_enable = 1
freeXP_enable = 1

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

#####################################################################
# Register events

def _RegisterEvents():
    from gui.shared.utils.requesters.StatsRequester import StatsRequester
    OverrideMethod(StatsRequester, 'gold', StatsRequester_gold)
    OverrideMethod(StatsRequester, 'freeXP', StatsRequester_freeXP)

    from gui.shared.gui_items import FittingItem
    OverrideMethod(FittingItem, '__init__', FittingItem__init__)

    from gui.shared.gui_items.Vehicle import Vehicle
    OverrideMethod(Vehicle, '_parseShells', Vehicle_parseShells)

BigWorld.callback(0, _RegisterEvents)
