""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# imports

import traceback
import math

import BigWorld
from Avatar import PlayerAvatar
from AvatarInputHandler.control_modes import ArcadeControlMode, SniperControlMode
from AvatarInputHandler.DynamicCameras.ArcadeCamera import ArcadeCamera, MinMax
from AvatarInputHandler.DynamicCameras.SniperCamera import SniperCamera
from AvatarInputHandler.DynamicCameras.StrategicCamera import StrategicCamera

from xfw import *

from xvm_main.python.logger import *
import xvm_main.python.config as config


#####################################################################
# handlers

@overrideMethod(ArcadeCamera, 'create')
def _ArcadeCamera_create(base, self, pivotPos, onChangeControlMode = None, postmortemMode = False):
    #debug('_ArcadeCamera_create: {}'.format(postmortemMode))

    if config.get('battle/camera/enabled'):
        c = config.get('battle/camera/%s' % ('arcade' if not postmortemMode else 'postmortem'))
        cfg = self._ArcadeCamera__cfg
        bcfg = self._ArcadeCamera__baseCfg
        ucfg = self._ArcadeCamera__userCfg

        value = c['distRange']
        if value is not None:
            cfg['distRange'] = MinMax(float(value[0]), float(value[1]))

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
    #debug('_ArcadeCamera_enable: {}'.format(postmortemMode))
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

        value = c['zooms']
        if value is not None:
            cfg['zooms'] = [float(i) for i in value]
            dcfg['zoomExposure'] = [ max(0, 0.7 - math.log(i, 2) * 0.1) for i in value]

    base(self, onChangeControlMode)


@overrideMethod(StrategicCamera, 'create')
def _StrategicCamera_create(base, self, onChangeControlMode = None):
    #debug('_StrategicCamera_create')
    if config.get('battle/camera/enabled'):
        c = config.get('battle/camera/strategic')
        cfg = self._StrategicCamera__cfg

        value = c['distRange']
        if value is not None:
            cfg['distRange'] = [float(i) for i in value]
            self._StrategicCamera__aimingSystem._StrategicAimingSystem__height = cfg['distRange'][0]

    base(self, onChangeControlMode)


@overrideMethod(ArcadeControlMode, 'onChangeControlModeByScroll')
def onChangeControlModeByScroll(base, self):
    if not config.get('battle/camera/noScroll'):
        base(self)


@overrideMethod(SniperControlMode, 'onChangeControlModeByScroll')
def onChangeControlModeByScroll(base, self, switchToClosestDist = True):
    if not config.get('battle/camera/noScroll'):
        base(self, switchToClosestDist)
