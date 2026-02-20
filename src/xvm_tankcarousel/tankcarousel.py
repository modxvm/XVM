"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

# stdlib
import functools
import logging

# BigWorld
import BigWorld
import game
import gui.Scaleform.daapi.view.lobby.hangar.hangar_cm_handlers as hangar_cm_handlers
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
from gui.Scaleform.daapi.view.lobby.hangar.carousels.basic.carousel_data_provider import CarouselDataProvider, HangarCarouselDataProvider, _SUPPLY_ITEMS
from gui.Scaleform.daapi.view.lobby.hangar.carousels.basic.tank_carousel import TankCarousel
from gui.Scaleform.daapi.view.common.vehicle_carousel import carousel_data_provider
from frameworks.wulf import WindowLayer
from helpers import dependency
from skeletons.gui.game_control import IBattlePassController
from skeletons.gui.shared import IItemsCache

# XFW
from xfw import *

# XFW ActionScript
from xvm_actionscript import *

# XVM Main
from xvm_main.consts import *
import xvm_main.config as config
import xvm_main.dossier as dossier
import xvm_main.vehinfo as vehinfo
import xvm_main.wgutils as wgutils
import xvm_main.reserve as reserve
from xvm_main.vehinfo_tiers import getTiers
from xvm_main.utils import l10n

# XVM TankCarousel
from .consts import XVM_LOBBY_SWF_FILENAME, AS_SYMBOLS, XVM_CAROUSEL_COMMAND, VEHICLE, VEHICLE_FAVOURITE_OPTIONS



#
# Globals
#

carouselConfig = {}



#
# Configuration
#

def onConfigUpdated(*args, **kwargs):
    try:
        global carouselConfig
        carouselConfig = config.get('hangar/carousel')
    except Exception:
        logging.getLogger('XVM/TankCarousel').exception('onConfigUpdated')



#
# Handlers/XFW
#

# returns: (result, status)
def onXfwCommand(cmd, *args):
    try:
        if cmd == XVM_CAROUSEL_COMMAND.GET_USED_SLOTS_COUNT:
            return (get_used_slots_count(), True)
        if cmd == XVM_CAROUSEL_COMMAND.GET_TOTAL_SLOTS_COUNT:
            itemsCache = dependency.instance(IItemsCache)
            freeSlots = itemsCache.items.inventory.getFreeSlots(itemsCache.items.stats.vehicleSlots)
            return (freeSlots + get_used_slots_count(), True)
    except Exception:
        logging.getLogger('XVM/TankCarousel').exception('onXfwCommand')
        return (None, True)
    return (None, False)


def onSwfLoaded(e):
    logging.getLogger('XVM/TankCarousel').info('xvm_tankcarousel: onSwfLoaded: {}'.format(e.ctx))
    if e.ctx.lower() == XVM_LOBBY_SWF_FILENAME:
        g_eventBus.removeListener(XFW_EVENT.SWF_LOADED, onSwfLoaded)
        wgutils.reloadHangar()



#
# Handlers/CM
#

def _SimpleVehicleCMHandler__init__(base, self, cmProxy, ctx=None, handlers=None, *args, **kwargs):
    try:
        if handlers:
            handlers.update({
                VEHICLE.CHECK_RESERVE: VEHICLE.CHECK_RESERVE,
                VEHICLE.UNCHECK_RESERVE: VEHICLE.UNCHECK_RESERVE})
        base(self, cmProxy, ctx, handlers)
    except Exception:
        logging.getLogger('XVM/TankCarousel').exception('_SimpleVehicleCMHandler__init__')


def _VehicleContextMenuHandler_generateOptions(base, self, ctx=None, *args, **kwargs):
    options = base(self, ctx)
    try:
        setFavouriteOptionIdx = next((index for index, option in enumerate(options) if option.get('id') in VEHICLE_FAVOURITE_OPTIONS), len(options))
        if reserve.is_reserved(self.vehCD):
            options.insert(setFavouriteOptionIdx, self._makeItem(VEHICLE.UNCHECK_RESERVE, l10n('uncheck_reserve_menu')))
        else:
            options.insert(setFavouriteOptionIdx, self._makeItem(VEHICLE.CHECK_RESERVE, l10n('check_reserve_menu')))
    except Exception:
        logging.getLogger('XVM/TankCarousel').exception('_VehicleContextMenuHandler_generateOptions')
    return options


def confirmReserveVehicle(self):
    try:
        dialog = SimpleDialogMeta(l10n('reserve_confirm_title'), l10n('reserve_confirm_message'), I18nConfirmDialogButtons())
        callback = functools.partial(checkReserveVehicle, self.vehCD)
        showDialog(dialog, callback)
    except Exception:
        logging.getLogger('XVM/TankCarousel').exception('confirmReserveVehicle')


