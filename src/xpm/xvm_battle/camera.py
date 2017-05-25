""" XVM (c) www.modxvm.com 2013-2017 """

#####################################################################
# imports

import traceback
import math
import Math

import BigWorld
from Avatar import PlayerAvatar
from AvatarInputHandler.DynamicCameras.ArcadeCamera import ArcadeCamera, MinMax
from AvatarInputHandler.DynamicCameras.SniperCamera import SniperCamera
from AvatarInputHandler.DynamicCameras.StrategicCamera import StrategicCamera
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider
from gui.battle_control.battle_constants import CROSSHAIR_VIEW_ID
from gui.Scaleform.daapi.view.battle.shared.crosshair.container import CrosshairPanelContainer
from AvatarInputHandler.control_modes import SniperControlMode
from helpers.EffectsList import _FlashBangEffectDesc
from gui.Scaleform.daapi.view.meta.SiegeModeIndicatorMeta import SiegeModeIndicatorMeta
from gui.Scaleform.daapi.view.meta.CrosshairPanelContainerMeta import CrosshairPanelContainerMeta
from AvatarInputHandler.AimingSystems.SniperAimingSystem import SniperAimingSystem    
from Keys import KEY_RIGHTMOUSE
from AvatarInputHandler import mathUtils
from gun_rotation_shared import calcPitchLimitsFromDesc

from xfw import *

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
def _ArcadeCamera_create(base, self, pivotPos, onChangeControlMode = None, postmortemMode = False):
    #debug('_ArcadeCamera_create: {}'.format(postmortemMode))
    if config.get('battle/camera/enabled'):
        mode = 'arcade' if not postmortemMode else 'postmortem'
        c = config.get('battle/camera/%s' % mode)
        cfg = self._ArcadeCamera__cfg
        bcfg = self._ArcadeCamera__baseCfg
        ucfg = self._ArcadeCamera__userCfg
        dcfg = self._ArcadeCamera__dynamicCfg

        if not c['shotRecoilEffect']:
            _disableShotRecoilEffect(dcfg)

        value = c['distRange']
        if value is not None:
            defMin = 2
            defMax = 25
            cfg['distRange'] = MinMax(float(value[0]), float(value[1])) if value[0] != value[1] else MinMax(defMin, defMax)

        value = c['startDist']
        if value is not None:
            cfg['startDist'] = float(value)

        value = c['scrollSensitivity']
        if value is not None:
            bcfg['scrollSensitivity'] = float(value)
            cfg['scrollSensitivity'] = float(value) * ucfg['scrollSensitivity']

    base(self, pivotPos, onChangeControlMode, postmortemMode)

@registerEvent(ArcadeCamera, 'enable')
def _ArcadeCamera_enable(self, *args, **kwargs):
    #debug('_ArcadeCamera_enable: {}'.format(self._ArcadeCamera__postmortemMode))
    if config.get('battle/camera/enabled'):
        if self._ArcadeCamera__postmortemMode:
            camDist = self._ArcadeCamera__cfg.get('startDist', None)
            if camDist:
                self.setCameraDistance(camDist)

@overrideMethod(SniperCamera, 'create')
def _SniperCamera_create(base, self, onChangeControlMode = None):
    #debug('_SniperCamera_create')
    if config.get('battle/camera/enabled'):
        c = config.get('battle/camera/sniper')
        cfg = self._SniperCamera__cfg
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

@overrideMethod(SniperCamera, '_SniperCamera__onSettingsChanged')
def _SniperCamera__onSettingsChanged(base, self, diff):
    if config.get('battle/camera/enabled') and config.get('battle/camera/sniper/zooms'):
        diff['increasedZoom'] = True
    base(self, diff)

