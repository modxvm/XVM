""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# imports

import traceback

import BigWorld
from Avatar import PlayerAvatar
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
        bcfg = self._ArcadeCamera__baseCfg
        ucfg = self._ArcadeCamera__userCfg
        cfg = self._ArcadeCamera__cfg

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


@overrideMethod(SniperCamera, 'create')
def _SniperCamera_create(base, self, onChangeControlMode = None):
    #debug('_SniperCamera_create')

    if config.get('battle/camera/enabled'):
        c = config.get('battle/camera/sniper')
        dcfg = self._SniperCamera__dynamicCfg
        ucfg = self._SniperCamera__userCfg
        cfg = self._SniperCamera__cfg

        value = c['zooms']
        if value is not None:
            cfg['zooms'] = [float(i) for i in value]

        value = c['zoomExposure']
        if value is not None:
            dcfg['zoomExposure'] = [float(i) for i in value]

    base(self, onChangeControlMode)


@overrideMethod(StrategicCamera, 'create')
def _StrategicCamera_create(base, self, onChangeControlMode = None):
    #debug('_StrategicCamera_create')
    if config.get('battle/camera/enabled'):
        c = config.get('battle/camera/strategic')
        bcfg = self._StrategicCamera__baseCfg
        ucfg = self._StrategicCamera__userCfg
        cfg = self._StrategicCamera__cfg

        value = c['distRange']
        if value is not None:
            cfg['distRange'] = [float(i) for i in value]
            self._StrategicCamera__aimingSystem._StrategicAimingSystem__height = cfg['distRange'][0]

    base(self, onChangeControlMode)