def checkReserveVehicle(vehCD, result):
    try:
        if result:
            updateReserve(vehCD, True)
    except Exception:
        logging.getLogger('XVM/TankCarousel').exception('checkReserveVehicle')


def uncheckReserveVehicle(self):
    try:
        updateReserve(self.vehCD, False)
    except Exception:
        logging.getLogger('XVM/TankCarousel').exception('uncheckReserveVehicle')


def updateReserve(vehCD, isReserved):
    try:
        reserve.set_reserved(vehCD, isReserved)
        as_xfw_cmd(XVM_COMMAND.AS_UPDATE_RESERVE, vehinfo.getVehicleInfoDataArray())
        app = getLobbyApp()
        criteria = {POP_UP_CRITERIA.VIEW_ALIAS: VIEW_ALIAS.LOBBY_HANGAR}
        hangar = app.containerManager.getView(WindowLayer.SUB_VIEW, criteria=criteria)
        if hangar:
            alias = hangar._Hangar__currentCarouselAlias
            tankCarousel = hangar.getComponent(alias)
            if tankCarousel is not None:
                tankCarousel.updateVehicles()
    except Exception:
        logging.getLogger('XVM/TankCarousel').exception('updateReserve')



#
# Handlers/Hangar
#

def _Hangar_as_setCarouselS(base, self, linkage, alias):
    # logging.getLogger('XVM/TankCarousel').info('xvm_tankcarousel: Hangar::as_setCarouselS, linkage=%s, alias=%s' % (linkage, alias))

    # Do not modify tankcarousel in events
    isEvent = self.prbDispatcher.getFunctionalState().isQueueSelected(QUEUE_TYPE.EVENT_BATTLES) if self.prbDispatcher is not None else False
    if isEvent:
        return base(self, linkage, alias)

    # Do not modify tankcarousel in battle royale
    isRoyale = self.prbDispatcher.getFunctionalState().isQueueSelected(QUEUE_TYPE.BATTLE_ROYALE) if self.prbDispatcher is not None else False
    if isRoyale:
        return base(self, linkage, alias)

    # In other cases, replace UI linkage with XVMs one
    if swf_loaded_info.swf_loaded_get(XVM_LOBBY_SWF_FILENAME):
        if linkage == HANGAR_ALIASES.TANK_CAROUSEL_UI:
            linkage = AS_SYMBOLS.AS_XVM_TANK_CAROUSEL
    else:
        logging.getLogger('XVM/TankCarousel').warning('as_setCarouselS: (%s) %s is not loaded', linkage, XVM_LOBBY_SWF_FILENAME)
        g_eventBus.removeListener(XFW_EVENT.SWF_LOADED, onSwfLoaded)
        g_eventBus.addListener(XFW_EVENT.SWF_LOADED, onSwfLoaded)

    return base(self, linkage, alias)


