""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '3.1.0',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.12'],
    # optional
}


#####################################################################
# imports

import BigWorld
from debug_utils import LOG_DEBUG
from functools import partial
from operator import attrgetter
from gui import GUI_NATIONS_ORDER_INDEX
from gui.shared import g_itemsCache, REQ_CRITERIA
from gui.shared.gui_items.Vehicle import VEHICLE_TYPES_ORDER_INDICES
from gui.DialogsInterface import showDialog
import gui.Scaleform.daapi.view.lobby.hangar.hangar_cm_handlers as hangar_cm_handlers
from gui.Scaleform.daapi.view.dialogs import SimpleDialogMeta, I18nConfirmDialogButtons
from gui.Scaleform.daapi.view.meta.TankCarouselMeta import TankCarouselMeta
from gui.Scaleform.daapi.view.lobby.hangar.hangar_cm_handlers import VehicleContextMenuHandler

from xfw import *

from xvm_main.python.logger import *
from xvm_main.python.constants import XVM_COMMAND
import xvm_main.python.config as config
from xvm_main.python.vehinfo_tiers import getTiers
import xvm_main.python.vehinfo as vehinfo
from xvm_main.python.xvm import l10n
import xvm_main.python.xvm as xvm

import reserve


#####################################################################
# constants

class VEHICLE(object):
    CHECKRESERVE = 'confirmReserveVehicle'
    UNCHECKRESERVE = 'uncheckReserveVehicle'


#####################################################################
# globals

carousel_handle = None


#####################################################################
# handlers

# added sorting orders for tanks in carousel
@overrideMethod(TankCarouselMeta, 'as_showVehiclesS')
def TankCarouselMeta_as_showVehiclesS(base, self, compactDescrList):
    if config.get('hangar/carousel/enabled'):
        try:
            global carousel_handle
            carousel_handle = self
            myconfig = config.get('hangar/carousel')
            filteredVehs = g_itemsCache.items.getVehicles(REQ_CRITERIA.IN_CD_LIST(compactDescrList))
            vehicles_stats = g_itemsCache.items.getAccountDossier().getRandomStats().getVehicles() # battlesCount, wins, markOfMastery, xp
            
            def sorting(v1, v2):
                if v1.isEvent and not v2.isEvent: return -1
                if not v1.isEvent and v2.isEvent: return 1
                if v1.isFavorite and not v2.isFavorite: return -1
                if not v1.isFavorite and v2.isFavorite: return 1
                if 'sorting_criteria' in myconfig:
                    for sort_criterion in myconfig['sorting_criteria']:
                        if sort_criterion.find('-') == 0:
                            sort_criterion = sort_criterion[1:] #remove minus sign
                            factor = -1
                        else:
                            factor = 1
                        if sort_criterion == 'winRate':
                            v1_stats = vehicles_stats.get(v1.intCD)
                            v2_stats = vehicles_stats.get(v2.intCD)
                            if v1_stats and not v2_stats: return factor
                            if not v1_stats and v2_stats: return -factor
                            if v1_stats and v2_stats:
                                v1_winrate = float(v1_stats.wins) / v1_stats.battlesCount
                                v2_winrate = float(v2_stats.wins) / v2_stats.battlesCount
                                if v1_winrate > v2_winrate: return factor
                                if v1_winrate < v2_winrate: return -factor
                        if sort_criterion == 'nation':
                            if 'nations_order' in myconfig and len(myconfig['nations_order']):
                                custom_nations_order = myconfig['nations_order']
                                if v1.nationName not in custom_nations_order and v2.nationName in custom_nations_order: return 1
                                if v1.nationName in custom_nations_order and v2.nationName not in custom_nations_order: return -1
                                if v1.nationName in custom_nations_order and v2.nationName in custom_nations_order:
                                    if custom_nations_order.index(v1.nationName) > custom_nations_order.index(v2.nationName): return 1
                                    if custom_nations_order.index(v1.nationName) < custom_nations_order.index(v2.nationName): return -1
                            if GUI_NATIONS_ORDER_INDEX[v1.nationName] > GUI_NATIONS_ORDER_INDEX[v2.nationName]: return 1
                            if GUI_NATIONS_ORDER_INDEX[v1.nationName] < GUI_NATIONS_ORDER_INDEX[v2.nationName]: return -1
                        if sort_criterion == 'premium':
                            if not v1.isPremium and v2.isPremium: return factor
                            if v1.isPremium and not v2.isPremium: return -factor
                        if sort_criterion == 'level':
                            if v1.level > v2.level: return factor
                            if v1.level < v2.level: return -factor
                        if sort_criterion == 'maxBattleTier':
                            if getTiers(v1.level, v1.type, v1.name)[1] > getTiers(v2.level, v2.type, v2.name)[1]: return factor
                            if getTiers(v1.level, v1.type, v1.name)[1] < getTiers(v2.level, v2.type, v2.name)[1]: return -factor
                        if sort_criterion == 'type':
                            if 'types_order' in myconfig and len(myconfig['types_order']):
                                custom_types_order = myconfig['types_order']
                                if v1.type not in custom_types_order and v2.type in custom_types_order: return 1
                                if v1.type in custom_types_order and v2.type not in custom_types_order: return -1
                                if v1.type in custom_types_order and v2.type in custom_types_order:
                                    if custom_types_order.index(v1.type) > custom_types_order.index(v2.type): return 1
                                    if custom_types_order.index(v1.type) < custom_types_order.index(v2.type): return -1
                            if VEHICLE_TYPES_ORDER_INDICES[v1.type] > VEHICLE_TYPES_ORDER_INDICES[v2.type]: return 1
                            if VEHICLE_TYPES_ORDER_INDICES[v1.type] < VEHICLE_TYPES_ORDER_INDICES[v2.type]: return -1
                return v1.__cmp__(v2)

            compactDescrList = map(attrgetter('intCD'), sorted(filteredVehs.itervalues(), sorting))

        except Exception as ex:
            err(traceback.format_exc())
    base(self, compactDescrList)


