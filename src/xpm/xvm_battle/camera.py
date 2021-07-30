""" XVM (c) https://modxvm.com 2013-2021 """

#####################################################################
# imports

import traceback
import math
import Math

from Avatar import PlayerAvatar
from AvatarInputHandler.DynamicCameras.ArcadeCamera import ArcadeCamera
from AvatarInputHandler.DynamicCameras.arcade_camera_helper import MinMax, ZoomStateSwitcher
from AvatarInputHandler.DynamicCameras.SniperCamera import SniperCamera
from AvatarInputHandler.DynamicCameras.StrategicCamera import StrategicCamera
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider
from gui.battle_control.battle_constants import CROSSHAIR_VIEW_ID
from gui.Scaleform.daapi.view.battle.shared.crosshair.container import CrosshairPanelContainer
from AvatarInputHandler.control_modes import SniperControlMode
from helpers.EffectsList import _FlashBangEffectDesc

from xfw import *
from xfw_actionscript.python import *

from xvm_main.python.logger import *
import xvm_main.python.config as config
import xvm_main.python.utils as utils

from consts import *


#####################################################################
# handlers

@overrideMethod(PlayerAvatar, 'onBecomePlayer')
def _PlayerAvatar_onBecomePlayer(base, self):
    base(self)
    try:
        sessionProvider = dependency.instance(IBattleSessionProvider)
        ctrl = sessionProvider.shared.crosshair
        if ctrl:
            ctrl.onCrosshairPositionChanged += onCrosshairPositionChanged
            ctrl.onCrosshairZoomFactorChanged += onCrosshairZoomFactorChanged
            onCrosshairPositionChanged(*ctrl.getPosition())
            onCrosshairZoomFactorChanged(ctrl.getZoomFactor())
    except Exception, ex:
        err(traceback.format_exc())

@overrideMethod(PlayerAvatar, 'onBecomeNonPlayer')
def _PlayerAvatar_onBecomeNonPlayer(base, self):
    try:
        sessionProvider = dependency.instance(IBattleSessionProvider)
        ctrl = sessionProvider.shared.crosshair
        if ctrl:
            ctrl.onCrosshairPositionChanged -= onCrosshairPositionChanged
            ctrl.onCrosshairZoomFactorChanged -= onCrosshairZoomFactorChanged
    except Exception, ex:
        err(traceback.format_exc())
    base(self)


# BATTLE

@overrideMethod(ArcadeCamera, 'create')
def _ArcadeCamera_create(base, self, onChangeControlMode = None, postmortemMode = False):
    #debug('_ArcadeCamera_create: {}'.format(postmortemMode))
    if config.get('battle/camera/enabled'):
        # 'postmortemMode' is not work
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
            self._ArcadeCamera__distRange = cfg['distRange']

        value = c['startDist']
        if value is not None:
            cfg['startDist'] = float(value)

        value = c['scrollSensitivity']
        if value is not None:
            bcfg['scrollSensitivity'] = float(value)
            cfg['scrollSensitivity'] = float(value) * ucfg['scrollSensitivity']

    base(self, onChangeControlMode, postmortemMode)

@registerEvent(ArcadeCamera, 'enable')
def _ArcadeCamera_enable(self, *args, **kwargs):
    #debug('_ArcadeCamera_enable: {}'.format(self._ArcadeCamera__postmortemMode))
    if config.get('battle/camera/enabled'):
        if self._ArcadeCamera__postmortemMode:
            camDist = self._cfg.get('startDist', None)
            if camDist:
                self.setCameraDistance(camDist)

@overrideMethod(ZoomStateSwitcher, '_ZoomStateSwitcher__isEnabledBySettings')
def isEnabledBySettings(base, self, index):
    if config.get('battle/camera/enabled'):
        return False
    else:
        return base(self, index)

@overrideMethod(SniperCamera, 'create')
def _SniperCamera_create(base, self, onChangeControlMode = None):
    #debug('_SniperCamera_create')
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

