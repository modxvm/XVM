from BigWorld import player, cancelCallback, callback
from Vehicle import Vehicle
from Avatar import PlayerAvatar
from constants import VEHICLE_SIEGE_STATE, VEHICLE_HIT_FLAGS as VHF
from gui.battle_control.battle_constants import PERSONAL_EFFICIENCY_TYPE
from gui.battle_control.arena_info.arena_dp import ArenaDataProvider
from gui.battle_control.arena_info.arena_vos import VehicleArenaInfoVO
from gui.Scaleform.daapi.view.battle.shared.damage_log_panel import DamageLogPanel
from gui.Scaleform.daapi.view.battle.shared.ribbons_panel import BattleRibbonsPanel
from gui.Scaleform.daapi.view.battle.shared.ribbons_aggregator import RibbonsAggregator
from gui.Scaleform.daapi.view.battle.classic.stats_exchange import FragsCollectableStats

from xfw import *
from xfw_actionscript.python import *
from xvm_main.python.logger import *
import xvm_battle.python.battle as battle

from xvm.damageLog import ATTACK_REASONS

ON_TOTAL_EFFICIENCY = 'ON_TOTAL_EFFICIENCY'

totalDamage = 0
damage = 0
old_totalDamage = 0
totalAssist = 0
totalBlocked = 0
maxHealth = 0
damageReceived = 0
enemiesHealth = {}
alliesDamage = {}
enemyVehiclesMaxHP = {}
enemyVehiclesSumMaxHP = 0
damagesSquad = 0
numberHitsBlocked = 0
vehCD = None
_player = None
numberHitsDealt = 0
numberShotsDealt = 0
numberDamagesDealt = 0
numberShotsReceived = 0
numberHitsReceived = 0
numberHits = 0
fragsSquad = 0
fragsSquad_dict = {}
isPlayerInSquad = False
totalStun = 0
numberStuns = 0
numberAssistTrack = 0
numberAssistSpot = 0
numberAssistStun = 0
isStuns = None
numberDamagedVehicles = []
hitAlly = False
dmgAlly = False
burst = 1
allyVehicles = []
damageKind = None
arenaDP = None


ribbonTypes = {
    'armor': 0,
    'damage': 0,
    'ram': 0,
    'burn': 0,
    'kill': 0,
    'teamKill': 0,
    'spotted': 0,
    'assistTrack': 0,
    'assistSpot': 0,
    'crits': 0,
    'capture': 0,
    'defence': 0,
    'assist': 0
}


class UpdateLabels(object):
    DELAY = 0.1

    def __init__(self, eventName):
        self.eventName = eventName
        self.callbackID = None

    def __refresh(self):
        self.callbackID = None
        as_event(self.eventName)

    def update(self):
        if self.callbackID is None:
            self.callbackID = callback(self.DELAY, self.__refresh)

    def cancelUpdate(self):
        if self.callbackID is not None:
            cancelCallback(self.callbackID)
            self.callbackID = None

    def reset(self):
        self.update()
        self.cancelUpdate()


updateLabels = UpdateLabels(ON_TOTAL_EFFICIENCY)


@registerEvent(VehicleArenaInfoVO, 'updatePlayerStatus')
def totalEfficiency_updatePlayerStatus(self, **kwargs):
    global isPlayerInSquad, fragsSquad, fragsSquad_dict, damagesSquad
    if battle.isBattleTypeSupported and _player is not None and kwargs.get('isSquadMan', False):
        isPlayerVehicle = (self.vehicleID == _player.playerVehicleID)
        isPlayerInSquad |= isPlayerVehicle
        if isPlayerInSquad and arenaDP.isSquadMan(vID=self.vehicleID):
            vehicles = arenaDP.getVehiclesStatsIterator()
            fragsSquad_dict = {stats.vehicleID: stats.frags for stats in vehicles
                               if (_player.playerVehicleID != stats.vehicleID) and arenaDP.isSquadMan(vID=stats.vehicleID)}
            fragsSquad = sum(fragsSquad_dict.itervalues())
            updateLabels.update()


@registerEvent(ArenaDataProvider, 'updateVehicleStats')
def ArenaDataProvider_updateVehicleStats(self, vID, vStats):
    global fragsSquad, fragsSquad_dict
    if not battle.isBattleTypeSupported:
        return
    if vID and _player is not None:
        if arenaDP.isSquadMan(vID=vID) and vID != _player.playerVehicleID:
            fragsSquad_dict[vID] = vStats.get('frags', 0)
            fragsSquad = sum(fragsSquad_dict.itervalues())
            updateLabels.update()


