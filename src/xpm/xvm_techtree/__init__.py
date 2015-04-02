""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO (mandatory)

XFW_MOD_VERSION    = "3.0.0"
XFW_MOD_URL        = "http://www.modxvm.com/"
XFW_MOD_UPDATE_URL = "http://www.modxvm.com/en/download-xvm/"
XFW_GAME_VERSIONS  = ["0.9.7"]

#####################################################################

import BigWorld

from xfw import *
import xvm_main.python.config as config
from xvm_main.python.vehinfo import _getRanges
from xvm_main.python.logger import *
from xvm_main.python.xvm import l10n

#####################################################################
# event handlers

def ItemsData_getAllPossibleXP(base, self, nodeCD, unlockStats):
    if not config.config['hangar']['allowExchangeXPInTechTree']:
        return unlockStats.getVehTotalXP(nodeCD)
    return base(self, nodeCD, unlockStats)

# add shooting range in gun info window for SPG/machine guns
def ModuleInfoWindow_as_setModuleInfoS(base, self, moduleInfo):
    try:
        if moduleInfo['type'] == 'vehicleGun':
            from gui.shared import g_itemsCache
            veh_id = self._ModuleInfoWindow__vehicleDescr.type.compactDescr
            vehicle = g_itemsCache.items.getItemByCD(veh_id)
            gun = g_itemsCache.items.getItemByCD(self.moduleCompactDescr).descriptor
            turret = self._ModuleInfoWindow__vehicleDescr.turret    # not accurate, but not relevant here
            (viewRange, shellRadius, artiRadius) = _getRanges(turret, gun, vehicle.nationName, vehicle.type)
            if vehicle.type == 'SPG':   # arti
                moduleInfo['parameters']['params'].append({'type': '<h>' + l10n('shootingRadius') + ' <p>' + l10n('(m)') + '</p></h>', 'value': '<h>' + str(artiRadius) + '</h>'})
            elif shellRadius < 707:     # not arti, short range weapons
                moduleInfo['parameters']['params'].append({'type': '<h>' + l10n('shootingRadius') + ' <p>' + l10n('(m)') + '</p></h>', 'value': '<h>' + str(shellRadius) + '</h>'})
    except Exception, ex:
        err(traceback.format_exc())
    return base(self, moduleInfo)


#####################################################################
# Register events

def _RegisterEvents():
    from gui.Scaleform.daapi.view.lobby.techtree.data import _ItemsData
    OverrideMethod(_ItemsData, '_getAllPossibleXP', ItemsData_getAllPossibleXP)
    from gui.Scaleform.daapi.view.meta.ModuleInfoMeta import ModuleInfoMeta
    OverrideMethod(ModuleInfoMeta, 'as_setModuleInfoS', ModuleInfoWindow_as_setModuleInfoS)

BigWorld.callback(0, _RegisterEvents)
