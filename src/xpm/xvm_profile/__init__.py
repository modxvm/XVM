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
import xvm_main.python.constants as constants
import xvm_main.python.dossier as dossier
import xvm_main.python.utils as utils
import xvm_main.python.vehinfo as vehinfo
import xvm_main.python.vehinfo_xte as vehinfo_xte

#####################################################################
# event handlers

_lastPlayerId = None
_lastVehId = None

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

def ProfileTechnique_receiveVehicleDossier(base, self, vehId, playerId):
    global _lastVehId
    _lastVehId = vehId

    base(self, vehId, playerId)

    if self._isDAAPIInited():
        vDossier = dossier.getDossier((self._battlesType, playerId, vehId))
        self.flashObject.as_responseVehicleDossierXvm(vDossier)

def DetailedStatisticsUtils_getStatistics(base, targetData):
    res = base(targetData)
    try:
        battles = targetData.getBattlesCount()
        dmg = targetData.getDamageDealt()
        frg = targetData.getFragsCount()
        ref = {}
        data = -1
        if battles > 0 and dmg > 0 and frg > 0:
            global _lastVehId
            xte = vehinfo_xte.calculateXTE(_lastVehId, float(dmg) / battles, float(frg) / battles)
            if xte is not None:
                ref = vehinfo_xte.getReferenceValues(_lastVehId)
                if ref is None:
                    ref = {}
                ref['currentD'] = float(dmg) / battles
                ref['currentF'] = float(frg) / battles
                color = utils.getDynamicColorValue(constants.DYNAMIC_VALUE_TYPE.X, xte)
                xteStr = 'XX' if xte == 100 else ('0' if xte < 10 else '') + str(xte)
                data = '<font color="{0}">{1}</font>'.format(color, xteStr)
                #log("xte={} color={}".format(xteStr, color))
        del res[0]['data'][4]
        res[0]['data'].insert(0, {
            'label': 'xTE',
            'data': data,
            'tooltip': 'xvm_xte',
            'tooltipData': {'body': ref, 'header': {}, 'note': None}})
    except:
        err(traceback.format_exc())

    return res


#####################################################################
# Register events

def _RegisterEvents():
    from gui.Scaleform.daapi.view.lobby.profile import ProfileTechnique
    from gui.Scaleform.daapi.view.lobby.profile import ProfileTechniquePage
    from gui.Scaleform.daapi.view.lobby.profile import ProfileTechniqueWindow
    from gui.Scaleform.daapi.view.lobby.profile.ProfileUtils import DetailedStatisticsUtils
    OverrideMethod(ProfileTechniquePage, '_sendAccountData', ProfileTechnique_sendAccountData)
    OverrideMethod(ProfileTechniqueWindow, '_sendAccountData', ProfileTechnique_sendAccountData)
    OverrideMethod(ProfileTechnique, '_getTechniqueListVehicles', ProfileTechnique_getTechniqueListVehicles)
    OverrideMethod(ProfileTechnique, '_receiveVehicleDossier', ProfileTechnique_receiveVehicleDossier)
    OverrideStaticMethod(DetailedStatisticsUtils, 'getStatistics', DetailedStatisticsUtils_getStatistics)

BigWorld.callback(0, _RegisterEvents)
