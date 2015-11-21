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
    debug('_ArcadeCamera_create: {}'.format(postmortemMode))

    if config.get('battle/camera/enabled'):
        c = config.get('battle/camera/%s' % ('arcade' if not postmortemMode else 'postmortem'))
        bcfg = self._ArcadeCamera__baseCfg
        ucfg = self._ArcadeCamera__userCfg
        cfg = self._ArcadeCamera__cfg

        value = c['distRange']
        if value is not None:
            #log("{}: {} => {}".format('distRange', cfg['distRange'], MinMax(float(value[0]), float(value[1]))))
            cfg['distRange'] = MinMax(float(value[0]), float(value[1]))

        value = c['startDist']
        if value is not None:
            #log("{}: {} => {}".format('startDist', cfg['startDist'], float(value)))
            cfg['startDist'] = float(value)

        value = c['scrollSensitivity']
        if value is not None:
            #log("{}: {} => {}".format('scrollSensitivity', cfg['scrollSensitivity'], float(value) * ucfg['scrollSensitivity']))
            bcfg['scrollSensitivity'] = float(value)
            cfg['scrollSensitivity'] = float(value) * ucfg['scrollSensitivity']

    base(self, pivotPos, onChangeControlMode, postmortemMode)


@overrideMethod(SniperCamera, 'create')
def _SniperCamera_create(base, self, onChangeControlMode = None):
    debug('_SniperCamera_create')

    if config.get('battle/camera/enabled'):
        c = config.get('battle/camera/sniper')
        ucfg = self._SniperCamera__userCfg
        cfg = self._SniperCamera__cfg

        value = c['zooms']
        if value is not None:
            log("{}: {} => {}".format('zooms', cfg['zooms'], [float(i) for i in value]))
            cfg['zooms'] = [float(i) for i in value]

#        <accelerationSensitivity>0.2 0.4 0.2</accelerationSensitivity>
#        <zoomExposure>0.6 0.5 0.4</zoomExposure>
#      <aimingSystem>
#        <T>0.5 0.5 0.4</T>
#        <deviation>-0.0 0.0</deviation>
#      </aimingSystem>

    base(self, onChangeControlMode)


@overrideMethod(StrategicCamera, 'create')
def _StrategicCamera_create(base, self, onChangeControlMode = None):
    debug('_StrategicCamera_create')
    if config.get('battle/camera/enabled'):
        c = config.get('battle/camera/strategic')
        bcfg = self._StrategicCamera__baseCfg
        ucfg = self._StrategicCamera__userCfg
        cfg = self._StrategicCamera__cfg

        value = c['distRange']
        if value is not None:
            log("{}: {} => {}".format('distRange', cfg['distRange'], [float(i) for i in value]))
            cfg['distRange'] = [float(i) for i in value]
            self._StrategicCamera__aimingSystem._StrategicAimingSystem__height = cfg['distRange'][0]

    base(self, onChangeControlMode)