@registerEvent(PlayerAvatar, 'showShotResults')
def PlayerAvatar_showShotResults(self, results):
    global numberHits, numberStuns, numberDamagedVehicles, hitAlly
    if not battle.isBattleTypeSupported:
        return
    isUpdate = False
    for r in results:
        vehID = (r & 4294967295L)
        if self.playerVehicleID != vehID:
            flags = r >> 32 & 4294967295L
            if flags & VHF.ATTACK_IS_DIRECT_PROJECTILE:
                numberHits += 1
                isUpdate = True
            if flags & VHF.STUN_STARTED:
                numberStuns += 1
                isUpdate = True
            if vehID not in numberDamagedVehicles:
                if flags & (VHF.MATERIAL_WITH_POSITIVE_DF_PIERCED_BY_PROJECTILE | VHF.MATERIAL_WITH_POSITIVE_DF_PIERCED_BY_EXPLOSION
                            | VHF.GUN_DAMAGED_BY_PROJECTILE | VHF.GUN_DAMAGED_BY_EXPLOSION
                            | VHF.CHASSIS_DAMAGED_BY_PROJECTILE | VHF.CHASSIS_DAMAGED_BY_EXPLOSION):
                    numberDamagedVehicles.append(vehID)
                    isUpdate = True
            if not hitAlly and (flags & (VHF.IS_ANY_DAMAGE_MASK | VHF.ATTACK_IS_DIRECT_PROJECTILE)):
                if vehID in allyVehicles:
                    vehicleDesc = self.arena.vehicles.get(vehID)
                    hitAlly = vehicleDesc['isAlive']
                    isUpdate = True
    if isUpdate:
        updateLabels.update()


@registerEvent(Vehicle, 'showShooting')
def Vehicle_showShooting(self, burstCount, gunIndex, isPredictedShot=False):
    global numberShotsDealt
    blockShooting = self.siegeState is not None and self.siegeState != VEHICLE_SIEGE_STATE.ENABLED and self.siegeState != VEHICLE_SIEGE_STATE.DISABLED and not self.typeDescriptor.hasAutoSiegeMode
    if not battle.isBattleTypeSupported or blockShooting or isPredictedShot or not self.isStarted :
        return
    if self.isPlayerVehicle:
        numberShotsDealt += burstCount
        updateLabels.update()


@registerEvent(Vehicle, 'showDamageFromShot')
def showDamageFromShot(self, attackerID, points, effectsIndex, damageFactor):
    global numberShotsReceived, numberHitsReceived
    if battle.isBattleTypeSupported and self.isPlayerVehicle and self.isAlive:
        numberShotsReceived += 1
        if damageFactor != 0:
            numberHitsReceived += 1
        updateLabels.update()


def isPlayerVehicle():
    if _player is not None:
        if hasattr(_player.inputHandler.ctrl, 'curVehicleID'):
            vId = _player.inputHandler.ctrl.curVehicleID
            v = vId.id if isinstance(vId, Vehicle) else vId
            return _player.playerVehicleID == v
        else:
            return True
    else:
        return False


@registerEvent(DamageLogPanel, '_onTotalEfficiencyUpdated')
def _onTotalEfficiencyUpdated(self, diff):
    global totalDamage, totalAssist, totalBlocked, numberHitsBlocked, old_totalDamage, damage, totalStun
    if battle.isBattleTypeSupported and isPlayerVehicle():
        isUpdate = False
        if PERSONAL_EFFICIENCY_TYPE.DAMAGE in diff:
            totalDamage = diff[PERSONAL_EFFICIENCY_TYPE.DAMAGE]
            damage = totalDamage - old_totalDamage
            old_totalDamage = totalDamage
            isUpdate = True
        if PERSONAL_EFFICIENCY_TYPE.ASSIST_DAMAGE in diff:
            totalAssist = diff[PERSONAL_EFFICIENCY_TYPE.ASSIST_DAMAGE]
            isUpdate = True
        if PERSONAL_EFFICIENCY_TYPE.STUN in diff:
            totalStun = diff[PERSONAL_EFFICIENCY_TYPE.STUN]
            isUpdate = True
        if PERSONAL_EFFICIENCY_TYPE.BLOCKED_DAMAGE in diff:
            totalBlocked = diff[PERSONAL_EFFICIENCY_TYPE.BLOCKED_DAMAGE]
            numberHitsBlocked = (numberHitsBlocked + 1) if totalBlocked else 0
            isUpdate = True
        if isUpdate:
            updateLabels.update()


