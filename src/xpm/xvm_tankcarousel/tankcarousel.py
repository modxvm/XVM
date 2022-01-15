""" XVM (c) https://modxvm.com 2013-2021 """

#####################################################################
# imports

from functools import partial
import traceback

import BigWorld
import game
from constants import QUEUE_TYPE
from gui import GUI_NATIONS_ORDER_INDEX
from gui.shared import g_eventBus
from gui.shared.gui_items.Vehicle import VEHICLE_TYPES_ORDER_INDICES
from gui.shared.utils.requesters import REQ_CRITERIA
from gui.DialogsInterface import showDialog
from gui.Scaleform.framework.managers.containers import POP_UP_CRITERIA
from gui.Scaleform.genConsts.HANGAR_ALIASES import HANGAR_ALIASES
from gui.Scaleform.genConsts.PROFILE_DROPDOWN_KEYS import PROFILE_DROPDOWN_KEYS
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.Scaleform.daapi.view.dialogs import SimpleDialogMeta, I18nConfirmDialogButtons
from gui.Scaleform.daapi.view.lobby.hangar.Hangar import Hangar
import gui.Scaleform.daapi.view.lobby.hangar.hangar_cm_handlers as hangar_cm_handlers
from gui.Scaleform.daapi.view.lobby.hangar.carousels.basic.carousel_data_provider import CarouselDataProvider, HangarCarouselDataProvider, _SUPPLY_ITEMS
from gui.Scaleform.daapi.view.lobby.hangar.carousels.basic.tank_carousel import TankCarousel
from gui.Scaleform.daapi.view.common.vehicle_carousel import carousel_data_provider
from frameworks.wulf import WindowLayer
from helpers import dependency
from skeletons.gui.shared import IItemsCache

from xfw import *
from xfw_actionscript.python import *

from xvm_main.python.consts import *
from xvm_main.python.logger import *
import xvm_main.python.config as config
import xvm_main.python.dossier as dossier
import xvm_main.python.vehinfo as vehinfo
import xvm_main.python.wgutils as wgutils
import xvm_main.python.reserve as reserve
from xvm_main.python.vehinfo_tiers import getTiers
from xvm_main.python.xvm import l10n


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
    g_eventBus.addListener(XFW_COMMAND.XFW_CMD, onXfwCommand)
    g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, update_config)
    update_config()

BigWorld.callback(0, start)

@registerEvent(game, 'fini')
def fini():
    g_eventBus.removeListener(XFW_COMMAND.XFW_CMD, onXfwCommand)
    g_eventBus.removeListener(XVM_EVENT.CONFIG_LOADED, update_config)


#####################################################################
# onXfwCommand

# returns: (result, status)
def onXfwCommand(cmd, *args):
    try:
        if cmd == XVM_CAROUSEL_COMMAND.GET_USED_SLOTS_COUNT:
            return (get_used_slots_count(), True)
        if cmd == XVM_CAROUSEL_COMMAND.GET_TOTAL_SLOTS_COUNT:
            itemsCache = dependency.instance(IItemsCache)
            freeSlots = itemsCache.items.inventory.getFreeSlots(itemsCache.items.stats.vehicleSlots)
            return (freeSlots + get_used_slots_count(), True)
    except Exception, ex:
        err(traceback.format_exc())
        return (None, True)
    return (None, False)


# handlers

XVM_LOBBY_UI_SWF = 'xvm_lobby_ui.swf'

