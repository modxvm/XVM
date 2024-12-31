"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2024 XVM Contributors
"""

#
# imports
#

# stdlib
import logging
import math

# BigWorld
import Math
from PlayerEvents import g_playerEvents
from AvatarInputHandler.control_modes import SniperControlMode
from AvatarInputHandler.DynamicCameras.ArcadeCamera import ArcadeCamera
from AvatarInputHandler.DynamicCameras.arcade_camera_helper import MinMax, ZoomStateSwitcher
from AvatarInputHandler.DynamicCameras.SniperCamera import SniperCamera
from AvatarInputHandler.DynamicCameras.StrategicCamera import StrategicCamera
from gui.battle_control.battle_constants import CROSSHAIR_VIEW_ID
from gui.Scaleform.daapi.view.battle.shared.crosshair.container import CrosshairPanelContainer
from skeletons.gui.battle_session import IBattleSessionProvider
from realm import CURRENT_REALM
from helpers import dependency
from helpers.EffectsList import _FlashBangEffectDesc

# XFW
from xfw import *

# XFW Actionscript
from xfw_actionscript.python import as_xfw_cmd

# XVM Main
import xvm_main.python.config as config
import xvm_main.python.utils as utils

# XVM Battle
from xvm_battle.python.consts import XVM_BATTLE_COMMAND



#
# Avatar
#

def _PlayerAvatar_onBecomePlayer(*args, **kwargs):
    try:
        sessionProvider = dependency.instance(IBattleSessionProvider)
        ctrl = sessionProvider.shared.crosshair
        if ctrl:
            ctrl.onCrosshairPositionChanged += onCrosshairPositionChanged
            ctrl.onCrosshairZoomFactorChanged += onCrosshairZoomFactorChanged
            onCrosshairPositionChanged(*ctrl.getPosition())
            onCrosshairZoomFactorChanged(ctrl.getZoomFactor())
    except Exception:
        logging.getLogger('XVM/Battle/Camera').exception('_PlayerAvatar_onBecomePlayer')


def _PlayerAvatar_onBecomeNonPlayer(*args, **kwargs):
    try:
        sessionProvider = dependency.instance(IBattleSessionProvider)
        ctrl = sessionProvider.shared.crosshair
        if ctrl:
            ctrl.onCrosshairPositionChanged -= onCrosshairPositionChanged
            ctrl.onCrosshairZoomFactorChanged -= onCrosshairZoomFactorChanged
    except Exception:
        logging.getLogger('XVM/Battle/Camera').exception('_PlayerAvatar_onBecomeNonPlayer')


#
# Common
#

_prevOffsetX = None
_prevOffsetY = None

def onCrosshairPositionChanged(x, y):
    global _prevOffsetX
    global _prevOffsetY
    if _prevOffsetX != x or _prevOffsetY != y:
        _prevOffsetX = x
        _prevOffsetY = y
        as_xfw_cmd(XVM_BATTLE_COMMAND.AS_AIM_OFFSET_UPDATE, x, y)


def _sendSniperCameraFlash(enable, zoom):
    if config.get('battle/camera/enabled') and config.get('battle/camera/sniper/zoomIndicator/enabled'):
        as_xfw_cmd(XVM_BATTLE_COMMAND.AS_SNIPER_CAMERA, enable, zoom)


def onCrosshairZoomFactorChanged(zoomFactor):
    _sendSniperCameraFlash(True, zoomFactor)


def _disableShotRecoilEffect(dcfg):
    for name, value in dcfg.iteritems():
        if name in ['impulseSensitivities', 'noiseSensitivities', 'impulseLimits', 'noiseLimits']:
            value = {}
        elif name in ['zoomExposure']:
            pass
        elif isinstance(value, float):
            value = 0.0
        elif isinstance(value, Math.Vector3):
            value = Math.Vector3(0.0, 0.0, 0.0)
        else:
            logging.getLogger('XVM/Battle/Camera').warning('unknown dynamic camera option type: %s %s = %s', type(value), name, value)
        dcfg[name] = value


#
# Common / ZoomState
#

def _ZoomStateSwitcher__isEnabledBySettings(base, self, index):
    if config.get('battle/camera/enabled'):
        return False
    else:
        return base(self, index)



#
# Common / FlashBang
#

def _FlashBangEffectDesc_create(base, self, model, list, args):
    if config.get('battle/camera/enabled') and config.get('battle/camera/noFlashBang'):
        return
    base(self, model, list, args)



#
# ArcadeCamera
#

def _ArcadeCamera_create(base, self, onChangeControlMode = None, postmortemMode = False, smartPointCalculator = True):
    if config.get('battle/camera/enabled'):
        # 'postmortemMode' does not work
        mode = 'arcade' if not self._ArcadeCamera__postmortemMode else 'postmortem'
        c = config.get('battle/camera/%s' % mode)
        cfg = self._cfg
        bcfg = self._baseCfg
        ucfg = self._userCfg
        dcfg = self._ArcadeCamera__dynamicCfg

        if not c['shotRecoilEffect']:
            _disableShotRecoilEffect(dcfg)

        value = c['distRange']
        if value is not None:
            defMin = 2
            defMax = 25
            cfg['distRange'] = MinMax(float(value[0]), float(value[1])) if value[0] != value[1] else MinMax(defMin, defMax)
            # Different on both realms
            # WG (1.24.1 CT) => self._distRange
            # Lesta (1.25) => self._ArcadeCamera__distRange (old)
            distRangeAttr = '_distRange' if hasattr(self, '_distRange') else '_ArcadeCamera__distRange'
            setattr(self, distRangeAttr, cfg['distRange'])

        value = c['startDist']
        if value is not None:
            cfg['startDist'] = float(value)

        value = c['scrollSensitivity']
        if value is not None:
            bcfg['scrollSensitivity'] = float(value)
            cfg['scrollSensitivity'] = float(value) * ucfg['scrollSensitivity']

    base(self, onChangeControlMode, postmortemMode, smartPointCalculator)


def _ArcadeCamera_enable(self, *args, **kwargs):
    if config.get('battle/camera/enabled'):
        if self._ArcadeCamera__postmortemMode:
            camDist = self._cfg.get('startDist', None)
            if camDist:
                self.setCameraDistance(camDist)



#
# SniperCamera
#

def _SniperCamera_create(base, self, onChangeControlMode = None):
    if config.get('battle/camera/enabled'):
        c = config.get('battle/camera/sniper')
        cfg = self._cfg
        dcfg = self._SniperCamera__dynamicCfg

        if not c['shotRecoilEffect']:
            _disableShotRecoilEffect(dcfg)
        else:
            dcfg['aimMarkerDistance'] = 10.0

        value = c['zooms']
        if value:
            cfg['increasedZoom'] = True
            cfg['zooms'] = [float(i) for i in value]
            dcfg['zoomExposure'] = [ max(0, 0.7 - math.log(i, 2) * 0.1) for i in value]

    base(self, onChangeControlMode)


def _SniperCamera_handleSettingsChange(base, self, diff):
    if config.get('battle/camera/enabled') and config.get('battle/camera/sniper/zooms'):
        diff['increasedZoom'] = True
    base(self, diff)


def _SniperCamera_updateSettingsFromServer(self):
    if config.get('battle/camera/enabled') and config.get('battle/camera/sniper/zooms'):
        self._cfg['increasedZoom'] = True


def _SniperCamera_enable(base, self, targetPos, saveZoom):
    if config.get('battle/camera/enabled'):
        zoom = config.get('battle/camera/sniper/startZoom')
        if zoom is None:
            zoom = self._cfg['zoom']
        else:
            SniperCamera._SNIPER_ZOOM_LEVEL = -1
        self._cfg['zoom'] = utils.takeClosest(self._cfg['zooms'], zoom)
    base(self, targetPos, saveZoom)
    _sendSniperCameraFlash(True, self._SniperCamera__zoom)


def _SniperCamera_disable(self):
    _sendSniperCameraFlash(False, self._SniperCamera__zoom)



#
# SniperCamera / Binoculars
#

def _SniperControlMode__setupBinoculars(base, self, optDevices):
    if config.get('battle/camera/enabled') and config.get('battle/camera/sniper/noBinoculars'):
        return
    base(self, optDevices)



#
# SniperCamera / Crosshairs
#

def _CrosshairPanelContainer_as_setSettingsS(base, self, data):
    if config.get('battle/camera/enabled') and config.get('battle/camera/sniper/zoomIndicator/enabled'):
        sniperData = data.get(CROSSHAIR_VIEW_ID.SNIPER, None)
        if sniperData:
            sniperData['zoomIndicatorAlphaValue'] = 0
    base(self, data)



#
# StrategicCamera
#

def _StrategicCamera_create_common(self):
    if config.get('battle/camera/enabled'):
        c = config.get('battle/camera/strategic')
        cfg = self._cfg
        dcfg = self._StrategicCamera__dynamicCfg

        if not c['shotRecoilEffect']:
            _disableShotRecoilEffect(dcfg)

        value = c['distRange']
        if value is not None:
            cfg['distRange'] = [float(i) for i in value]


def _StrategicCamera_create_wg(base, self, onChangeControlMode = None):
    _StrategicCamera_create_common(self)
    base(self, onChangeControlMode)


def _StrategicCamera_create_lesta(base, self, onChangeControlMode = None, useShotMaxDistance=True):
    _StrategicCamera_create_common(self)
    base(self, onChangeControlMode, useShotMaxDistance)



#
# Initialization
#

def init():
    # Avatar
    g_playerEvents.onAvatarBecomePlayer += _PlayerAvatar_onBecomePlayer
    g_playerEvents.onAvatarBecomeNonPlayer += _PlayerAvatar_onBecomeNonPlayer

    # Common / ZoomState
    overrideMethod(ZoomStateSwitcher, '_ZoomStateSwitcher__isEnabledBySettings')(_ZoomStateSwitcher__isEnabledBySettings)

    # Common / FlashBang
    overrideMethod(_FlashBangEffectDesc, 'create')(_FlashBangEffectDesc_create)

    # ArcadeCamera
    overrideMethod(ArcadeCamera, 'create')(_ArcadeCamera_create)
    registerEvent(ArcadeCamera, 'enable')(_ArcadeCamera_enable)

    # SniperCamera
    overrideMethod(SniperCamera, 'create')(_SniperCamera_create)
    overrideMethod(SniperCamera, '_handleSettingsChange')(_SniperCamera_handleSettingsChange)
    overrideMethod(SniperCamera, 'enable')(_SniperCamera_enable)
    registerEvent(SniperCamera, '_updateSettingsFromServer')(_SniperCamera_updateSettingsFromServer)
    registerEvent(SniperCamera, 'disable')(_SniperCamera_disable)

    # SniperCamera / Binoculars
    overrideMethod(SniperControlMode, '_SniperControlMode__setupBinoculars')(_SniperControlMode__setupBinoculars)

    # SniperCamera / Crosshair
    overrideMethod(CrosshairPanelContainer, 'as_setSettingsS')(_CrosshairPanelContainer_as_setSettingsS)

    # StrategicCamera
    if CURRENT_REALM == 'RU':
        overrideMethod(StrategicCamera, 'create')(_StrategicCamera_create_lesta)
    else:
        overrideMethod(StrategicCamera, 'create')(_StrategicCamera_create_wg)


def fini():
    # Avatar
    g_playerEvents.onAvatarBecomePlayer -= _PlayerAvatar_onBecomePlayer
    g_playerEvents.onAvatarBecomeNonPlayer -= _PlayerAvatar_onBecomeNonPlayer
