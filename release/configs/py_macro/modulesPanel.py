from gui.Scaleform.daapi.view.meta.ModulesPanelMeta import ModulesPanelMeta
from gui.Scaleform.genConsts.FITTING_TYPES import FITTING_TYPES
from helpers import dependency
from skeletons.gui.shared import IItemsCache

import xvm_main.python.config as config
from xfw import *

EQUIPMENT_PANEL = 'hangar/equipmentPanel'
SHOW_NUMBER_EQUIPMENT = EQUIPMENT_PANEL + '/showNumberEquipment'
SHOW_NUMBER_DIRECTIVES = EQUIPMENT_PANEL + '/showNumberDirectives'


@overrideMethod(ModulesPanelMeta, 'as_setDataS')
def as_setDataS(base, self, data):
    itemsCache = dependency.instance(IItemsCache)
    getItemByCD = itemsCache.items.getItemByCD
    isVisibleEquipment = config.get(SHOW_NUMBER_EQUIPMENT, True)
    isVisibleDirectives = config.get(SHOW_NUMBER_DIRECTIVES, True)
    for slot in data.get('devices', []):
        if slot['id'] != -1:
            if slot['slotType'] == FITTING_TYPES.EQUIPMENT and isVisibleEquipment:
                item = getItemByCD(slot['id'])
                slot['affectsAtTTC'] = True
                slot['countValue'] = item.inventoryCount
            elif slot['slotType'] == FITTING_TYPES.BOOSTER and isVisibleDirectives:
                item = getItemByCD(slot['id'])
                slot['affectsAtTTC'] = True
                slot['countValue'] = item.inventoryCount
    return base(self, data)