@overrideMethod(VehicleContextMenuHandler, '__init__')
def VehicleContextMenuHandler__init__(base, self, cmProxy, ctx=None):
    if config.get('hangar/carousel/enabled'):
        try:
            super(hangar_cm_handlers.VehicleContextMenuHandler, self).__init__(cmProxy, ctx, {
                hangar_cm_handlers.VEHICLE.INFO: 'showVehicleInfo',
                hangar_cm_handlers.VEHICLE.SELL: 'sellVehicle',
                hangar_cm_handlers.VEHICLE.RESEARCH: 'toResearch',
                hangar_cm_handlers.VEHICLE.CHECK: 'checkFavoriteVehicle',
                hangar_cm_handlers.VEHICLE.UNCHECK: 'uncheckFavoriteVehicle',
                hangar_cm_handlers.VEHICLE.STATS: 'showVehicleStats',
                hangar_cm_handlers.VEHICLE.BUY: 'buyVehicle',
                hangar_cm_handlers.VEHICLE.REMOVE: 'sellVehicle',
                VEHICLE.CHECKRESERVE: VEHICLE.CHECKRESERVE,
                VEHICLE.UNCHECKRESERVE: VEHICLE.UNCHECKRESERVE,
            })
        except Exception as ex:
            err(traceback.format_exc())
    else:
        base(self, cmProxy, ctx=ctx)


@overrideMethod(VehicleContextMenuHandler, '_generateOptions')
def VehicleContextMenuHandler_generateOptions(base, self, ctx = None):
    result = base(self, ctx)
    if config.get('hangar/carousel/enabled'):
        try:
            if reserve.is_reserved(self.vehCD):
                result.insert(-1, self._makeItem(VEHICLE.UNCHECKRESERVE, l10n('uncheck_reserve_menu')))
            else:
                result.insert(-1, self._makeItem(VEHICLE.CHECKRESERVE, l10n('check_reserve_menu')))
        except Exception as ex:
            err(traceback.format_exc())
    return result


#####################################################################
# internal

def confirmReserveVehicle(self):
    showDialog(SimpleDialogMeta(l10n('reserve_confirm_title'), l10n('reserve_confirm_message'), I18nConfirmDialogButtons()), partial(checkReserveVehicle, self.vehCD))


def checkReserveVehicle(vehCD, result):
    if result:
        updateReserve(vehCD, True)


def uncheckReserveVehicle(self):
    updateReserve(self.vehCD, False)


def updateReserve(vehCD, isReserved):
    reserve.set_reserved(vehCD, isReserved)
    vehinfo.updateReserve(vehCD, isReserved)
    as_xfw_cmd(XVM_COMMAND.AS_UPDATE_RESERVE, vehinfo.getVehicleInfoDataStr())
    carousel_handle.showVehicles()


VehicleContextMenuHandler.confirmReserveVehicle = confirmReserveVehicle
VehicleContextMenuHandler.uncheckReserveVehicle = uncheckReserveVehicle
