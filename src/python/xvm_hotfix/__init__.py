"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

# stdlib
import logging
import base64

# WoT
import debug_utils
from account_helpers.CustomFilesCache import CustomFilesCache
from account_helpers.settings_core.settings_constants import DAMAGE_LOG
from gui.Scaleform.daapi.view.battle.shared.damage_log_panel import DamageLogPanel

# XFW
from xfw import *



#
# Handlers
#

def _CustomFilesCache__onReadLocalFile(base, self, url, showImmediately):
    try:
        base(self, url, showImmediately)
    except EOFError:
        logging.getLogger('XVM/HotFix').exception('CustomFilesCache.__onReadLocalFile: url="{0}"'.format(url))
        try:
            logging.getLogger('XVM/HotFix').info('Attempt to reload url: {0}'.format(url))
            del(self._CustomFilesCache__db[base64.b32encode(url)])
            base(self, url, showImmediately)
        except Exception:
            logging.getLogger('XVM/HotFix').exception('CustomFilesCache.__onReadLocalFile: reload attempt failed')


def _DamageLogPanel__isDamageSettingEnabled(base, self, settingName):
    isDamageTypeVisible = self.settingsCore.getSetting(settingName)
    if settingName == DAMAGE_LOG.ASSIST_STUN and isDamageTypeVisible:
        arenaDP = self.sessionProvider.getArenaDP()
        vehicleID = self.sessionProvider.shared.vehicleState.getControllingVehicleID()
        vehicleInfoVO = arenaDP.getVehicleInfo(vehicleID)
        isSPG = vehicleInfoVO.isSPG()
        isAssaultSPG = vehicleInfoVO.isAssaultVehicle()
        isComp7Battle = self.sessionProvider.arenaVisitor.gui.isComp7Battle()
        isStunEnabled = self.lobbyContext.getServerSettings().spgRedesignFeatures.isStunEnabled()
        return ((isSPG and not isAssaultSPG) or isComp7Battle) and isStunEnabled
    return isDamageTypeVisible


def _doLog(base, category, msg, *args, **kwargs):
    if category == 'DEBUG':
        if msg == '_updateToLatestVersion':
            return
    base(category, msg, args, kwargs)



#
# XFW API
#

__initialized = False

def xfw_module_init():
    global __initialized
    if not __initialized:
        overrideMethod(CustomFilesCache, '_CustomFilesCache__onReadLocalFile')(_CustomFilesCache__onReadLocalFile)
        if IS_LESTA:
            overrideMethod(DamageLogPanel, '_DamageLogPanel__isDamageSettingEnabled')(_DamageLogPanel__isDamageSettingEnabled)
        if IS_CT:
            overrideMethod(debug_utils, '_doLog')(_doLog)

        __initialized = True


def xfw_module_fini():
    global __initialized
    if __initialized:
        __initialized = False


def xfw_is_module_loaded():
    global __initialized
    return __initialized
