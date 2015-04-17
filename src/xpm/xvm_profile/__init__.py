""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO (mandatory)

XFW_MOD_VERSION    = "3.0.0"
XFW_MOD_URL        = "http://www.modxvm.com/"
XFW_MOD_UPDATE_URL = "http://www.modxvm.com/en/download-xvm/"
XFW_GAME_VERSIONS  = ["0.9.7"]

#####################################################################

import traceback

import BigWorld
from gui.Scaleform.locale.PROFILE import PROFILE

from xfw import *
from xvm_main.python.logger import *
import xvm_main.python.dossier as dossier
import xvm_main.python.vehinfo as vehinfo
import xvm_main.python.vehinfo_xte as vehinfo_xte

#####################################################################
# event handlers

_lastPlayerId = None

def ProfileTechnique_sendAccountData(base, self, targetData, accountDossier):
    global _lastPlayerId
    _lastPlayerId = accountDossier.getPlayerDBID()
    base(self, targetData, accountDossier)

def ProfileTechnique_getTechniqueListVehicles(base, self, targetData, addVehiclesThatInHangarOnly = False):
    global _lastPlayerId
    res = base(self, targetData, addVehiclesThatInHangarOnly)
    for x in res:
        try:
            vehId = x['id']
            vDossier = dossier.getDossier((self._battlesType, _lastPlayerId, vehId))
            if vDossier is not None:
                x['xvm_xte'] = vDossier['xte']
        except:
            err(traceback.format_exc())
    return res

def ProfileTechnique_receiveVehicleDossier(self, vehId, playerId):
    if self._isDAAPIInited():
        vDossier = dossier.getDossier((self._battlesType, playerId, vehId))
        self.flashObject.as_responseVehicleDossierXvm(vDossier)

#####################################################################
# Register events

# Delayed registration
def _RegisterEvents():
    from gui.Scaleform.daapi.view.lobby.profile import ProfileTechnique
    from gui.Scaleform.daapi.view.lobby.profile import ProfileTechniquePage
    from gui.Scaleform.daapi.view.lobby.profile import ProfileTechniqueWindow
    OverrideMethod(ProfileTechniquePage, '_sendAccountData', ProfileTechnique_sendAccountData)
    OverrideMethod(ProfileTechniqueWindow, '_sendAccountData', ProfileTechnique_sendAccountData)
    OverrideMethod(ProfileTechnique, '_getTechniqueListVehicles', ProfileTechnique_getTechniqueListVehicles)
    RegisterEvent(ProfileTechnique, '_receiveVehicleDossier', ProfileTechnique_receiveVehicleDossier)

BigWorld.callback(0, _RegisterEvents)
