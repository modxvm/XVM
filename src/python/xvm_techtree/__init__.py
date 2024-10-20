"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2024 XVM Contributors
"""

#
# Imports
#

# stdlib
import logging
import traceback

# BigWorld
from gui.Scaleform.daapi.view.meta.ModuleInfoMeta import ModuleInfoMeta
from helpers import dependency
from skeletons.gui.shared import IItemsCache

# XFW
from xfw import *

# XVM Main
import xvm_main.python.config as config
from xvm_main.python.vehinfo import _getRanges
from xvm_main.python.xvm import l10n

# Per-realm
if getRegion() != 'RU':
    from gui.Scaleform.daapi.view.lobby.techtree.techtree_dp import _TechTreeDataProvider
else:
    from gui.techtree.techtree_dp import TechTreeDataProvider as _TechTreeDataProvider


#
# Handlers
#

def _TechTreeDataProvider_getAllVehiclePossibleXP(base, self, nodeCD, unlockStats):
    try:
        if not config.get('hangar/allowExchangeXPInTechTree'):
            return unlockStats.getVehTotalXP(nodeCD)
    except Exception:
        logging.getLogger('XVM/TechTree').exception('_TechTreeDataProvider_getAllVehiclePossibleXP')
    return base(self, nodeCD, unlockStats)


# add shooting range in gun info window for SPG/machine guns
def ModuleInfoWindow_as_setModuleInfoS(base, self, moduleInfo):
    try:
        if moduleInfo['type'] == 'vehicleGun':
            veh_id = self._ModuleInfoWindow__vehicleDescr.type.compactDescr
            itemsCache = dependency.instance(IItemsCache)
            vehicle = itemsCache.items.getItemByCD(veh_id)
            gun = itemsCache.items.getItemByCD(self.moduleCompactDescr).descriptor
            # not accurate, but not relevant here
            turret = self._ModuleInfoWindow__vehicleDescr.turret
            (viewRange, shellRadius, artiRadius) = _getRanges(turret, gun, vehicle.nationName, vehicle.type)
            if vehicle.type == 'SPG':
                moduleInfo['parameters']['params'].append({'type': '<h>' + l10n('shootingRadius') + ' <p>' + l10n('(m)') + '</p></h>', 'value': '<h>' + str(artiRadius) + '</h>'})
            # not arty, short range weapons
            elif shellRadius < 707:
                moduleInfo['parameters']['params'].append({'type': '<h>' + l10n('shootingRadius') + ' <p>' + l10n('(m)') + '</p></h>', 'value': '<h>' + str(shellRadius) + '</h>'})
    except Exception:
        logging.getLogger('XVM/TechTree').exception('ModuleInfoWindow_as_setModuleInfoS')
    return base(self, moduleInfo)



#
# XFW API
#

__initialized = False

def xfw_module_init():
    global __initialized
    if not __initialized:
        overrideMethod(_TechTreeDataProvider, 'getAllVehiclePossibleXP')(_TechTreeDataProvider_getAllVehiclePossibleXP)
        overrideMethod(ModuleInfoMeta, 'as_setModuleInfoS')(ModuleInfoWindow_as_setModuleInfoS)

        __initialized = True


def xfw_module_fini():
    global __initialized
    if __initialized:
        __initialized = False


def xfw_is_module_loaded():
    global __initialized
    return __initialized