@overrideMethod(SniperCamera, 'enable')
def _SniperCamera_enable(base, self, targetPos, saveZoom):
    #debug('_SniperCamera_enable')
    if config.get('battle/camera/enabled'):
        zoom = config.get('battle/camera/sniper/startZoom')
        if zoom is not None:
            saveZoom = True
        else:
            zoom = self._SniperCamera__cfg['zoom']
        self._SniperCamera__cfg['zoom'] = utils.takeClosest(self._SniperCamera__cfg['zooms'], zoom)

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
        cfg = self._StrategicCamera__cfg
        dcfg = self._StrategicCamera__dynamicCfg

        if not c['shotRecoilEffect']:
            _disableShotRecoilEffect(dcfg)

        value = c['distRange']
        if value is not None:
            cfg['distRange'] = [float(i) for i in value]

    base(self, onChangeControlMode)

@overrideMethod(SniperControlMode, '_SniperControlMode__setupBinoculars')
def setupBinoculars(base, self, isCoatedOptics):
    if config.get('battle/camera/enabled') and config.get('battle/camera/sniper/noBinoculars'):
        return
    base(self, isCoatedOptics)

@overrideMethod(_FlashBangEffectDesc, 'create')
def create(base, self, model, list, args):
    if config.get('battle/camera/enabled') and config.get('battle/camera/noFlashBang'):
        return
    base(self, model, list, args)

@overrideMethod(SiegeModeIndicatorMeta, 'as_showHintS')
def SiegeModeIndicatorMeta_as_showHintS(base, self, buttonName, messageLeft, messageRight):
    if config.get('battle/camera/enabled') and config.get('battle/camera/hideHint'):
        return
    base(self, buttonName, messageLeft, messageRight)

@overrideMethod(SiegeModeIndicatorMeta, 'as_hideHintS')
def SiegeModeIndicatorMeta_as_hideHintS(base, self):
    if config.get('battle/camera/enabled') and config.get('battle/camera/hideHint'):
        return
    base(self)

@overrideMethod(CrosshairPanelContainerMeta, 'as_showHintS')
def CrosshairPanelContainerMeta_as_showHintS(base, self, key, messageLeft, messageRight, offsetX, offsetY):
    if config.get('battle/camera/enabled') and config.get('battle/camera/hideHint'):
        return
    base(self, key, messageLeft, messageRight, offsetX, offsetY)

@overrideMethod(CrosshairPanelContainerMeta, 'as_hideHintS')
def CrosshairPanelContainerMeta_as_hideHintS(base, self):
    if config.get('battle/camera/enabled') and config.get('battle/camera/hideHint'):
        return
    base(self)

@overrideMethod(SniperAimingSystem, '_SniperAimingSystem__clampToLimits')
def clampToLimits(base, self, turretYaw, gunPitch):
    if config.get('battle/camera/enabled') and config.get('battle/camera/sniper/noCameraLimit/enabled'):
        if not BigWorld.isKeyDown(KEY_RIGHTMOUSE) and self._SniperAimingSystem__yawLimits is not None and config.get('battle/camera/sniper/noCameraLimit/mode') == "hotkey":
            turretYaw = mathUtils.clamp(self._SniperAimingSystem__yawLimits[0], self._SniperAimingSystem__yawLimits[1], turretYaw)
        getPitchLimits = BigWorld.player().vehicleTypeDescriptor.gun['combinedPitchLimits']
        pitchLimits = calcPitchLimitsFromDesc(turretYaw, getPitchLimits)
        adjustment = max(0, self._SniperAimingSystem__returningOscillator.deviation.y)
        pitchLimits[0] -= adjustment
        pitchLimits[1] += adjustment
        gunPitch = mathUtils.clamp(pitchLimits[0], pitchLimits[1] + self._SniperAimingSystem__pitchCompensating, gunPitch)
        return (turretYaw, gunPitch)
    return base(self, turretYaw, gunPitch)

@overrideMethod(SniperControlMode, 'getPreferredAutorotationMode')
def getPreferredAutorotationMode(base, self):
    if config.get('battle/camera/enabled') and config.get('battle/camera/sniper/noCameraLimit/enabled') and config.get('battle/camera/sniper/noCameraLimit/mode') == "full":
        vehicle = BigWorld.entities.get(BigWorld.player().playerVehicleID)
        if vehicle is None:
            return
        else:
            desc = vehicle.typeDescriptor
            isRotationAroundCenter = desc.chassis['rotationIsAroundCenter']
            return isRotationAroundCenter
    return base(self)


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
