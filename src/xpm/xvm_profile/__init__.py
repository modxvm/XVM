""" XVM (c) www.modxvm.com 2013-2017 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '0.9.17.0.3',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.17.0.3'],
    # optional
}


#####################################################################
# imports

import traceback

import BigWorld
from gui.Scaleform.locale.PROFILE import PROFILE
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.Scaleform.daapi.view.meta.ProfileMeta import ProfileMeta
from gui.Scaleform.daapi.view.meta.ProfileWindowMeta import ProfileWindowMeta
from gui.Scaleform.daapi.view.lobby.profile.ProfileTechnique import ProfileTechnique
from gui.Scaleform.daapi.view.lobby.profile.ProfileUtils import DetailedStatisticsUtils
from gui.Scaleform.genConsts.PROFILE_DROPDOWN_KEYS import PROFILE_DROPDOWN_KEYS

from xfw import *

from xvm_main.python.logger import *
import xvm_main.python.consts as consts
import xvm_main.python.config as config
import xvm_main.python.dossier as dossier
import xvm_main.python.utils as utils
import xvm_main.python.vehinfo as vehinfo
import xvm_main.python.vehinfo_xtdb as vehinfo_xtdb
import xvm_main.python.vehinfo_xte as vehinfo_xte
from xvm_main.python.xvm import l10n
import xvm_main.python.xvm_scale as xvm_scale


#####################################################################
# handlers

_lastAccountDBID = None
_lastVehCD = None

@overrideMethod(ProfileMeta, 'registerFlashComponent')
def ProfileMeta_registerFlashComponent(base, self, component, alias, *args):
    startPageAlias = _getStartPageAlias(self, alias, True)
    if startPageAlias is not None:
        args[3]['selectedAlias'] = startPageAlias
    base(self, component, alias, *args)

@overrideMethod(ProfileWindowMeta, 'registerFlashComponent')
def ProfileWindowMeta_registerFlashComponent(base, self, component, alias, *args):
    startPageAlias = _getStartPageAlias(self, alias, False)
    if startPageAlias is not None:
        args[3]['selectedAlias'] = startPageAlias
    base(self, component, alias, *args)

@overrideMethod(ProfileTechnique, '_sendAccountData')
def ProfileTechnique_sendAccountData(base, self, targetData, accountDossier):
    try:
        global _lastAccountDBID
        _lastAccountDBID = accountDossier.getPlayerDBID()
        base(self, targetData, accountDossier)
    except:
        err(traceback.format_exc())

@overrideMethod(ProfileTechnique, '_getTechniqueListVehicles')
def ProfileTechnique_getTechniqueListVehicles(base, self, targetData, addVehiclesThatInHangarOnly = False):
    res = base(self, targetData, addVehiclesThatInHangarOnly)
    if config.networkServicesSettings.statAwards:
        global _lastAccountDBID
        for x in res:
            try:
                vehCD = x['id']
                vDossier = dossier.getDossier((self._battlesType, _lastAccountDBID, vehCD))
                x['xvm_xte'] = int(vDossier['xte']) if vDossier is not None else -1
                x['xvm_xte_flag'] = 0
            except:
                err(traceback.format_exc())
    return res

@overrideMethod(ProfileTechnique, '_receiveVehicleDossier')
def ProfileTechnique_receiveVehicleDossier(base, self, vehCD, accountDBID):
    global _lastVehCD
    _lastVehCD = vehCD
    base(self, vehCD, accountDBID)
    _lastVehCD = None

    if config.networkServicesSettings.statAwards:
        if self._isDAAPIInited():
            vDossier = dossier.getDossier((self._battlesType, accountDBID, vehCD))
            self.flashObject.as_responseVehicleDossierXvm(vDossier)

@overrideStaticMethod(DetailedStatisticsUtils, 'getStatistics')
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
            ref = vehinfo_xte.getReferenceValues(_lastVehCD)
            if ref is None:
                ref = {}
            data = -1
            #log('vehCD: {} b:{} d:{} f:{}'.format(_lastVehCD, battles, dmg, frg))
            if battles > 0 and dmg >= 0 and frg >= 0:
                ref['currentD'] = float(dmg) / battles
                ref['currentF'] = float(frg) / battles
                x = vehinfo_xte.calculateXTE(_lastVehCD, float(dmg) / battles, float(frg) / battles)
                ref['xte'] = x
                ref['xte_sup'] = xvm_scale.XvmScaleToSup(x)
                if x >= 0:
                    color = utils.getDynamicColorValue(consts.DYNAMIC_VALUE_TYPE.X, x)
                    xStr = 'XX' if x == 100 else ('0' if x < 10 else '') + str(x)
                    data = '<font color="#{}" size="12">({} {}%)</font>  <font color="{}">{}</font>'.format(
                        XFWCOLORS.UICOLOR_LABEL, l10n('better than'), ref['xte_sup'], color, xStr)
                    #log("xte={} color={}".format(xStr, color))
            res[0]['data'].insert(0, {
                'label': 'xTE',
                'data': data,
                'tooltip': 'xvm_xte',
                'tooltipData': {'body': ref, 'header': {}, 'note': None}})

            # xTDB
            item = res[1]['data'][2]
            if battles > 0 and dmg >= 0:
                x = vehinfo_xtdb.calculateXTDB(_lastVehCD, float(dmg) / battles)
                sup = xvm_scale.XvmScaleToSup(x)
                if x >= 0:
                    color = utils.getDynamicColorValue(consts.DYNAMIC_VALUE_TYPE.X, x)
                    item['data'] = '<font color="#{}" size="12">({} {}%)</font>  <font color="{}">{}</font>'.format(
                        XFWCOLORS.UICOLOR_LABEL, l10n('better than'), sup, color, item['data'])

        except:
            err(traceback.format_exc())

    return res


#####################################################################
# internal

def _getStartPageAlias(self, alias, isProfilePage):
    if alias != VIEW_ALIAS.PROFILE_TAB_NAVIGATOR:
        return None

    if isProfilePage and self._ProfilePage__ctx.get('itemCD'):
        return VIEW_ALIAS.PROFILE_TECHNIQUE_PAGE

    startPage = config.get('userInfo/startPage')
    #log('startPage={}'.format(startPage))
    if startPage == 2:
        return VIEW_ALIAS.PROFILE_AWARDS

    if startPage == 3:
        return VIEW_ALIAS.PROFILE_STATISTICS

    if startPage == 4:
        return VIEW_ALIAS.PROFILE_TECHNIQUE_PAGE if isProfilePage else VIEW_ALIAS.PROFILE_TECHNIQUE_WINDOW

    return VIEW_ALIAS.PROFILE_SUMMARY_PAGE if isProfilePage else VIEW_ALIAS.PROFILE_SUMMARY_WINDOW