@overrideMethod(SniperCamera, '_handleSettingsChange')
def _SniperCamera_handleSettingsChange(base, self, diff):
    if config.get('battle/camera/enabled') and config.get('battle/camera/sniper/zooms'):
        diff['increasedZoom'] = True
    base(self, diff)

@registerEvent(SniperCamera, '_updateSettingsFromServer')
def _SniperCamera_updateSettingsFromServer(self):
    if config.get('battle/camera/enabled') and config.get('battle/camera/sniper/zooms'):
        self._cfg['increasedZoom'] = True

@overrideMethod(SniperCamera, 'enable')
def _SniperCamera_enable(base, self, targetPos, saveZoom):
    #debug('_SniperCamera_enable')
    if config.get('battle/camera/enabled'):
        zoom = config.get('battle/camera/sniper/startZoom')
        if zoom is None:
            zoom = self._cfg['zoom']
        else:
            SniperCamera._SNIPER_ZOOM_LEVEL = -1
        self._cfg['zoom'] = utils.takeClosest(self._cfg['zooms'], zoom)
    base(self, targetPos, saveZoom)
    _sendSniperCameraFlash(True, self._SniperCamera__zoom)

@registerEvent(SniperCamera, 'disable')
def _SniperCamera_disable(self):
    _sendSniperCameraFlash(False, self._SniperCamera__zoom)

_prevOffsetX = None
_prevOffsetY = None

def onCrosshairPositionChanged(x, y):
    global _prevOffsetX
    global _prevOffsetY
    if _prevOffsetX != x or _prevOffsetY != y:
        _prevOffsetX = x
        _prevOffsetY = y
        as_xfw_cmd(XVM_BATTLE_COMMAND.AS_AIM_OFFSET_UPDATE, x, y)

def onCrosshairZoomFactorChanged(zoomFactor):
    _sendSniperCameraFlash(True, zoomFactor)

def _sendSniperCameraFlash(enable, zoom):
    if config.get('battle/camera/enabled') and config.get('battle/camera/sniper/zoomIndicator/enabled'):
        as_xfw_cmd(XVM_BATTLE_COMMAND.AS_SNIPER_CAMERA, enable, zoom)

@overrideMethod(CrosshairPanelContainer, 'as_setSettingsS')
def _CrosshairPanelContainer_as_setSettingsS(base, self, data):
    if config.get('battle/camera/enabled') and config.get('battle/camera/sniper/zoomIndicator/enabled'):
        sniperData = data.get(CROSSHAIR_VIEW_ID.SNIPER, None)
        if sniperData:
            sniperData['zoomIndicatorAlphaValue'] = 0
    base(self, data)

@overrideMethod(StrategicCamera, 'create')
def _StrategicCamera_create(base, self, onChangeControlMode = None):
    #debug('_StrategicCamera_create')
    if config.get('battle/camera/enabled'):
        c = config.get('battle/camera/strategic')
        cfg = self._cfg
        dcfg = self._StrategicCamera__dynamicCfg

        if not c['shotRecoilEffect']:
            _disableShotRecoilEffect(dcfg)

        value = c['distRange']
        if value is not None:
            cfg['distRange'] = [float(i) for i in value]

    base(self, onChangeControlMode)

@overrideMethod(SniperControlMode, '_SniperControlMode__setupBinoculars')
def setupBinoculars(base, self, optDevices):
    if config.get('battle/camera/enabled') and config.get('battle/camera/sniper/noBinoculars'):
        return
    base(self, optDevices)

@overrideMethod(_FlashBangEffectDesc, 'create')
def create(base, self, model, list, args):
    if config.get('battle/camera/enabled') and config.get('battle/camera/noFlashBang'):
        return
    base(self, model, list, args)


# PRIVATE

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
            log('WARNING: unknown dynamic camera option type: {} {} = {}'.format(type(value), name, value))
        dcfg[name] = value
