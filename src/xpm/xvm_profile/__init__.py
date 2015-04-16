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

_accountDossier = None

def ProfileTechniquePage_sendAccountData(base, self, targetData, accountDossier):
    global _accountDossier
    _accountDossier = accountDossier
    base(self, targetData, accountDossier)

def ProfileTechniquePage_getTechniqueListVehicles(base, self, targetData, addVehiclesThatInHangarOnly = False):
    res = base(self, targetData, addVehiclesThatInHangarOnly)

    global _accountDossier
    for x in res:
        try:
            vehId = x['id']
            vDossier = dossier.getDossier((self._battlesType, _accountDossier.getPlayerDBID(), vehId))
            if vDossier is not None:
                x['xvm_xte'] = vDossier['xte']
        except:
            err(traceback.format_exc())

    return res

def ProfileTechniqueWindow_sendAccountData(base, self, targetData, accountDossier):
    global _accountDossier
    _accountDossier = accountDossier
    base(self, targetData, accountDossier)

def ProfileTechniqueWindow_getTechniqueListVehicles(base, self, targetData, addVehiclesThatInHangarOnly = False):
    # TODO: vehicle data for other players is not loaded yet, so we can't calculate xTE
    res = base(self, targetData, addVehiclesThatInHangarOnly)
    return res

#####################################################################
# Register events

# Delayed registration
def _RegisterEvents():
    from gui.Scaleform.daapi.view.lobby.profile import ProfileTechniquePage
    OverrideMethod(ProfileTechniquePage, '_sendAccountData', ProfileTechniquePage_sendAccountData)
    OverrideMethod(ProfileTechniquePage, '_getTechniqueListVehicles', ProfileTechniquePage_getTechniqueListVehicles)
    from gui.Scaleform.daapi.view.lobby.profile import ProfileTechniqueWindow
    OverrideMethod(ProfileTechniqueWindow, '_sendAccountData', ProfileTechniqueWindow_sendAccountData)
    OverrideMethod(ProfileTechniqueWindow, '_getTechniqueListVehicles', ProfileTechniqueWindow_getTechniqueListVehicles)

BigWorld.callback(0, _RegisterEvents)
