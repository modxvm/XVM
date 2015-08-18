""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '3.1.0',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.9','0.9.10'],
    # optional
}

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
            self.flashObject.as_responseDossierXvm(
                self._battlesType,
                self._getTechniqueListVehicles(targetData, isHangar),
                '',
                self.getEmptyScreenLabel())
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


def ProfileMeta_registerFlashComponent(base, self, component, alias, *args):
    startPageAlias = _getStartPageAlias(self, alias, True)
    if startPageAlias is not None:
        args[3]['selectedAlias'] = startPageAlias
    base(self, component, alias, *args)


def ProfileWindowMeta_registerFlashComponent(base, self, component, alias, *args):
    startPageAlias = _getStartPageAlias(self, alias, False)
    if startPageAlias is not None:
        args[3]['selectedAlias'] = startPageAlias
    base(self, component, alias, *args)


#####################################################################
# internal

def _getStartPageAlias(self, alias, isProfilePage):
    from gui.Scaleform.daapi.settings.views import VIEW_ALIAS

    if alias != VIEW_ALIAS.PROFILE_TAB_NAVIGATOR:
        return None

    if isProfilePage and self._ProfilePage__ctx.get('itemCD'):
        return VIEW_ALIAS.PROFILE_TECHNIQUE_PAGE

    startPage = config.get('userInfo/startPage')
    log('startPage={}'.format(startPage))
    if startPage == 2:
        return VIEW_ALIAS.PROFILE_AWARDS

    if startPage == 3:
        return VIEW_ALIAS.PROFILE_STATISTICS

    if startPage == 4:
        return VIEW_ALIAS.PROFILE_TECHNIQUE_PAGE if isProfilePage else VIEW_ALIAS.PROFILE_TECHNIQUE_WINDOW

    return VIEW_ALIAS.PROFILE_SUMMARY_PAGE if isProfilePage else VIEW_ALIAS.PROFILE_SUMMARY_WINDOW


#####################################################################
# Register events

def _RegisterEvents():
    from gui.Scaleform.daapi.view.meta.ProfileMeta import ProfileMeta
    OverrideMethod(ProfileMeta, 'registerFlashComponent', ProfileMeta_registerFlashComponent)

    from gui.Scaleform.daapi.view.meta.ProfileWindowMeta import ProfileWindowMeta
    OverrideMethod(ProfileWindowMeta, 'registerFlashComponent', ProfileWindowMeta_registerFlashComponent)

    from gui.Scaleform.daapi.view.lobby.profile import ProfileTechnique
    OverrideMethod(ProfileTechnique, '_getTechniqueListVehicles', ProfileTechnique_getTechniqueListVehicles)
    OverrideMethod(ProfileTechnique, '_receiveVehicleDossier', ProfileTechnique_receiveVehicleDossier)

    from gui.Scaleform.daapi.view.lobby.profile import ProfileTechniquePage
    OverrideMethod(ProfileTechniquePage, '_sendAccountData', ProfileTechnique_sendAccountData)

    from gui.Scaleform.daapi.view.lobby.profile import ProfileTechniqueWindow
    OverrideMethod(ProfileTechniqueWindow, '_sendAccountData', ProfileTechnique_sendAccountData)

    from gui.Scaleform.daapi.view.lobby.profile.ProfileUtils import DetailedStatisticsUtils
    OverrideStaticMethod(DetailedStatisticsUtils, 'getStatistics', DetailedStatisticsUtils_getStatistics)

BigWorld.callback(0, _RegisterEvents)
