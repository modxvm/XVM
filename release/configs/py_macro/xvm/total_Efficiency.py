import BigWorld
from xfw import *
from xfw_actionscript.python import *
from xvm_main.python.logger import *
from Vehicle import Vehicle
from Avatar import PlayerAvatar
from gui.battle_control.battle_constants import PERSONAL_EFFICIENCY_TYPE
from gui.Scaleform.daapi.view.battle.shared.damage_log_panel import DamageLogPanel
from gui.Scaleform.daapi.view.battle.shared.ribbons_panel import BattleRibbonsPanel
from vehicle_extras import ShowShooting
from constants import VEHICLE_HIT_FLAGS as VHF
from gui.battle_control.arena_info.arena_dp import ArenaDataProvider
from gui.battle_control.battle_ctx import BattleContext


totalDamage = 0
damage = 0
old_totalDamage = 0
totalAssist = 0
totalBlocked = 0
maxHealth = 0
damageReceived = 0
vehiclesHealth = {}
damagesSquad = 0
detection = 0
numberHitsBlocked = 0
vehCD = None
player = None
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
isStuns = None
numberDamagedVehicles = []
hitAlly = False
burst = 1
allyVehicles = []


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


@overrideMethod(BattleContext, 'hasSquadRestrictions')
def _hasSquadRestrictions(base, self):
    result = base(self)
    global isPlayerInSquad
    if result:
        isPlayerInSquad = True
        as_event('ON_TOTAL_EFFICIENCY')
    return result


@registerEvent(ArenaDataProvider, 'updateVehicleStats')
def ArenaDataProvider_updateVehicleStats(self, vID, vStats):
    global fragsSquad, fragsSquad_dict
    if vID and player is not None:
        if player.guiSessionProvider.getArenaDP().isSquadMan(vID=vID) and vID != player.playerVehicleID:
            fragsSquad_dict[vID] = vStats.get('frags', 0)
            fragsSquad = 0
            for value in fragsSquad_dict.itervalues():
                fragsSquad += value
            as_event('ON_TOTAL_EFFICIENCY')


@registerEvent(PlayerAvatar, 'showShotResults')
def PlayerAvatar_showShotResults(self, results):
    global numberHits, numberStuns, numberDamagedVehicles, hitAlly
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
        as_event('ON_TOTAL_EFFICIENCY')


@registerEvent(ShowShooting, '_start')
def ShowShooting_start(self, data, burstCount):
    global numberShotsDealt
    vehicle = data['entity']
    if vehicle is not None and vehicle.isPlayerVehicle and vehicle.isAlive():
        numberShotsDealt += burst
        as_event('ON_TOTAL_EFFICIENCY')


@registerEvent(Vehicle, 'showDamageFromShot')
def showDamageFromShot(self, attackerID, points, effectsIndex, damageFactor):
    global numberShotsReceived, numberHitsReceived
    if self.isPlayerVehicle and self.isAlive:
        numberShotsReceived += 1
        if damageFactor != 0:
            numberHitsReceived += 1
        as_event('ON_TOTAL_EFFICIENCY')


def isPlayerVehicle():
    if player is not None:
        if hasattr(player.inputHandler.ctrl, 'curVehicleID'):
            vId = player.inputHandler.ctrl.curVehicleID
            v = vId.id if isinstance(vId, Vehicle) else vId
            return player.playerVehicleID == v
        else:
            return True
    else:
        return False


@registerEvent(DamageLogPanel, '_onTotalEfficiencyUpdated')
def _onTotalEfficiencyUpdated(self, diff):
    global totalDamage, totalAssist, totalBlocked, numberHitsBlocked, old_totalDamage, damage, totalStun
    if isPlayerVehicle():
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
            if totalBlocked == 0:
                numberHitsBlocked = 0
            else:
                numberHitsBlocked += 1
            isUpdate = True
        if isUpdate:
            as_event('ON_TOTAL_EFFICIENCY')


@registerEvent(BattleRibbonsPanel, '_BattleRibbonsPanel__onRibbonUpdated')
def BattleRibbonsPanel__onRibbonUpdated(self, ribbon):
    global ribbonTypes, numberDamagesDealt
    if isPlayerVehicle():
        ribbonType = ribbon.getType()
        if ribbonType == 'assistTrack':
            ribbonTypes[ribbonType] = (totalAssist - ribbonTypes['assistSpot']) if totalAssist else 0
            as_event('ON_TOTAL_EFFICIENCY')
        elif ribbonType == 'assistSpot':
            ribbonTypes[ribbonType] = (totalAssist - ribbonTypes['assistTrack']) if totalAssist else 0
            as_event('ON_TOTAL_EFFICIENCY')
        elif ribbonType in ['damage']:
            numberDamagesDealt += 1
            as_event('ON_TOTAL_EFFICIENCY')