@registerEvent(BattleRibbonsPanel, '_BattleRibbonsPanel__onRibbonUpdated')
def BattleRibbonsPanel__onRibbonUpdated(self, ribbon):
    global ribbonTypes, numberDamagesDealt, numberAssistTrack, numberAssistSpot, numberAssistStun
    if battle.isBattleTypeSupported and isPlayerVehicle():
        ribbonType = ribbon.getType()
        if ribbonType == 'assistTrack':
            ribbonTypes[ribbonType] = (totalAssist - ribbonTypes['assistSpot']) if totalAssist else 0
            numberAssistTrack += 1
            updateLabels.update()
        elif ribbonType == 'assistSpot':
            ribbonTypes[ribbonType] = (totalAssist - ribbonTypes['assistTrack']) if totalAssist else 0
            numberAssistSpot += 1
            updateLabels.update()
        elif ribbonType == 'damage':
            numberDamagesDealt += 1
            updateLabels.update()
        elif ribbonType == 'assistStun':
            numberAssistStun += 1
            updateLabels.update()


@registerEvent(BattleRibbonsPanel, '_BattleRibbonsPanel__onRibbonAdded')
def BattleRibbonsPanel__onRibbonAdded(self, ribbon):
    global ribbonTypes, numberDamagesDealt, numberAssistTrack, numberAssistSpot, numberAssistStun
    if battle.isBattleTypeSupported and isPlayerVehicle():
        ribbonType = ribbon.getType()
        if ribbonType == 'assistTrack':
            ribbonTypes[ribbonType] = (totalAssist - ribbonTypes['assistSpot']) if totalAssist else 0
            numberAssistTrack += 1
            updateLabels.update()
        elif ribbonType == 'assistSpot':
            ribbonTypes[ribbonType] = (totalAssist - ribbonTypes['assistTrack']) if totalAssist else 0
            numberAssistSpot += 1
            updateLabels.update()
        elif ribbonType == 'crits':
            ribbonTypes[ribbonType] += ribbon.getExtraValue()
            updateLabels.update()
        elif ribbonType == 'kill':
            ribbonTypes[ribbonType] += 1
            updateLabels.update()
        elif ribbonType == 'spotted':
            ribbonTypes[ribbonType] += ribbon.getTargetsAmount()
            updateLabels.update()
        elif ribbonType in ['damage', 'ram', 'burn']:
            numberDamagesDealt += 1
            updateLabels.update()
        elif ribbonType == 'assistStun':
            numberAssistStun += 1
            updateLabels.update()


@registerEvent(Vehicle, 'onHealthChanged')
def onHealthChanged(self, newHealth, oldHealth, attackerID, attackReasonID):
    global enemiesHealth, numberHitsDealt, damageReceived, numberDamagesDealt, numberDamagedVehicles, dmgAlly, damageKind, damagesSquad
    if not battle.isBattleTypeSupported:
        return
    isUpdate = False
    if self.isPlayerVehicle:
        damageReceived = maxHealth - max(0, newHealth)
        isUpdate = True
    if _player is not None and hasattr(_player, 'playerVehicleID'):
        if self.id in enemiesHealth:
            _damage = enemiesHealth[self.id] - max(0, newHealth)
            enemiesHealth[self.id] = newHealth
            if attackerID in alliesDamage:
                alliesDamage[attackerID] += _damage
            if arenaDP.isSquadMan(vID=attackerID) and attackerID != _player.playerVehicleID:
                damagesSquad += _damage
                isUpdate = True
        if attackerID == _player.playerVehicleID:
            if not dmgAlly and self.id in allyVehicles:
                dmgAlly = True
            if attackReasonID == 0:
                numberHitsDealt += 1
            damageKind = ATTACK_REASONS[min(attackReasonID, 6)]
            isUpdate = True
    if isUpdate:
        updateLabels.update()


