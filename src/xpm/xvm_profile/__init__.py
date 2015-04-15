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
import xvm_main.python.vehinfo_xteff as vehinfo_xteff

#####################################################################
# event handlers

_accountDossier = None

def ProfileTechnique_sendAccountData(base, self, targetData, accountDossier):
    global _accountDossier
    _accountDossier = accountDossier
    base(self, targetData, accountDossier)

def ProfileTechnique_getTechniqueListVehicles(base, self, targetData, addVehiclesThatInHangarOnly = False):
    res = base(self, targetData, addVehiclesThatInHangarOnly)
    
    global _accountDossier
    from gui.shared import g_itemsCache
    for x in res:
        try:
            vehId = x['id']
            vehDossier = g_itemsCache.items.getVehicleDossier(vehId, _accountDossier.getPlayerDBID())
            if vehDossier is not None:
                if self._battlesType == PROFILE.PROFILE_DROPDOWN_LABELS_ALL:
                    stats = vehDossier.getRandomStats()
                elif self._battlesType == PROFILE.PROFILE_DROPDOWN_LABELS_TEAM:
                    stats = vehDossier.getTeam7x7Stats()
                elif self._battlesType == PROFILE.PROFILE_DROPDOWN_LABELS_STATICTEAM:
                    stats = vehDossier.getRated7x7Stats()
                elif self._battlesType == PROFILE.PROFILE_DROPDOWN_LABELS_HISTORICAL:
                    stats = vehDossier.getHistoricalStats()
                elif self._battlesType == PROFILE.PROFILE_DROPDOWN_LABELS_FORTIFICATIONS_SORTIES:
                    stats = vehDossier.getFortSortiesStats()
                elif self._battlesType == PROFILE.PROFILE_DROPDOWN_LABELS_FORTIFICATIONS_BATTLES:
                    stats = vehDossier.getFortBattlesStats()
                else:
                    raise ValueError('Profile Technique: Unknown battle type: ' + self._battlesType)

                battles = stats.getBattlesCount()
                dmg = stats.getDamageDealt()
                frg = stats.getFragsCount()
                x['xvm_xe'] = None
                if battles > 0 and dmg > 0 and frg > 0:
                    x['xvm_xe'] = vehinfo_xteff.calculateXe(vehId, float(dmg) / battles, float(frg) / battles)
        except:
            err(traceback.format_exc())

    return res

#####################################################################
# Register events

# Delayed registration
def _RegisterEvents():
    from gui.Scaleform.daapi.view.lobby.profile import ProfileTechnique
    from gui.Scaleform.daapi.view.lobby.profile import ProfileTechniquePage
    OverrideMethod(ProfileTechnique, '_sendAccountData', ProfileTechnique_sendAccountData)
    OverrideMethod(ProfileTechniquePage, '_sendAccountData', ProfileTechnique_sendAccountData)
    OverrideMethod(ProfileTechnique, '_getTechniqueListVehicles', ProfileTechnique_getTechniqueListVehicles)

BigWorld.callback(0, _RegisterEvents)