@registerEvent(BattleRibbonsPanel, '_BattleRibbonsPanel__onRibbonAdded')
def BattleRibbonsPanel__onRibbonAdded(self, ribbon):
    global ribbonTypes, numberDamagesDealt
    if isPlayerVehicle():
        ribbonType = ribbon.getType()
        if ribbonType == 'assistTrack':
            ribbonTypes[ribbonType] = (totalAssist - ribbonTypes['assistSpot']) if totalAssist else 0
            as_event('ON_TOTAL_EFFICIENCY')
        elif ribbonType == 'assistSpot':
            ribbonTypes[ribbonType] = (totalAssist - ribbonTypes['assistTrack']) if totalAssist else 0
            as_event('ON_TOTAL_EFFICIENCY')
        elif ribbonType == 'crits':
            ribbonTypes[ribbonType] += ribbon.getExtraValue()
            as_event('ON_TOTAL_EFFICIENCY')
        elif ribbonType == 'kill':
            ribbonTypes[ribbonType] += 1
            as_event('ON_TOTAL_EFFICIENCY')
        elif ribbonType == 'spotted':
            ribbonTypes[ribbonType] += ribbon.getCount()
            as_event('ON_TOTAL_EFFICIENCY')
        elif ribbonType in ['damage', 'ram', 'burn']:
            numberDamagesDealt += 1
            as_event('ON_TOTAL_EFFICIENCY')


@registerEvent(Vehicle, 'onHealthChanged')
def onHealthChanged(self, newHealth, attackerID, attackReasonID):
    global vehiclesHealth, numberHitsDealt, damageReceived, numberDamagesDealt, numberDamagedVehicles
    isUpdate = False
    if self.isPlayerVehicle:
        damageReceived = maxHealth - max(0, newHealth)
        isUpdate = True
    if player is not None and hasattr(player, 'playerVehicleID'):
        if self.id in vehiclesHealth:
            damage = vehiclesHealth[self.id] - max(0, newHealth)
            vehiclesHealth[self.id] = newHealth
            if player.guiSessionProvider.getArenaDP().isSquadMan(vID=attackerID) and attackerID != player.playerVehicleID:
                global damagesSquad
                damagesSquad += damage
                isUpdate = True
        if (attackerID == player.playerVehicleID) and (attackReasonID == 0):
            numberHitsDealt += 1
            isUpdate = True
    if isUpdate:
        as_event('ON_TOTAL_EFFICIENCY')


@registerEvent(Vehicle, 'onEnterWorld')
def onEnterWorld(self, prereqs):
    global player, isPlayerInSquad, isStuns, vehiclesHealth, allyVehicles
    if player is None:
        player = BigWorld.player()
    if self.publicInfo['team'] != player.team:
        vehiclesHealth[self.id] = self.health
    else:
        allyVehicles.append(self.id)
    if self.isPlayerVehicle:
        global maxHealth, vehCD, burst
        isPlayerInSquad = player.guiSessionProvider.getArenaDP().isSquadMan(player.playerVehicleID)
        vehCD = self.typeDescriptor.type.compactDescr
        burst = self.typeDescriptor.gun.burst[0]
        maxHealth = self.health
        isStuns = 'st' if self.typeDescriptor.shot.shell.hasStun else None


@registerEvent(PlayerAvatar, '_PlayerAvatar__destroyGUI')
def destroyGUI(self):
    global vehiclesHealth, totalDamage, totalAssist, totalBlocked, damageReceived, damagesSquad, detection, isPlayerInSquad
    global ribbonTypes, numberHitsBlocked, player, numberHitsDealt, old_totalDamage, damage, numberShotsDealt, totalStun
    global numberDamagesDealt, numberShotsReceived, numberHitsReceived, numberHits, fragsSquad, fragsSquad_dict, isStuns
    global numberStuns, numberDamagedVehicles, hitAlly, allyVehicles, burst
    vehiclesHealth = {}
    totalDamage = 0
    damage = 0
    old_totalDamage = 0
    totalAssist = 0
    totalBlocked = 0
    damageReceived = 0
    damagesSquad = 0
    detection = 0
    numberHitsBlocked = 0
    player = None
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
    isStuns = None
    hitAlly = False
    burst = 1
    numberDamagedVehicles = []
    allyVehicles = []
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