@overrideMethod(Hangar, 'as_setCarouselS')
def _Hangar_as_setCarouselS(base, self, linkage, alias):
    #log('xvm_tankcarousel: Hangar::as_setCarouselS, linkage=%s, alias=%s' % (linkage, alias))

    #do not modify tankcarousel in bootcamp
    if isInBootcamp():
        return base(self, linkage, alias)

    #do not modify tankcarousel in events
    isEvent = self.prbDispatcher.getFunctionalState().isQueueSelected(QUEUE_TYPE.EVENT_BATTLES) if self.prbDispatcher is not None else False
    if isEvent:
        return base(self, linkage, alias)

    #do not modify tankcarousel in battle royale
    isRoyale = self.prbDispatcher.getFunctionalState().isQueueSelected(QUEUE_TYPE.BATTLE_ROYALE) if self.prbDispatcher is not None else False
    if isRoyale:
        return base(self, linkage, alias)

    #in other cases, replace UI linkage with XVMs one
    if swf_loaded_info.swf_loaded_get(XVM_LOBBY_UI_SWF):
        if linkage == HANGAR_ALIASES.TANK_CAROUSEL_UI:
            linkage = 'com.xvm.lobby.ui.tankcarousel::UI_TankCarousel'
    else:
        log('WARNING: as_setCarouselS: ({}) {} is not loaded'.format(linkage, XVM_LOBBY_UI_SWF))
        g_eventBus.removeListener(XFW_EVENT.SWF_LOADED, onSwfLoaded)
        g_eventBus.addListener(XFW_EVENT.SWF_LOADED, onSwfLoaded)

    return base(self, linkage, alias)


def onSwfLoaded(e):
    log('xvm_tankcarousel: onSwfLoaded: {}'.format(e.ctx))
    if e.ctx.lower() == XVM_LOBBY_UI_SWF:
        g_eventBus.removeListener(XFW_EVENT.SWF_LOADED, onSwfLoaded)
        wgutils.reloadHangar()

carousel_config = {}

# added sorting orders for tanks in carousel
@overrideClassMethod(CarouselDataProvider, '_vehicleComparisonKey')
def _CarouselDataProvider_vehicleComparisonKey(base, cls, vehicle):
    try:
        global carousel_config
        if not 'sorting_criteria' in carousel_config:
            return base(vehicle)

        comparisonKey = [
            not vehicle.isEvent,
            not vehicle.isFavorite]

        for sort_criterion in carousel_config['sorting_criteria']:
            if sort_criterion.find('-') == 0:
                sort_criterion = sort_criterion[1:] #remove minus sign
                factor = -1
            else:
                factor = 1

            if sort_criterion in ['battles', 'winRate', 'markOfMastery']:
                itemsCache = dependency.instance(IItemsCache)
                vehicles_stats = itemsCache.items.getAccountDossier().getRandomStats().getVehicles() # battlesCount, wins, markOfMastery, xp
                stats = vehicles_stats.get(vehicle.intCD)
                comparisonKey.append(factor if stats else 0)
                if stats:
                    if sort_criterion == 'battles':
                        comparisonKey.append(stats.battlesCount * factor)
                    elif sort_criterion == 'winRate':
                        comparisonKey.append(float(stats.wins) / stats.battlesCount * factor)
                    elif sort_criterion == 'markOfMastery':
                        comparisonKey.append(stats.markOfMastery * factor)
            elif sort_criterion in ['wtr', 'xtdb', 'xte', 'marksOnGun', 'damageRating']:
                vDossier = dossier.getDossier(PROFILE_DROPDOWN_KEYS.ALL, None, vehicle.intCD)
                comparisonKey.append(factor if vDossier else 0)
                if vDossier and vDossier.get(sort_criterion, None) is not None:
                    comparisonKey.append(vDossier[sort_criterion] * factor)
            elif sort_criterion == 'nation':
                if 'nations_order' in carousel_config and len(carousel_config['nations_order']):
                    custom_nations_order = carousel_config['nations_order']
                    comparisonKey.append(vehicle.nationName not in custom_nations_order)
                    if vehicle.nationName in custom_nations_order:
                        comparisonKey.append(custom_nations_order.index(vehicle.nationName))
                comparisonKey.append(GUI_NATIONS_ORDER_INDEX[vehicle.nationName])
            elif sort_criterion == 'type':
                if 'types_order' in carousel_config and len(carousel_config['types_order']):
                    custom_types_order = carousel_config['types_order']
                    comparisonKey.append(vehicle.type not in custom_types_order)
                    if vehicle.type in custom_types_order:
                        comparisonKey.append(custom_types_order.index(vehicle.type))
                comparisonKey.append(VEHICLE_TYPES_ORDER_INDICES[vehicle.type])
            elif sort_criterion == 'premium':
                comparisonKey.append(int(not vehicle.isPremium) * factor)
            elif sort_criterion == 'level':
                comparisonKey.append(vehicle.level * factor)
            elif sort_criterion == 'maxBattleTier':
                comparisonKey.append(getTiers(vehicle.level, vehicle.type, vehicle.name)[1] * factor)

        comparisonKey.extend([vehicle.buyPrices.itemPrice.price.gold, vehicle.buyPrices.itemPrice.price.credits, vehicle.userName])

        return tuple(comparisonKey)

    except Exception as ex:
        err(traceback.format_exc())

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

