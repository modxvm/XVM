""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO (mandatory)

XFW_MOD_VERSION    = '3.0.0'
XFW_MOD_URL        = 'http://www.modxvm.com/'
XFW_MOD_UPDATE_URL = 'http://www.modxvm.com/en/download-xvm/'
XFW_GAME_VERSIONS  = ['0.9.7','0.9.8']

#####################################################################

import traceback

import BigWorld
from gui.Scaleform.locale.PROFILE import PROFILE

from xfw import *
from xvm_main.python.logger import *
import xvm_main.python.config as config
import xvm_main.python.constants as constants
import xvm_main.python.dossier as dossier
import xvm_main.python.token as token
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

    if token.networkServicesSettings['statAwards']:
        if self._isDAAPIInited():
            isHangar = False
            if hasattr(self, '_ProfileTechniquePage__isInHangarSelected'):
                isHangar = self._ProfileTechniquePage__isInHangarSelected
            self.flashObject.as_responseDossierXvm(self._battlesType,
                self._getTechniqueListVehicles(targetData, isHangar))
    else:
        base(self, targetData, accountDossier)

def ProfileTechnique_getTechniqueListVehicles(base, self, targetData, addVehiclesThatInHangarOnly = False):
    res = base(self, targetData, addVehiclesThatInHangarOnly)
    if token.networkServicesSettings['statAwards']:
        global _lastPlayerId
        for x in res:
            try:
                vehId = x['id']
                vDossier = dossier.getDossier((self._battlesType, _lastPlayerId, vehId))
                x['xvm_xte'] = int(vDossier['xte']) if vDossier is not None else -1
                x['xvm_xte_flag'] = 0
            except:
                err(traceback.format_exc())
    return res

def ProfileTechnique_receiveVehicleDossier(base, self, vehId, playerId):
    global _lastVehId
    _lastVehId = vehId
    base(self, vehId, playerId)
    _lastVehId = None

    if token.networkServicesSettings['statAwards']:
        if self._isDAAPIInited():
            vDossier = dossier.getDossier((self._battlesType, playerId, vehId))
            self.flashObject.as_responseVehicleDossierXvm(vDossier)

def DetailedStatisticsUtils_getStatistics(base, targetData, isCurrentuser):
    res = base(targetData, isCurrentuser)
    global _lastVehId
    if _lastVehId is not None and token.networkServicesSettings['statAwards']:
        try:
            battles = targetData.getBattlesCount()
            dmg = targetData.getDamageDealt()
            frg = targetData.getFragsCount()
            ref = vehinfo_xte.getReferenceValues(_lastVehId)
            if ref is None:
                ref = {}
            data = -1
            #log('b:{} d:{} f:{}'.format(battles, dmg, frg))
            if battles > 0 and dmg > 0 and frg > 0:
                ref['currentD'] = float(dmg) / battles
                ref['currentF'] = float(frg) / battles
                xte = vehinfo_xte.calculateXTE(_lastVehId, float(dmg) / battles, float(frg) / battles)
                if xte > 0:
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

def DAAPIModule_registerFlashComponent(base, self, component, alias, *args):
    from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
    from gui.Scaleform.daapi.view.lobby.profile.ProfilePage import ProfilePage
    if alias == VIEW_ALIAS.PROFILE_TAB_NAVIGATOR:
        isProfilePage = isinstance(self, ProfilePage)
        ctx = args[4] if isProfilePage else None
        if ctx is not None and ctx.get('itemCD'):
            selectedAlias = VIEW_ALIAS.PROFILE_TECHNIQUE_PAGE
        else:
            startPage = config.config['userInfo']['startPage']
            if startPage == 2:
                selectedAlias = VIEW_ALIAS.PROFILE_AWARDS
            elif startPage == 3:
                selectedAlias = VIEW_ALIAS.PROFILE_STATISTICS
            elif startPage == 4:
                if isProfilePage:
                    selectedAlias = VIEW_ALIAS.PROFILE_TECHNIQUE_PAGE
                else:
                    selectedAlias = VIEW_ALIAS.PROFILE_TECHNIQUE_WINDOW
            else:
                if isProfilePage:
                    selectedAlias = VIEW_ALIAS.PROFILE_SUMMARY_PAGE
                else:
                    selectedAlias = VIEW_ALIAS.PROFILE_SUMMARY_WINDOW
        args[3]['selectedAlias'] = selectedAlias

    base(self, component, alias, *args)

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

    from gui.Scaleform.framework.entities.DAAPIModule import DAAPIModule
    OverrideMethod(DAAPIModule, 'registerFlashComponent', DAAPIModule_registerFlashComponent)

BigWorld.callback(0, _RegisterEvents)
