""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO (mandatory)

XFW_MOD_VERSION = '3.0.0'
XFW_MOD_URL = 'http://www.modxvm.com/'
XFW_MOD_UPDATE_URL = 'http://www.modxvm.com/en/download-xvm/'
XFW_GAME_VERSIONS = ['0.9.7']

#####################################################################

import traceback
import BigWorld

from xfw import *
from xvm_main.python.logger import *
import xvm_main.python.config as config
from operator import attrgetter
from debug_utils import LOG_DEBUG
from xvm_main.python.vehinfo_tiers import getTiers

#####################################################################
# event handlers

# added sorting orders for tanks in carousel
def TankCarousel_showVehicles(base, self):
    try:
        from gui.shared import g_itemsCache, REQ_CRITERIA
        from gui import GUI_NATIONS_ORDER_INDEX
        from gui.shared.gui_items.Vehicle import VEHICLE_TYPES_ORDER_INDICES
        myconfig = config.config['hangar']['carousel']
        filterCriteria = REQ_CRITERIA.INVENTORY
        if self.vehiclesFilter['nation'] != -1:
            if self.vehiclesFilter['nation'] == 100:
                filterCriteria |= REQ_CRITERIA.VEHICLE.IN_PREMIUM_IGR
            else:
                filterCriteria |= REQ_CRITERIA.NATIONS([self.vehiclesFilter['nation']])
        if self.vehiclesFilter['tankType'] != 'none':
            filterCriteria |= REQ_CRITERIA.VEHICLE.CLASSES([self.vehiclesFilter['tankType']])
        if self.vehiclesFilter['ready']:
            filterCriteria |= REQ_CRITERIA.VEHICLE.FAVORITE
        items = g_itemsCache.items
        filteredVehs = items.getVehicles(filterCriteria)

        def sorting(v1, v2):
            if v1.isFavorite and not v2.isFavorite: return -1
            if not v1.isFavorite and v2.isFavorite: return 1
            if 'sorting_criteria' in myconfig:
                for sort_criterion in myconfig['sorting_criteria']:
                    if sort_criterion.find('-') == 0:
                        sort_criterion = sort_criterion[1:] #remove minus sign
                        factor = -1
                    else:
                        factor = 1
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

        vehsCDs = map(attrgetter('intCD'), sorted(filteredVehs.itervalues(), sorting))
        LOG_DEBUG('Showing carousel vehicles: ', vehsCDs)
        self.as_showVehiclesS(vehsCDs)
    except Exception as ex:
        err(traceback.format_exc())
        base(self)


#####################################################################
# Register events

def _RegisterEvents():
    from gui.Scaleform.daapi.view.lobby.hangar.TankCarousel import TankCarousel
    OverrideMethod(TankCarousel, 'showVehicles', TankCarousel_showVehicles)

BigWorld.callback(0, _RegisterEvents)