@overrideMethod(HangarCarouselDataProvider, '_getSupplyIndices')
def _HangarCarouselDataProvider_getSupplyIndices(base, self):
    supplyIndices = base(self)
    if config.get('hangar/carousel/hideBuySlot'):
        supplyIndices.pop(_SUPPLY_ITEMS.BUY_SLOT)
        self._supplyItems = [x for x in self._supplyItems if not x.get('buySlot', False)]
    if config.get('hangar/carousel/hideRestoreTank'):
        supplyIndices.pop(_SUPPLY_ITEMS.RESTORE_TANK)
        self._supplyItems = [x for x in self._supplyItems if not x.get('restoreTank', False)]
    if config.get('hangar/carousel/hideBuyTank') and self._emptySlotsCount:
        supplyIndices.pop(_SUPPLY_ITEMS.BUY_TANK)
        self._supplyItems = [x for x in self._supplyItems if not x.get('buyTank', False)]
    return supplyIndices

@overrideMethod(carousel_data_provider, '_isLockedBackground')
def _carousel_data_provider_isLockedBackground(base, vState, vStateLvl):
    if not config.get('hangar/carousel/enableLockBackground', True):
        return False
    return base(vState, vStateLvl)

# filter visibility
@registerEvent(TankCarousel, '__init__')
def _TankCarousel__init__(self):
    _usedFilters = tuple(_filter for _filter in self._usedFilters if config.get('hangar/carousel/filters/{}/enabled'.format(_filter), True))
    self._usedFilters = _usedFilters


#####################################################################
# internal

def get_used_slots_count():
    itemsCache = dependency.instance(IItemsCache)
    vehiclesCriteria = REQ_CRITERIA.INVENTORY | ~REQ_CRITERIA.VEHICLE.BATTLE_ROYALE
    return len(itemsCache.items.getVehicles(vehiclesCriteria))

def update_config(*args, **kwargs):
    try:
        global carousel_config
        carousel_config = config.get('hangar/carousel')
    except Exception, ex:
        err(traceback.format_exc())

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
        as_xfw_cmd(XVM_COMMAND.AS_UPDATE_RESERVE, vehinfo.getVehicleInfoDataArray())
        app = getLobbyApp()
        hangar = app.containerManager.getView(WindowLayer.SUB_VIEW,
            criteria={POP_UP_CRITERIA.VIEW_ALIAS: VIEW_ALIAS.LOBBY_HANGAR})
        #log(str(hangar))
        if hangar:
            tankCarousel = hangar.getComponent(hangar._Hangar__currentCarouselAlias)
            if tankCarousel is not None:
                tankCarousel.updateVehicles()
    except Exception as ex:
        err(traceback.format_exc())

hangar_cm_handlers.VehicleContextMenuHandler.confirmReserveVehicle = confirmReserveVehicle
hangar_cm_handlers.VehicleContextMenuHandler.uncheckReserveVehicle = uncheckReserveVehicle
