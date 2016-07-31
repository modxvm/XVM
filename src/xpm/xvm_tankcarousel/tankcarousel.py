""" XVM (c) www.modxvm.com 2013-2016 """

#####################################################################
# imports

from functools import partial
from operator import attrgetter
import weakref

import BigWorld
import game
from gui import GUI_NATIONS_ORDER_INDEX
from gui.shared import g_eventBus, g_itemsCache
from gui.shared.gui_items.Vehicle import VEHICLE_TYPES_ORDER_INDICES
from gui.shared.utils.requesters import REQ_CRITERIA
from gui.DialogsInterface import showDialog
from gui.Scaleform.framework import ViewTypes
from gui.Scaleform.framework.managers.containers import POP_UP_CRITERIA
from gui.Scaleform.genConsts.HANGAR_ALIASES import HANGAR_ALIASES
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.Scaleform.daapi.view.dialogs import SimpleDialogMeta, I18nConfirmDialogButtons
import gui.Scaleform.daapi.view.lobby.hangar.hangar_cm_handlers as hangar_cm_handlers
from gui.Scaleform.daapi.view.lobby.hangar.carousels.basic.carousel_data_provider import CarouselDataProvider, _SUPPLY_ITEMS

from xfw import *

from xvm_main.python.consts import XVM_COMMAND
from xvm_main.python.logger import *
import xvm_main.python.config as config
from xvm_main.python.vehinfo_tiers import getTiers
import xvm_main.python.vehinfo as vehinfo
from xvm_main.python.xvm import l10n

import reserve


#####################################################################
# constants

class XVM_CAROUSEL_COMMAND(object):
    GET_USED_SLOTS_COUNT = 'xvm_carousel.get_used_slots_count'
    GET_TOTAL_SLOTS_COUNT = 'xvm_carousel.get_total_slots_count'

class VEHICLE(object):
    CHECKRESERVE = 'confirmReserveVehicle'
    UNCHECKRESERVE = 'uncheckReserveVehicle'


#####################################################################
# initialization/finalization

def start():
    g_eventBus.addListener(XFWCOMMAND.XFW_CMD, onXfwCommand)

BigWorld.callback(0, start)

@registerEvent(game, 'fini')
def fini():
    g_eventBus.removeListener(XFWCOMMAND.XFW_CMD, onXfwCommand)

HANGAR_ALIASES.TANK_CAROUSEL_UI = 'com.xvm.lobby.ui.tankcarousel::UI_TankCarousel'
HANGAR_ALIASES.FALLOUT_TANK_CAROUSEL_UI = 'com.xvm.lobby.ui.tankcarousel::UI_FalloutTankCarousel'


#####################################################################
# onXfwCommand

# returns: (result, status)
def onXfwCommand(cmd, *args):
    try:
        if cmd == XVM_CAROUSEL_COMMAND.GET_USED_SLOTS_COUNT:
            return (len(g_itemsCache.items.getVehicles(REQ_CRITERIA.INVENTORY)), True)
        if cmd == XVM_CAROUSEL_COMMAND.GET_TOTAL_SLOTS_COUNT:
            return (g_itemsCache.items.stats.vehicleSlots, True)
    except Exception, ex:
        err(traceback.format_exc())
        return (None, True)
    return (None, False)


#####################################################################
# handlers

# added sorting orders for tanks in carousel
# TODO:0.9.15.1
#@overrideMethod(TankCarouselMeta, 'as_showVehiclesS')
def TankCarouselMeta_as_showVehiclesS(base, self, compactDescrList):
    try:
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

@overrideMethod(hangar_cm_handlers.SimpleVehicleCMHandler, '__init__')
def _SimpleVehicleCMHandler__init__(base, self, cmProxy, ctx=None, handlers = None):
    try:
        if handlers:
            handlers.update({
                VEHICLE.CHECKRESERVE: VEHICLE.CHECKRESERVE,
                VEHICLE.UNCHECKRESERVE: VEHICLE.UNCHECKRESERVE})
        base(self, cmProxy, ctx, handlers)
    except Exception as ex:
        err(traceback.format_exc())

@overrideMethod(hangar_cm_handlers.VehicleContextMenuHandler, '_generateOptions')
def _VehicleContextMenuHandler_generateOptions(base, self, ctx = None):
    result = base(self, ctx)
    try:
        if reserve.is_reserved(self.vehCD):
            result.insert(-1, self._makeItem(VEHICLE.UNCHECKRESERVE, l10n('uncheck_reserve_menu')))
        else:
            result.insert(-1, self._makeItem(VEHICLE.CHECKRESERVE, l10n('check_reserve_menu')))
    except Exception as ex:
        err(traceback.format_exc())
    return result

@overrideMethod(CarouselDataProvider, '_CarouselDataProvider__getSupplyIndices')
def _CarouselDataProvider__getSupplyIndices(base, self):
    supplyIndices = base(self)
    if config.get('hangar/carousel/hideBuySlot'):
        supplyIndices.pop(_SUPPLY_ITEMS.BUY_SLOT)
        self._supplyItems = [x for x in self._supplyItems if not x.get('buySlot', False)]
    if config.get('hangar/carousel/hideBuyTank') and self._emptySlotsCount:
        supplyIndices.pop(_SUPPLY_ITEMS.BUY_TANK)
        self._supplyItems = [x for x in self._supplyItems if not x.get('buyTank', False)]
    return supplyIndices


#####################################################################
# internal

def confirmReserveVehicle(self):
    try:
        showDialog(SimpleDialogMeta(l10n('reserve_confirm_title'), l10n('reserve_confirm_message'), I18nConfirmDialogButtons()), partial(checkReserveVehicle, self.vehCD))
    except Exception as ex:
        err(traceback.format_exc())

def checkReserveVehicle(vehCD, result):
    try:
        if result:
            updateReserve(vehCD, True)
    except Exception as ex:
        err(traceback.format_exc())

def uncheckReserveVehicle(self):
    try:
        updateReserve(self.vehCD, False)
    except Exception as ex:
        err(traceback.format_exc())

def updateReserve(vehCD, isReserved):
    try:
        reserve.set_reserved(vehCD, isReserved)
        vehinfo.updateReserve(vehCD, isReserved)
        as_xfw_cmd(XVM_COMMAND.AS_UPDATE_RESERVE, vehinfo.getVehicleInfoDataArray())
        app = getLobbyApp()
        hangar = app.containerManager.getView(ViewTypes.LOBBY_SUB,
            criteria={POP_UP_CRITERIA.VIEW_ALIAS: VIEW_ALIAS.LOBBY_HANGAR})
        log(str(hangar))
        if hangar.tankCarousel is not None:
            hangar.tankCarousel.updateVehicles()
    except Exception as ex:
        err(traceback.format_exc())

hangar_cm_handlers.VehicleContextMenuHandler.confirmReserveVehicle = confirmReserveVehicle
hangar_cm_handlers.VehicleContextMenuHandler.uncheckReserveVehicle = uncheckReserveVehicle