@registerEvent(Vehicle, 'onEnterWorld')
def onEnterWorld(self, prereqs):
    global _player, isPlayerInSquad, isStuns, enemiesHealth, allyVehicles, enemyVehiclesMaxHP, enemyVehiclesSumMaxHP, arenaDP, alliesDamage
    if not battle.isBattleTypeSupported:
        return
    if _player is None:
        _player = player()
        arenaDP = _player.guiSessionProvider.getArenaDP()
    if self.publicInfo['team'] != _player.team:
        enemiesHealth[self.id] = self.health if self.health is not None else 0
        if self.id in enemyVehiclesMaxHP and enemyVehiclesMaxHP[self.id] < self.health:
            enemyVehiclesMaxHP[self.id] = self.health if self.health is not None else 0
            enemyVehiclesSumMaxHP = sum(enemyVehiclesMaxHP.values())
    else:
        allyVehicles.append(self.id)
        if self.id not in alliesDamage:
            alliesDamage[self.id] = 0
    if self.isPlayerVehicle:
        global maxHealth, vehCD, burst
        isPlayerInSquad = arenaDP.isSquadMan(_player.playerVehicleID)
        vehCD = self.typeDescriptor.type.compactDescr
        burst = self.typeDescriptor.gun.burst[0]
        maxHealth = self.health
        isStuns = 'st' if self.typeDescriptor.shot.shell.hasStun else None


@registerEvent(FragsCollectableStats, 'addVehicleStatusUpdate')
def FragsCollectableStats_addVehicleStatusUpdate(self, vInfoVO):
    global enemyVehiclesMaxHP, enemyVehiclesSumMaxHP, _player, arenaDP
    if _player is None:
        _player = player()
        arenaDP = _player.guiSessionProvider.getArenaDP()
    if vInfoVO.vehicleID not in enemyVehiclesMaxHP and vInfoVO.team != _player.team:
        enemyVehiclesMaxHP[vInfoVO.vehicleID] = vInfoVO.vehicleType.maxHealth if vInfoVO.vehicleType.maxHealth is not None else 0
        enemyVehiclesSumMaxHP = sum(enemyVehiclesMaxHP.values())


@registerEvent(PlayerAvatar, '_PlayerAvatar__destroyGUI')
def totalEfficiency_destroyGUI(self):
    global enemiesHealth, totalDamage, totalAssist, totalBlocked, damageReceived, damagesSquad, isPlayerInSquad, dmgAlly, alliesDamage
    global ribbonTypes, numberHitsBlocked, _player, numberHitsDealt, old_totalDamage, damage, numberShotsDealt, totalStun
    global numberDamagesDealt, numberShotsReceived, numberHitsReceived, numberHits, fragsSquad, fragsSquad_dict, isStuns
    global numberStuns, numberDamagedVehicles, hitAlly, allyVehicles, burst, numberAssistTrack, numberAssistSpot, numberAssistStun
    global damageKind, enemyVehiclesMaxHP, enemyVehiclesSumMaxHP, arenaDP
    enemiesHealth = {}
    alliesDamage = {}
    enemyVehiclesMaxHP = {}
    enemyVehiclesSumMaxHP = 0
    totalDamage = 0
    damage = 0
    old_totalDamage = 0
    totalAssist = 0
    totalBlocked = 0
    damageReceived = 0
    damagesSquad = 0
    numberHitsBlocked = 0
    _player = None
    arenaDP = None
    numberHitsDealt = 0
    numberShotsDealt = 0
    numberDamagesDealt = 0
    numberShotsReceived = 0
    numberHitsReceived = 0
    numberHits = 0
    fragsSquad = 0
    fragsSquad_dict = {}
    isPlayerInSquad = False
    totalStun = 0
    numberStuns = 0
    numberAssistTrack = 0
    numberAssistSpot = 0
    numberAssistStun = 0
    isStuns = None
    hitAlly = False
    dmgAlly = False
    burst = 1
    numberDamagedVehicles = []
    allyVehicles = []
    damageKind = None
    ribbonTypes = {
        'armor': 0,
        'damage': 0,
        'ram': 0,
        'burn': 0,
        'kill': 0,
        'teamKill': 0,
        'spotted': 0,
        'assistTrack': 0,
        'assistSpot': 0,
        'crits': 0,
        'capture': 0,
        'defence': 0,
        'assist': 0
    }
    updateLabels.cancelUpdate()


@overrideMethod(RibbonsAggregator, 'suspend')
def suspend(base, self):
    if battle.isBattleTypeSupported:
        self.resume()
    else:
        base(self)
