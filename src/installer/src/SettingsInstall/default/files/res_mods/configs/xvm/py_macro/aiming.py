import BigWorld
import math
from Avatar import PlayerAvatar
from AvatarInputHandler import AvatarInputHandler
from Vehicle import Vehicle
from aih_constants import CTRL_MODE_NAME

import xvm_battle.python.battle as battle
import xvm_main.python.config as config
from xfw.events import registerEvent
from xfw_actionscript.python import *
from xvm_main.python.logger import *

timeAIM = None
visible = True
DISPLAY_IN_MODES = [CTRL_MODE_NAME.ARCADE,
                    CTRL_MODE_NAME.ARTY,
                    CTRL_MODE_NAME.DUAL_GUN,
                    CTRL_MODE_NAME.SNIPER,
                    CTRL_MODE_NAME.STRATEGIC]


@registerEvent(AvatarInputHandler, 'onControlModeChanged')
def AvatarInputHandler_onControlModeChanged(self, eMode, **args):
    global visible
    newVisible = eMode in DISPLAY_IN_MODES
    if newVisible != visible:
        visible = newVisible
        as_event('ON_AIMING')


@registerEvent(Vehicle, 'onEnterWorld')
def aiming_onEnterWorld(self, prereqs):
    if self.isPlayerVehicle and config.get('sight/enabled', True) and battle.isBattleTypeSupported:
        global timeAIM, visible
        visible = True
        timeAIM = None


@registerEvent(PlayerAvatar, 'updateVehicleHealth')
def PlayerAvatar_updateVehicleHealth(self, vehicleID, health, deathReasonID, isCrewActive, isRespawn):
    if not (health > 0 and isCrewActive) and config.get('sight/enabled', True) and battle.isBattleTypeSupported:
        global timeAIM
        timeAIM = None
        as_event('ON_AIMING')


@registerEvent(PlayerAvatar, 'getOwnVehicleShotDispersionAngle')
def aiming_getOwnVehicleShotDispersionAngle(self, turretRotationSpeed, withShot=0):
    global timeAIM
    if config.get('sight/enabled', True) and battle.isBattleTypeSupported and self.isVehicleAlive:
        aimingStartTime, aimingFactor, shotDispMultiplierFactor, _1, _2, _3, aimingTime = self._PlayerAvatar__aimingInfo
        prevTimeAIM = timeAIM
        # aimingStartTime = aimingInfo[0]
        # aimingFactor = aimingInfo[1]
        # shotDispMultiplierFactor = aimingInfo[2]
        # unShotDispersionFactorsTurretRotation = aimingInfo[3]
        # chassisShotDispersionFactorsMovement = aimingInfo[4]
        # chassisShotDispersionFactorsRotation = aimingInfo[5]
        # aimingTime = aimingInfo[6]
        aimingTimeAll = math.log(aimingFactor / shotDispMultiplierFactor) * aimingTime
        timeAIM = aimingTimeAll + aimingStartTime - BigWorld.time()
        timeAIM = 0.0 if timeAIM < 0.01 else timeAIM
        try:
            if not (-0.01 < (prevTimeAIM - timeAIM) < 0.01):
                as_event('ON_AIMING')
        except Exception:
            as_event('ON_AIMING')


@xvm.export('sight.timeAIM', deterministic=False)
def sight_timeAIM():
    return timeAIM if visible else None
