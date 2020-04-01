import traceback

import BattleReplay
import BigWorld
from Avatar import PlayerAvatar
from AvatarInputHandler import AvatarInputHandler
from AvatarInputHandler.AimingSystems import CollisionStrategy, getCappedShotTargetInfos
from Math import Vector3, Vector2
from Vehicle import Vehicle
from VehicleGunRotator import VehicleGunRotator
from aih_constants import CTRL_MODE_NAME

import xvm_battle.python.battle as battle
import xvm_main.python.config as config
from xfw.events import registerEvent, overrideMethod
from xfw_actionscript.python import *
from xvm_main.python.logger import *

currentDistance = None
timeFlight = None
timeAIM = None
cameraHeight = None
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
        as_event('ON_MARKER_POSITION')


@registerEvent(PlayerAvatar, 'updateVehicleHealth')
def PlayerAvatar_updateVehicleHealth(self, vehicleID, health, deathReasonID, isCrewActive, isRespawn):
    if not (health > 0 and isCrewActive) and config.get('sight/enabled', True) and battle.isBattleTypeSupported:
        global currentDistance, timeFlight, cameraHeight
        currentDistance = None
        timeFlight = None
        cameraHeight = None
        as_event('ON_MARKER_POSITION')


@registerEvent(Vehicle, 'onEnterWorld')
def Vehicle_onEnterWorld(self, prereqs):
    if self.isPlayerVehicle and config.get('sight/enabled', True) and battle.isBattleTypeSupported:
        global currentDistance, timeFlight, cameraHeight, visible
        currentDistance = None
        timeFlight = None
        cameraHeight = None
        visible = True


@overrideMethod(VehicleGunRotator, '_VehicleGunRotator__getGunMarkerPosition')
def _VehicleGunRotator__getGunMarkerPosition(base, self, shotPos, shotVec, dispersionAngles):
    if not (config.get('sight/enabled', True) and battle.isBattleTypeSupported):
        return base(self, shotPos, shotVec, dispersionAngles)
    try:
        global timeFlight, currentDistance, cameraHeight
        prevTimeFlight, prevCurrentDistance, prevCameraHeight = timeFlight, currentDistance, cameraHeight
        shotDescr = self._avatar.getVehicleDescriptor().shot
        gravity = Vector3(0.0, -shotDescr.gravity, 0.0)
        testVehicleID = self.getAttachedVehicleID()
        collisionStrategy = CollisionStrategy.COLLIDE_DYNAMIC_AND_STATIC
        minBounds, maxBounds = BigWorld.player().arena.getSpaceBB()
        endPos, direction, collData, usedMaxDistance = getCappedShotTargetInfos(shotPos, shotVec, gravity, shotDescr, testVehicleID, minBounds, maxBounds,
                                                                                collisionStrategy)
        distance = shotDescr.maxDistance if usedMaxDistance else (endPos - shotPos).length
        dispersAngle, idealDispersAngle = dispersionAngles
        doubleDistance = distance + distance
        markerDiameter = doubleDistance * dispersAngle
        idealMarkerDiameter = doubleDistance * idealDispersAngle
        replayCtrl = BattleReplay.g_replayCtrl
        if replayCtrl.isPlaying and replayCtrl.isClientReady:
            markerDiameter, endPos, direction = replayCtrl.getGunMarkerParams(endPos, direction)

        shotVecXZ = Vector2(shotVec.x, shotVec.z)
        delta = Vector2(endPos.x - shotPos.x, endPos.z - shotPos.z)
        timeFlight = delta.length / shotVecXZ.length
        cameraHeight = BigWorld.camera().position.y - endPos.y
        currentDistance = distance
        try:
            update = not (-0.01 < (prevTimeFlight - timeFlight) < 0.01)
            update = update or not (-0.01 < (prevCurrentDistance - currentDistance) < 0.01)
            update = update or not (-0.01 < (prevCameraHeight - cameraHeight) < 0.01)
        except Exception:
            update = True
        if update:
            as_event('ON_MARKER_POSITION')

    except Exception as ex:
        err(traceback.format_exc())
        return base(self, shotPos, shotVec, dispersionAngles)
    return endPos, direction, markerDiameter, idealMarkerDiameter, collData


@xvm.export('sight.distance', deterministic=False)
def sight_distance():
    return currentDistance if visible else None


@xvm.export('sight.timeFlight', deterministic=False)
def sight_timeFlight():
    return timeFlight if visible else None


@xvm.export('sight.cameraHeight', deterministic=False)
def sight_cameraHeight():
    return cameraHeight if visible else None