# added sorting orders for tanks in carousel
def _CarouselDataProvider_vehicleComparisonKey(base, cls, vehicle):
    try:
        global carouselConfig
        if not 'sorting_criteria' in carouselConfig:
            return base(vehicle)

        comparisonKey = [not vehicle.isEvent, not vehicle.isFavorite]

        for sortingCriteria in carouselConfig['sorting_criteria']:
            if sortingCriteria.find('-') == 0:
                sortingCriteria = sortingCriteria[1:] # remove minus sign
                factor = -1
            else:
                factor = 1

            if sortingCriteria in ['battles', 'winRate', 'markOfMastery']:
                itemsCache = dependency.instance(IItemsCache)
                vehicles_stats = itemsCache.items.getAccountDossier().getRandomStats().getVehicles() # battlesCount, wins, markOfMastery, xp
                stats = vehicles_stats.get(vehicle.intCD)
                comparisonKey.append(factor if stats else 0)
                if stats:
                    if sortingCriteria == 'battles':
                        comparisonKey.append(stats.battlesCount * factor)
                    elif sortingCriteria == 'winRate':
                        comparisonKey.append(float(stats.wins) / stats.battlesCount * factor)
                    elif sortingCriteria == 'markOfMastery':
                        comparisonKey.append(stats.markOfMastery * factor)
            elif sortingCriteria in ['wtr', 'xtdb', 'xte', 'marksOnGun', 'damageRating']:
                vDossier = dossier.getDossier(PROFILE_DROPDOWN_KEYS.ALL, None, vehicle.intCD)
                comparisonKey.append(factor if vDossier else 0)
                if vDossier and vDossier.get(sortingCriteria, None) is not None:
                    comparisonKey.append(vDossier[sortingCriteria] * factor)
            elif sortingCriteria == 'nation':
                if 'nations_order' in carouselConfig and len(carouselConfig['nations_order']):
                    custom_nations_order = carouselConfig['nations_order']
                    comparisonKey.append(vehicle.nationName not in custom_nations_order)
                    if vehicle.nationName in custom_nations_order:
                        comparisonKey.append(custom_nations_order.index(vehicle.nationName))
                comparisonKey.append(GUI_NATIONS_ORDER_INDEX[vehicle.nationName])
            elif sortingCriteria == 'type':
                if 'types_order' in carouselConfig and len(carouselConfig['types_order']):
                    custom_types_order = carouselConfig['types_order']
                    comparisonKey.append(vehicle.type not in custom_types_order)
                    if vehicle.type in custom_types_order:
                        comparisonKey.append(custom_types_order.index(vehicle.type))
                comparisonKey.append(VEHICLE_TYPES_ORDER_INDICES[vehicle.type])
            elif sortingCriteria == 'premium':
                comparisonKey.append(int(not vehicle.isPremium) * factor)
            elif sortingCriteria == 'level':
                comparisonKey.append(vehicle.level * factor)
            elif sortingCriteria == 'maxBattleTier':
                comparisonKey.append(getTiers(vehicle.level, vehicle.type, vehicle.name)[1] * factor)
            elif sortingCriteria == 'battlePassPoints':
                battlePassController = dependency.instance(IBattlePassController)
                battlePassAvailable = battlePassController.isVisible()
                comparisonKey.append(int(battlePassAvailable) * factor)
                progression = battlePassController.getVehicleProgression(vehicle.intCD)[0] * factor if battlePassAvailable else 0
                comparisonKey.append(progression)

        comparisonKey.extend([
            vehicle.buyPrices.itemPrice.price.gold or 0,
            vehicle.buyPrices.itemPrice.price.credits or 0,
            vehicle.userName
        ])

        return tuple(comparisonKey)

    except Exception:
        logging.getLogger('XVM/TankCarousel').exception('_CarouselDataProvider_vehicleComparisonKey')


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

def _carousel_data_provider_isLockedBackground(base, vState, vStateLvl):
    if not config.get('hangar/carousel/enableLockBackground', True):
        return False
    return base(vState, vStateLvl)

# Handle filter visibility
def _TankCarousel__init__(self):
    _usedFilters = tuple(_filter for _filter in self._usedFilters if config.get('hangar/carousel/filters/{}/enabled'.format(_filter), True))
    self._usedFilters = _usedFilters



#
# Helpers
#

def get_used_slots_count():
    itemsCache = dependency.instance(IItemsCache)
    vehiclesCriteria = REQ_CRITERIA.INVENTORY | ~REQ_CRITERIA.VEHICLE.BATTLE_ROYALE
    return len(itemsCache.items.getVehicles(vehiclesCriteria))



#
# Initialization
#

def init():
    g_eventBus.addListener(XFW_COMMAND.XFW_CMD, onXfwCommand)
    g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, onConfigUpdated)

    overrideMethod(Hangar, 'as_setCarouselS')(_Hangar_as_setCarouselS)
    overrideClassMethod(CarouselDataProvider, '_vehicleComparisonKey')(_CarouselDataProvider_vehicleComparisonKey)
    overrideMethod(hangar_cm_handlers.SimpleVehicleCMHandler, '__init__')(_SimpleVehicleCMHandler__init__)
    overrideMethod(hangar_cm_handlers.VehicleContextMenuHandler, '_generateOptions')(_VehicleContextMenuHandler_generateOptions)
    overrideMethod(HangarCarouselDataProvider, '_getSupplyIndices')(_HangarCarouselDataProvider_getSupplyIndices)
    overrideMethod(carousel_data_provider, '_isLockedBackground')(_carousel_data_provider_isLockedBackground)
    registerEvent(TankCarousel, '__init__')(_TankCarousel__init__)

    hangar_cm_handlers.VehicleContextMenuHandler.confirmReserveVehicle = confirmReserveVehicle
    hangar_cm_handlers.VehicleContextMenuHandler.uncheckReserveVehicle = uncheckReserveVehicle


def fini():
    g_eventBus.removeListener(XFW_COMMAND.XFW_CMD, onXfwCommand)
    g_eventBus.removeListener(XVM_EVENT.CONFIG_LOADED, onConfigUpdated)
