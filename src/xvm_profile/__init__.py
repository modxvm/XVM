"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

# stdlib
import logging

# BigWorld
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.Scaleform.daapi.view.meta.ProfileMeta import ProfileMeta
from gui.Scaleform.daapi.view.meta.ProfileWindowMeta import ProfileWindowMeta
from gui.Scaleform.daapi.view.lobby.profile.ProfileTechnique import ProfileTechnique
from gui.Scaleform.daapi.view.lobby.profile.ProfileUtils import DetailedStatisticsUtils
from skeletons.gui.lobby_context import ILobbyContext
from helpers import dependency

# XFW
from xfw import *

# XVM Main
import xvm_main.consts as consts
import xvm_main.config as config
import xvm_main.dossier as dossier
import xvm_main.utils as utils
import xvm_main.vehinfo as vehinfo
import xvm_main.xvm_scale as xvm_scale
from xvm_main.utils import l10n



#
# Globals
#

_lastAccountDBID = None
_lastVehCD = None



#
# Handlers
#

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

def ProfileTechnique_sendAccountData(base, self, targetData, accountDossier):
    try:
        global _lastAccountDBID
        _lastAccountDBID = accountDossier.getPlayerDBID()
        base(self, targetData, accountDossier)
    except Exception:
        logging.getLogger('XVM/Profile').exception('ProfileTechnique_sendAccountData')

def ProfileTechnique_getTechniqueListVehicles(base, self, targetData, addVehiclesThatInHangarOnly=False):
    res = base(self, targetData, addVehiclesThatInHangarOnly)
    if config.networkServicesSettings.statAwards:
        global _lastAccountDBID
        for x in res:
            try:
                vehCD = x['id']
                vDossier = dossier.getDossier(self._battlesType, _lastAccountDBID, vehCD)
                x['xvm_xte'] = int(vDossier['xte']) if vDossier is not None else -1
                x['xvm_xte_flag'] = 0
            except Exception:
                logging.getLogger('XVM/Profile').exception('ProfileTechnique_getTechniqueListVehicles')
    return res

def ProfileTechnique_receiveVehicleDossier(base, self, vehCD, accountDBID):
    global _lastVehCD
    _lastVehCD = vehCD
    base(self, vehCD, accountDBID)
    _lastVehCD = None

    if config.networkServicesSettings.statAwards:
        if self._isDAAPIInited() and hasattr(self.flashObject, 'as_responseVehicleDossierXvm'):
            vDossier = dossier.getDossier(self._battlesType, accountDBID, vehCD)
            self.flashObject.as_responseVehicleDossierXvm(vDossier)

