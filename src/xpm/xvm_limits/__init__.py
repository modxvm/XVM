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

#####################################################################
# event handlers

gold_enable = 1
freeXP_enable = 1

#enable or disable active usage of gold (does not affect auto-refill ammo/equip)
@property
def StatsRequester_gold(self):
    if gold_enable:
        return max(self.actualGold, 0)
    return 0

#enable or disable usage of free experience
@property
def StatsRequester_freeXP(self):
    if freeXP_enable:
        return max(self.actualFreeXP, 0)
    return 0

#by default use credits for equipment
def FittingItem__init__(base, self, intCompactDescr, proxy = None, isBoughtForCredits = True):
    base(self, intCompactDescr, proxy, isBoughtForCredits)

#by default use credits for ammo
def Vehicle_parseShells(base, self, layoutList, defaultLayoutList, proxy):
    try:
        from gui.shared.gui_items import GUI_ITEM_TYPE
        from account_shared import LayoutIterator
        from gui.shared.gui_items.vehicle_modules import Shell
        invData = dict()
        if proxy is not None:
            invDataTmp = proxy.inventory.getItems(GUI_ITEM_TYPE.VEHICLE, self.inventoryID)
            if invDataTmp is not None:
                invData = invDataTmp
        gun_is_new = False
        if 'shellsLayout' in invData and self.shellsLayoutIdx not in invData['shellsLayout']: #nothing is saved for this configuration
            gun_is_new = True
        shellsDict = dict(((cd, count) for cd, count, _ in LayoutIterator(layoutList)))
        defaultsDict = dict(((cd, (count, isBoughtForCredits)) for cd, count, isBoughtForCredits in LayoutIterator(defaultLayoutList)))
        layoutList = list(layoutList)
        for shot in self.descriptor.gun['shots']:
            cd = shot['shell']['compactDescr']
            if cd not in shellsDict:
                layoutList.extend([cd, 0])

        result = list()
        for idx, (intCD, count, _) in enumerate(LayoutIterator(layoutList)):
            defaultCount, isBoughtForCredits = defaultsDict.get(intCD, (0, False))
            result.append(Shell(intCD, count, defaultCount, proxy, isBoughtForCredits or gun_is_new))
        return result
    except Exception as ex:
        err(traceback.format_exc())
        return base(self, layoutList, defaultLayoutList, proxy)

#####################################################################
# Register events

def _RegisterEvents():
    from gui.shared.utils.requesters.StatsRequester import StatsRequester
    StatsRequester.gold = StatsRequester_gold
    StatsRequester.freeXP = StatsRequester_freeXP
    from gui.shared.gui_items import FittingItem
    OverrideMethod(FittingItem, '__init__', FittingItem__init__)
    from gui.shared.gui_items.Vehicle import Vehicle
    OverrideMethod(Vehicle, '_parseShells', Vehicle_parseShells)

BigWorld.callback(0, _RegisterEvents)
