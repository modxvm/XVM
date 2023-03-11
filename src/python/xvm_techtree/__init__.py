""" XVM (c) https://modxvm.com 2013-2021 """

#####################################################################
# imports

import traceback

from gui.Scaleform.daapi.view.lobby.techtree.techtree_dp import _TechTreeDataProvider
from gui.Scaleform.daapi.view.meta.ModuleInfoMeta import ModuleInfoMeta
from helpers import dependency
from skeletons.gui.shared import IItemsCache

from xfw import *

import xvm_main.python.config as config
from xvm_main.python.vehinfo import _getRanges
from xvm_main.python.logger import *
from xvm_main.python.xvm import l10n


#####################################################################
# handlers

@overrideMethod(_TechTreeDataProvider, 'getAllVehiclePossibleXP')
def _TechTreeDataProvider_getAllVehiclePossibleXP(base, self, nodeCD, unlockStats):
    if not config.get('hangar/allowExchangeXPInTechTree'):
        return unlockStats.getVehTotalXP(nodeCD)
    return base(self, nodeCD, unlockStats)


# add shooting range in gun info window for SPG/machine guns
@overrideMethod(ModuleInfoMeta, 'as_setModuleInfoS')
def ModuleInfoWindow_as_setModuleInfoS(base, self, moduleInfo):
    try:
        if moduleInfo['type'] == 'vehicleGun':
            veh_id = self._ModuleInfoWindow__vehicleDescr.type.compactDescr
            itemsCache = dependency.instance(IItemsCache)
            vehicle = itemsCache.items.getItemByCD(veh_id)
            gun = itemsCache.items.getItemByCD(self.moduleCompactDescr).descriptor
            turret = self._ModuleInfoWindow__vehicleDescr.turret    # not accurate, but not relevant here
            (viewRange, shellRadius, artiRadius) = _getRanges(turret, gun, vehicle.nationName, vehicle.type)
            if vehicle.type == 'SPG':   # arti
                moduleInfo['parameters']['params'].append({'type': '<h>' + l10n('shootingRadius') + ' <p>' + l10n('(m)') + '</p></h>', 'value': '<h>' + str(artiRadius) + '</h>'})
            elif shellRadius < 707:     # not arti, short range weapons
                moduleInfo['parameters']['params'].append({'type': '<h>' + l10n('shootingRadius') + ' <p>' + l10n('(m)') + '</p></h>', 'value': '<h>' + str(shellRadius) + '</h>'})
    except Exception, ex:
        err(traceback.format_exc())
    return base(self, moduleInfo)