def DetailedStatisticsUtils_getStatistics(base, targetData, isCurrentuser, layout):
    res = base(targetData, isCurrentuser, layout)
    global _lastVehCD
    if _lastVehCD is not None and config.networkServicesSettings.statAwards:
        try:
            battles = targetData.getBattlesCount()
            dmg = targetData.getDamageDealt()
            frg = targetData.getFragsCount()

            # remove empty lines
            if res[0]['data'][4] is None:
                del res[0]['data'][4]
            #if res[1]['data'][1] is None:
            #    del res[1]['data'][1]
            #if res[1]['data'][4] is None:
            #    del res[1]['data'][4]

            # xTE
            data = -1
            vinfo = vehinfo.getVehicleInfoData(_lastVehCD)
            ref = {'avgdmg': vinfo.get('avgdmg', None),
                   'avgfrg': vinfo.get('avgfrg', None),
                   'topdmg': vinfo.get('topdmg', None),
                   'topfrg': vinfo.get('topfrg', None)}
            # logging.getLogger('XVM/Profile').info('vehCD: {} b:{} d:{} f:{}'.format(_lastVehCD, battles, dmg, frg))
            if battles > 0 and dmg >= 0 and frg >= 0:
                curdmg = float(dmg) / battles
                curfrg = float(frg) / battles
                ref['curdmg'] = curdmg
                ref['curfrg'] = curfrg
                x = vehinfo.calculateXTE(_lastVehCD, curdmg, curfrg)
                ref['xte'] = x
                ref['xte_sup'] = xvm_scale.XvmScaleToSup(x)
                if x >= 0:
                    color = utils.getDynamicColorValue(consts.DYNAMIC_VALUE_TYPE.X, x)
                    xStr = 'XX' if x == 100 else ('0' if x < 10 else '') + str(x)
                    data = '<font color="#{}" size="12">({} {}%)</font>  <font color="{}">{}</font>'.format(
                        XFW_COLORS.UICOLOR_LABEL, l10n('better than'), ref['xte_sup'], color, xStr)
                    # logging.getLogger('XVM/Profile').info("xte={} color={}".format(xStr, color))
            res[0]['data'].insert(0, {
                'label': 'xTE',
                'data': data,
                'tooltip': 'xvm_xte',
                'tooltipData': {'body': ref, 'header': {}, 'note': None}})

            # xTDB
            item = res[1]['data'][2]
            if battles > 0 and dmg >= 0:
                x = vehinfo.calculateXTDB(_lastVehCD, float(dmg) / battles)
                sup = xvm_scale.XvmScaleToSup(x)
                if x >= 0:
                    color = utils.getDynamicColorValue(consts.DYNAMIC_VALUE_TYPE.X, x)
                    item['data'] = '<font color="#{}" size="12">({} {}%)</font>  <font color="{}">{}</font>'.format(
                        XFW_COLORS.UICOLOR_LABEL, l10n('better than'), sup, color, item['data'])

        except:
            logging.getLogger('XVM/Profile').exception('DetailedStatisticsUtils_getStatistics')

    return res



#
# Internal
#

def _getStartPageAlias(self, alias, isProfilePage):
    if alias != VIEW_ALIAS.PROFILE_TAB_NAVIGATOR:
        return None

    if isProfilePage and self._ProfilePage__ctx.get('itemCD'):
        return VIEW_ALIAS.PROFILE_TECHNIQUE_PAGE

    startPage = config.get('userInfo/profileStartPage' if isProfilePage else 'userInfo/contactsStartPage').lower()

    #log('startPage={}'.format(startPage))
    if startPage == 'achievements' and IS_WG:
        return VIEW_ALIAS.PROFILE_ACHIEVEMENTS_PAGE

    if startPage == 'awards':
        return VIEW_ALIAS.PROFILE_AWARDS

    if startPage == 'statistics':
        return VIEW_ALIAS.PROFILE_STATISTICS

    if startPage == 'vehicles':
        return VIEW_ALIAS.PROFILE_TECHNIQUE_PAGE if isProfilePage else VIEW_ALIAS.PROFILE_TECHNIQUE_WINDOW

    if startPage == 'hof' and isProfilePage:
        isHofEnabled = dependency.instance(ILobbyContext).getServerSettings().isHofEnabled()
        if isHofEnabled:
            return VIEW_ALIAS.PROFILE_HOF

    return VIEW_ALIAS.PROFILE_TOTAL_PAGE



#
# OpenWG API
#

__initialized = False

def owg_module_init():
    global __initialized
    if not __initialized:
        overrideMethod(ProfileMeta, 'registerFlashComponent')(ProfileMeta_registerFlashComponent)
        overrideMethod(ProfileWindowMeta, 'registerFlashComponent')(ProfileWindowMeta_registerFlashComponent)
        overrideMethod(ProfileTechnique, '_sendAccountData')(ProfileTechnique_sendAccountData)
        overrideMethod(ProfileTechnique, '_getTechniqueListVehicles')(ProfileTechnique_getTechniqueListVehicles)
        overrideMethod(ProfileTechnique, '_receiveVehicleDossier')(ProfileTechnique_receiveVehicleDossier)
        overrideStaticMethod(DetailedStatisticsUtils, 'getStatistics')(DetailedStatisticsUtils_getStatistics)
        __initialized = True


def owg_module_fini():
    global __initialized
    if __initialized:
        __initialized = False


def owg_module_loaded():
    global __initialized
    return __initialized

def owg_module_event(eventName, *args, **kwargs):
    pass
