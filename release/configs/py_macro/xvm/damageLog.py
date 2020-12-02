# Addons: "DamageLog"
# ktulho <https://kr.cm/f/p/17624/>

import BigWorld
import ResMgr
import nations
from Avatar import PlayerAvatar
from Vehicle import Vehicle
from VehicleEffects import DamageFromShotDecoder
from constants import ITEM_DEFS_PATH, DAMAGE_INFO_CODES, VEHICLE_CLASSES
from gui.Scaleform.daapi.view.battle.shared.damage_log_panel import DamageLogPanel
from gui.Scaleform.daapi.view.meta.DamagePanelMeta import DamagePanelMeta
from gui.shared.utils.TimeInterval import TimeInterval
from helpers import dependency
from items import _xml
from skeletons.gui.battle_session import IBattleSessionProvider
from skeletons.gui.game_control import IBootcampController
from vehicle_systems.tankStructure import TankPartIndexes

from xfw.events import registerEvent, overrideMethod
from xfw_actionscript.python import *

import xvm_battle.python.battle as battle
import xvm_main.python.config as config
import xvm_main.python.userprefs as userprefs
from xvm_main.python.logger import *
from xvm_main.python.stats import _stat

import parser_addon

on_fire = 0
isDownAlt = False
damageLogConfig = {}
macros = None
chooseRating = None
isImpact = False
isShowDamageLog = True

ATTACK_REASONS = {
    0: 'shot',
    1: 'fire',
    2: 'ramming',
    3: 'world_collision',
    4: 'death_zone',
    5: 'drowning',
    6: 'gas_attack',
    7: 'overturn',
    8: 'manual',
    9: 'artillery_protection',
    10: 'artillery_sector',
    11: 'bombers',
    12: 'recovery',
    13: 'artillery_eq',
    14: 'bomber_eq',
    15: 'minefield_eq',
    16: 'none',
    17: 'spawned_bot_explosion',
    18: 'berserker_eq',
    19: 'spawned_bot_ram',
    20: 'smoke',
    31: 'art_attack',
    32: 'air_strike'
}

SHOT_EFFECTS_INDEXES = {
    31: 31,
    32: 32,
    33: 31,
    34: 32
}

VEHICLE_CLASSES_SHORT = {
    'mediumTank': 'mt',
    'lightTank': 'lt',
    'heavyTank': 'ht',
    'AT-SPG': 'td',
    'SPG': 'spg',
    'not_vehicle': 'not_vehicle'
}

HIT_EFFECT_CODES = {
    None: 'unknown',
    0: 'intermediate_ricochet',
    1: 'final_ricochet',
    2: 'armor_not_pierced',
    3: 'armor_pierced_no_damage',
    4: 'armor_pierced',
    5: 'critical_hit'
}

RATINGS = {
    'xvm_wgr': {'name': 'xwgr', 'size': 2},
    'xvm_wtr': {'name': 'xwtr', 'size': 2},
    'xvm_wn8': {'name': 'xwn8', 'size': 2},
    'xvm_eff': {'name': 'xeff', 'size': 2},
    'xvm_xte': {'name': 'xte', 'size': 2},
    'basic_wgr': {'name': 'wgr', 'size': 5},
    'basic_wtr': {'name': 'wtr', 'size': 4},
    'basic_wn8': {'name': 'wn8', 'size': 4},
    'basic_eff': {'name': 'eff', 'size': 4},
    'basic_xte': {'name': 'xte', 'size': 2}
}

DEVICES_TANKMAN = {'engineHealth': 'engine_crit',
                   'ammoBayHealth': 'ammo_bay_crit',
                   'fuelTankHealth': 'fuel_tank_crit',
                   'radioHealth': 'radio_crit',
                   'leftTrackHealth': 'left_track_crit',
                   'rightTrackHealth': 'right_track_crit',
                   'gunHealth': 'gun_crit',
                   'turretRotatorHealth': 'turret_rotator_crit',
                   'surveyingDeviceHealth': 'surveying_device_crit',
                   'commanderHealth': 'commander',
                   'driverHealth': 'driver',
                   'radioman1Health': 'radioman',
                   'radioman2Health': 'radioman',
                   'gunner1Health': 'gunner',
                   'gunner2Health': 'gunner',
                   'loader1Health': 'loader',
                   'loader2Health': 'loader',
                   'engineHealth_destr': 'engine_destr',
                   'ammoBayHealth_destr': 'ammo_bay_destr',
                   'fuelTankHealth_destr': 'fuel_tank_destr',
                   'radioHealth_destr': 'radio_destr',
                   'leftTrackHealth_destr': 'left_track_destr',
                   'rightTrackHealth_destr': 'right_track_destr',
                   'gunHealth_destr': 'gun_destr',
                   'turretRotatorHealth_destr': 'turret_rotator_destr',
                   'surveyingDeviceHealth_destr': 'surveying_device_destr'
                   }

ADD_LINE = -1

FORMAT_HISTORY = 'formatHistory'
ENABLED = 'enabled'
SHADOW = 'shadow/'
COLOR_RATING = 'colors'
COLOR_RATING_X = 'colors/x'

FORMAT_LAST_HIT = 'formatLastHit'
SHOW_HIT_NO_DAMAGE = 'showHitNoDamage'
MOVE_IN_BATTLE = 'moveInBattle'
TIME_DISPLAY_LAST_HIT = 'timeDisplayLastHit'
DAMAGE_LOG = 'damageLog/'
DAMAGE_LOG_ENABLED = DAMAGE_LOG + ENABLED
DAMAGE_LOG_DISABLED_DETAIL_STATS = DAMAGE_LOG + 'disabledDetailStats'
DAMAGE_LOG_DISABLED_SUMMARY_STATS = DAMAGE_LOG + 'disabledSummaryStats'

damageInfoCriticals = ('DEVICE_CRITICAL',
                       'DEVICE_CRITICAL_AT_SHOT',
                       'DEVICE_CRITICAL_AT_RAMMING',
                       'DEVICE_CRITICAL_AT_FIRE',
                       'DEVICE_CRITICAL_AT_WORLD_COLLISION',
                       'DEVICE_CRITICAL_AT_DROWNING',
                       'ENGINE_CRITICAL_AT_UNLIMITED_RPM'
                       )
damageInfoDestructions = ('DEVICE_DESTROYED',
                          'DEVICE_DESTROYED_AT_SHOT',
                          'DEVICE_DESTROYED_AT_RAMMING',
                          'DEVICE_DESTROYED_AT_FIRE',
                          'DEVICE_DESTROYED_AT_WORLD_COLLISION',
                          'DEVICE_DESTROYED_AT_DROWNING',
                          'ENGINE_DESTROYED_AT_UNLIMITED_RPM',
                          'DEATH_FROM_DEVICE_EXPLOSION_AT_SHOT'
                          )
damageInfoTANKMAN = ('TANKMAN_HIT',
                     'TANKMAN_HIT_AT_SHOT',
                     'TANKMAN_HIT_AT_WORLD_COLLISION',
                     'TANKMAN_HIT_AT_DROWNING'
                     )


class GROUP_DAMAGE(object):
    RAMMING_COLLISION = 'groupDamagesFromRamming_WorldCollision'
    FIRE = 'groupDamagesFromFire'
    ART_AND_AIRSTRIKE = 'groupDamageFromArtAndAirstrike'


class EVENTS_NAMES(object):
    ON_HIT = 'ON_HIT'
    ON_LAST_HIT = 'ON_LAST_HIT'
    ON_FIRE = 'ON_FIRE'
    ON_IMPACT = 'ON_IMPACT'


class SHADOW_OPTIONS(object):
    DISTANCE = 'distance'
    ANGLE = 'angle'
    ALPHA = 'alpha'
    BLUR = 'blur'
    STRENGTH = 'strength'
    COLOR = 'color'
    HIDE_OBJECT = 'hideobject'
    INNER = 'inner'
    KNOCKOUT = 'knockout'
    QUALITY = 'quality'


class DAMAGE_LOG_SECTIONS(object):
    LOG = DAMAGE_LOG + 'log/'
    LOG_ALT = DAMAGE_LOG + 'logAlt/'
    LOG_BACKGROUND = DAMAGE_LOG + 'logBackground/'
    LOG_ALT_BACKGROUND = DAMAGE_LOG + 'logAltBackground/'
    LAST_HIT = DAMAGE_LOG + 'lastHit/'
    LAST_HIT_BACKGROUND = DAMAGE_LOG + 'lastHitBackground/'
    SECTIONS = (LOG, LOG_ALT, LOG_BACKGROUND, LOG_ALT_BACKGROUND, LAST_HIT, LAST_HIT_BACKGROUND)


def keyLower(_dict):
    return {key.lower(): _dict[key] for key in _dict.iterkeys()} if _dict is not None else None


def parser(strHTML):
    s = parser_addon.parser_addon(strHTML, macros)
    return s


class ConfigCache(object):

    def __init__(self):
        self.__configCache = {}

    def get(self, key, default=None):
        if config.config_autoreload:
            return config.get(key, default)
        else:
            return self.__configCache.setdefault(key, config.get(key, default))


_config = ConfigCache()


def readyConfig(section):
    if config.config_autoreload or (section not in damageLogConfig):
        return {'vehicleClass': keyLower(_config.get(section + 'vtype')),
                'c_Shell': keyLower(_config.get(section + 'c:costShell')),
                'costShell': keyLower(_config.get(section + 'costShell')),
                'c_typeHit': keyLower(_config.get(section + 'c:dmg-kind')),
                'c_VehicleClass': keyLower(_config.get(section + 'c:vtype')),
                'typeHit': keyLower(_config.get(section + 'dmg-kind')),
                'c_teamDmg': keyLower(_config.get(section + 'c:team-dmg')),
                'teamDmg': keyLower(_config.get(section + 'team-dmg')),
                'compNames': keyLower(_config.get(section + 'comp-name')),
                'splashHit': keyLower(_config.get(section + 'splash-hit')),
                'criticalHit': keyLower(_config.get(section + 'critical-hit')),
                'hitEffect': keyLower(_config.get(section + 'hit-effects')),
                'c_hitEffect': keyLower(_config.get(section + 'c:hit-effects')),
                'typeShell': keyLower(_config.get(section + 'type-shell')),
                'c_typeShell': keyLower(_config.get(section + 'c:type-shell')),
                'critDevice': keyLower(_config.get(section + 'crit-device'))
                }
    else:
        return damageLogConfig[section]


class Data(object):
    sessionProvider = dependency.descriptor(IBattleSessionProvider)
    bootcampController = dependency.descriptor(IBootcampController)

    def __init__(self):
        self.reset()
        xmlPath = ''
        self.shells = {}
        self.shells_stunning = {}
        for nation in nations.NAMES:
            xmlPath = '%s%s%s%s' % (ITEM_DEFS_PATH, 'vehicles/', nation, '/components/shells.xml')
            xmlCtx_s = (((None, '{}/{}'.format(xmlPath, n)), s) for n, s in ResMgr.openSection(xmlPath).items() if (n != 'icons') and (n != 'xmlns:xmlref'))
            id_xmlCtx_s = ((_xml.readInt(xmlCtx, s, 'id', 0, 65535), xmlCtx, s) for xmlCtx, s in xmlCtx_s)
            self.shells[nation] = [i for i, xmlCtx, s in id_xmlCtx_s if s.readBool('improved', False)]
            self.shells_stunning[nation] = [i for i, xmlCtx, s in id_xmlCtx_s if _xml.readStringOrNone(xmlCtx, s, 'stunDuration')]
        ResMgr.purge(xmlPath, True)

    def reset(self):
        self.data = {'isAlive': True,
                     'isDamage': False,
                     'attackReasonID': 0,
                     'attackerID': 0,
                     'compName': 'unknown',
                     'splashHit': 'no-splash',
                     'criticalHit': False,
                     'hitEffect': 'unknown',
                     'damage': 0,
                     'dmgRatio': 0,
                     'oldHealth': 0,
                     'maxHealth': 0,
                     'costShell': 'unknown',
                     'shellKind': 'not_shell',
                     'teamDmg': 'unknown',
                     'attackerVehicleType': 'not_vehicle',
                     'shortUserString': '',
                     'name': '',
                     'clanAbbrev': '',
                     'level': 1,
                     'clanicon': None,
                     'squadnum': None,
                     'number': None,
                     'reloadGun': 0.0,
                     'caliber': None,
                     'shellDamage': None,
                     'fireDuration': None,
                     'diff-masses': None,
                     'nation': None,
                     'blownup': False,
                     'stun-duration': None,
                     'shells_stunning': False,
                     'critDevice': 'no-critical',
                     'hitTime': 0,
                     'attackerVehicleName': ''
                     }

    def updateData(self):
        if self.bootcampController.isInBootcamp():
            return
        player = BigWorld.player()
        self.data['dmgRatio'] = self.data['damage'] * 100 // self.data['maxHealth']
        attackerID = self.data['attackerID']
        minutes, seconds = divmod(int(self.sessionProvider.shared.arenaPeriod.getEndTime() - BigWorld.serverTime()), 60)
        self.data['hitTime'] = '{:02d}:{:02d}'.format(minutes, seconds)
        self.data['level'] = None
        self.data['nation'] = None
        self.data['diff-masses'] = None
        self.data['wn8'] = None
        self.data['xwn8'] = None
        self.data['wtr'] = None
        self.data['xwtr'] = None
        self.data['eff'] = None
        self.data['xeff'] = None
        self.data['wgr'] = None
        self.data['xwgr'] = None
        self.data['xte'] = None
        self.data['teamDmg'] = 'unknown'
        self.data['attackerVehicleType'] = 'not_vehicle'
        self.data['attackerVehicleName'] = ''
        self.data['shortUserString'] = ''
        self.data['name'] = ''
        self.data['clanAbbrev'] = ''
        self.data['clanicon'] = None
        self.data['squadnum'] = None
        if attackerID:
            attacker = player.arena.vehicles.get(attackerID)
            if attacker is not None:
                self.data['teamDmg'] = 'enemy-dmg' if attacker['team'] != player.team else 'player' if attacker['fakeName'] == player.name else 'ally-dmg'
                vehicleType = attacker['vehicleType']
                if vehicleType:
                    _type = vehicleType.type
                    self.data['attackerVehicleName'] = vehicleType.name.replace(':', '-', 1) if vehicleType.name else ''
                    self.data['attackerVehicleType'] = list(_type.tags.intersection(VEHICLE_CLASSES))[0]
                    self.data['shortUserString'] = _type.shortUserString
                    self.data['level'] = vehicleType.level
                    self.data['nation'] = nations.NAMES[_type.customizationNationID]
                    if self.data['attackReasonID'] == 2:
                        self.data['diff-masses'] = (player.vehicleTypeDescriptor.physics['weight'] - vehicleType.physics['weight']) / 1000.0
                self.data['name'] = attacker['fakeName']
                if (_stat.resp is not None) and ('players' in _stat.resp) and (attacker['fakeName'] in _stat.resp['players']):
                    stats = _stat.resp['players'][attacker['fakeName']]
                    self.data['wn8'] = stats.get('wn8', None)
                    self.data['xwn8'] = stats.get('xwn8', None)
                    self.data['wtr'] = stats.get('wtr', None)
                    self.data['xwtr'] = stats.get('xwtr', None)
                    self.data['eff'] = stats.get('eff', None)
                    self.data['xeff'] = stats.get('xeff', None)
                    self.data['wgr'] = stats.get('wgr', None)
                    self.data['xwgr'] = stats.get('xwgr', None)
                    self.data['xte'] = stats.get('v').get('xte', None)
                self.data['clanAbbrev'] = attacker['clanAbbrev']
            self.data['clanicon'] = _stat.getClanIcon(attackerID)
            arenaDP = self.sessionProvider.getArenaDP()
            if arenaDP is not None:
                vInfo = arenaDP.getVehicleInfo(vID=attackerID)
                self.data['squadnum'] = vInfo.squadIndex if vInfo.squadIndex != 0 else None
        self.updateLabels()

    def typeShell(self, effectsIndex):
        self.data['costShell'] = 'unknown'
        self.data['shellKind'] = 'not_shell'
        self.data['caliber'] = None
        self.data['shellDamage'] = None
        if (self.data['attackerID'] == 0) or (self.data['attackReasonID'] != 0):
            return
        player = BigWorld.player()
        attacker = player.arena.vehicles.get(self.data['attackerID'])
        if (attacker is None) or not attacker['vehicleType']:
            return
        for shot in attacker['vehicleType'].gun.shots:
            _shell = shot.shell
            if effectsIndex == _shell.effectsIndex:
                self.data['shellKind'] = str(_shell.kind).lower()
                self.data['caliber'] = _shell.caliber
                self.data['shellDamage'] = _shell.damage[0]
                _id = _shell.id
                nation = nations.NAMES[_id[0]]
                self.data['costShell'] = 'gold-shell' if _id[1] in self.shells[nation] else 'silver-shell'
                self.data['shells_stunning'] = _id[1] in self.shells_stunning[nation]
                break

    def timeReload(self, attackerID):
        player = BigWorld.player()
        attacker = player.arena.vehicles.get(attackerID)
        if attacker is not None:
            vehicleType = attacker['vehicleType']
            if (attacker is not None) and (vehicleType):
                reload_orig = vehicleType.gun.reloadTime
                _miscAttrs = vehicleType.miscAttrs
                crew = 0.94 if _miscAttrs['crewLevelIncrease'] != 0 else 1.0
                if (vehicleType.gun.clip[0] == 1) and (_miscAttrs['gunReloadTimeFactor'] != 0.0):
                    rammer = _miscAttrs['gunReloadTimeFactor']
                else:
                    rammer = 1
                return reload_orig * crew * rammer
            else:
                return 0.0
        else:
            return 0.0

    def hitShell(self, attackerID, effectsIndex, damageFactor):
        self.data['stun-duration'] = None
        self.data['attackerID'] = attackerID
        # self.data['attackReasonID'] = effectsIndex if effectsIndex in [24, 25] else 0
        self.data['attackReasonID'] = SHOT_EFFECTS_INDEXES.get(effectsIndex, 0)
        self.data['reloadGun'] = self.timeReload(attackerID)
        self.typeShell(effectsIndex)
        self.data['damage'] = 0
        if damageFactor > 0:
            self.data['hitEffect'] = HIT_EFFECT_CODES[4]
        elif self.data['shells_stunning']:
            pass
        else:
            self.updateData()

    def updateLabels(self):
        global macros
        macros = None
        _log.callEvent = _logBackground.callEvent = not isDownAlt
        _logAlt.callEvent = _logAltBackground.callEvent = isDownAlt
        _logAlt.output()
        _log.output()
        _lastHit.output()
        _lastHitBackground.output()
        _logBackground.output()
        _logAltBackground.output()
        self.data['critDevice'] = 'no-critical'
        self.data['criticalHit'] = False
        self.data['isDamage'] = False
        self.data['hitEffect'] = 'unknown'
        self.data['splashHit'] = 'no-splash'
        self.data['attackReasonID'] = 0

    def showDamageFromShot(self, vehicle, attackerID, points, effectsIndex, damageFactor):
        if not vehicle.isStarted:
            return
        maxComponentIdx = TankPartIndexes.ALL[-1]
        wheelsConfig = vehicle.appearance.typeDescriptor.chassis.generalWheelsAnimatorConfig
        if wheelsConfig:
            maxComponentIdx += wheelsConfig.getWheelsCount()
        maxHitEffectCode, decodedPoints, maxDamagedComponent = DamageFromShotDecoder.decodeHitPoints(points, vehicle.appearance.collisions, maxComponentIdx)
        if decodedPoints:
            compName = decodedPoints[0].componentName
            self.data['compName'] = compName if compName[0] != 'W' else 'wheel'
        else:
            self.data['compName'] = 'unknown'

        # self.data['criticalHit'] = (maxHitEffectCode == 5)
        if damageFactor == 0:
            self.data['hitEffect'] = HIT_EFFECT_CODES[min(3, maxHitEffectCode)]
            self.data['isAlive'] = bool(vehicle.isCrewActive)
        self.hitShell(attackerID, effectsIndex, damageFactor)

    def showDamageFromExplosion(self, vehicle, attackerID, center, effectsIndex, damageFactor):
        self.data['splashHit'] = 'splash'
        # self.data['criticalHit'] = False
        if damageFactor == 0:
            self.data['hitEffect'] = HIT_EFFECT_CODES[3]
            self.data['isAlive'] = bool(vehicle.isCrewActive)
        self.hitShell(attackerID, effectsIndex, damageFactor)

    def updateStunInfo(self, vehicle, stunDuration):
        self.data['stun-duration'] = stunDuration
        if (not self.data['isDamage']) and (self.data['hitEffect'] in ('armor_pierced_no_damage', 'critical_hit')):
            self.updateData()

    def showVehicleDamageInfo(self, player, vehicleID, damageIndex, extraIndex, entityID, equipmentID):
        dataUpdate = {
            'attackerID': entityID,
            'costShell': 'unknown',
            'hitEffect': 'unknown',
            'damage': 0,
            'shellKind': 'not_shell',
            'splashHit': 'no-splash',
            'reloadGun': 0.0,
            'stun-duration': None,
            'compName': 'unknown'
        }
        damageCode = DAMAGE_INFO_CODES[damageIndex]
        extra = player.vehicleTypeDescriptor.extras[extraIndex]
        if damageCode in ('DEVICE_CRITICAL_AT_RAMMING', 'DEVICE_DESTROYED_AT_RAMMING'):
            self.data['criticalHit'] = True
            if extra.name in DEVICES_TANKMAN:
                self.data['critDevice'] = DEVICES_TANKMAN[extra.name] if damageCode == 'DEVICE_CRITICAL_AT_RAMMING' else DEVICES_TANKMAN[extra.name + '_destr']
                vehicle = BigWorld.entities.get(player.playerVehicleID)
                if self.data['oldHealth'] == vehicle.health:
                    self.data.update(dataUpdate)
                    self.data['attackReasonID'] = 2
                    self.updateData()
        elif damageCode in ('DEVICE_CRITICAL_AT_WORLD_COLLISION', 'DEVICE_DESTROYED_AT_WORLD_COLLISION', 'TANKMAN_HIT_AT_WORLD_COLLISION'):
            self.data['criticalHit'] = True
            if extra.name in DEVICES_TANKMAN:
                self.data['critDevice'] = DEVICES_TANKMAN[extra.name + '_destr'] if damageCode == 'DEVICE_DESTROYED_AT_WORLD_COLLISION' else DEVICES_TANKMAN[extra.name]
                vehicle = BigWorld.entities.get(player.playerVehicleID)
                if self.data['oldHealth'] == vehicle.health:
                    self.data.update(dataUpdate)
                    self.data['attackReasonID'] = 3
                    self.updateData()
        elif damageCode == 'DEATH_FROM_DROWNING':
            self.data.update(dataUpdate)
            self.data['attackReasonID'] = 5
            self.data['isAlive'] = False
            self.data['criticalHit'] = False
            self.updateData()
        elif (damageCode in damageInfoCriticals) or (damageCode in damageInfoDestructions) or (damageCode in damageInfoTANKMAN):
            if extra.name in DEVICES_TANKMAN:
                self.data['critDevice'] = DEVICES_TANKMAN[extra.name + '_destr'] if damageCode in damageInfoDestructions else DEVICES_TANKMAN[extra.name]
            self.data['criticalHit'] = True

    def onHealthChanged(self, vehicle, newHealth, attackerID, attackReasonID):
        self.data['blownup'] = (newHealth <= -5)
        newHealth = max(0, newHealth)
        self.data['damage'] = self.data['oldHealth'] - newHealth
        self.data['oldHealth'] = newHealth
        if self.data['damage'] < 0:
            return
        if self.data['attackReasonID'] == 0:
            if (attackReasonID < 8) or (attackReasonID == 12):
                self.data['attackReasonID'] = attackReasonID
            elif attackReasonID in [9, 10, 13]:
                self.data['attackReasonID'] = 31
            elif attackReasonID in [11, 14]:
                self.data['attackReasonID'] = 32

        self.data['isDamage'] = (self.data['damage'] > 0)
        self.data['isAlive'] = vehicle.isAlive()
        self.data['hitEffect'] = HIT_EFFECT_CODES[4]
        if self.data['attackReasonID'] != 0:
            self.data['costShell'] = 'unknown'
            # self.data['criticalHit'] = False
            self.data['shellKind'] = 'not_shell'
            self.data['splashHit'] = 'no-splash'
            self.data['reloadGun'] = 0.0
            self.data['stun-duration'] = None
        else:
            self.data['reloadGun'] = self.timeReload(attackerID)
        self.data['attackerID'] = attackerID
        self.updateData()


data = Data()


class _Base(object):

    def __init__(self, section):
        self.S_MOVE_IN_BATTLE = section + MOVE_IN_BATTLE
        self.S_SHOW_HIT_NO_DAMAGE = section + SHOW_HIT_NO_DAMAGE
        self.S_GROUP_DAMAGE_RAMMING_COLLISION = section + GROUP_DAMAGE.RAMMING_COLLISION
        self.S_GROUP_DAMAGE_FIRE = section + GROUP_DAMAGE.FIRE
        self.S_GROUP_DAMAGE_ART_AND_AIRSTRIKE = section + GROUP_DAMAGE.ART_AND_AIRSTRIKE
        self.S_SHADOW = section + SHADOW
        self.SHADOW_DISTANCE = self.S_SHADOW + SHADOW_OPTIONS.DISTANCE
        self.SHADOW_ANGLE = self.S_SHADOW + SHADOW_OPTIONS.ANGLE
        self.SHADOW_ALPHA = self.S_SHADOW + SHADOW_OPTIONS.ALPHA
        self.SHADOW_BLUR = self.S_SHADOW + SHADOW_OPTIONS.BLUR
        self.SHADOW_STRENGTH = self.S_SHADOW + SHADOW_OPTIONS.STRENGTH
        self.SHADOW_COLOR = self.S_SHADOW + SHADOW_OPTIONS.COLOR
        self.SHADOW_HIDE_OBJECT = self.S_SHADOW + SHADOW_OPTIONS.HIDE_OBJECT
        self.SHADOW_INNER = self.S_SHADOW + SHADOW_OPTIONS.INNER
        self.SHADOW_KNOCKOUT = self.S_SHADOW + SHADOW_OPTIONS.KNOCKOUT
        self.SHADOW_QUALITY = self.S_SHADOW + SHADOW_OPTIONS.QUALITY

        self.S_X = section + 'x'
        self.S_Y = section + 'y'
        self.section = section
        self.dictVehicle = {}
        self.shadow = {}
        self._data = None

    def reset(self):
        self.dictVehicle = {}
        self.shadow = {}

    def mouse_down(self, _data):
        if _data['buttonIdx'] == 0:
            self._data = _data

    def mouse_up(self, _data):
        if _data['buttonIdx'] == 0:
            self._data = None

    def _mouse_move(self, _data, nameEvent):
        if self._data:
            self.x += (_data['x'] - self._data['x'])
            self.y += (_data['y'] - self._data['y'])
            as_event(nameEvent)

    def updateValueMacros(self, value):
        global macros

        def readColor(sec, m, xm=None):
            colors = _config.get('colors/' + sec)
            if m is not None and colors is not None:
                for val in colors:
                    if val['value'] > m:
                        return '#' + val['color'][2:] if val['color'][:2] == '0x' else val['color']
            elif xm is not None:
                colors_x = _config.get(COLOR_RATING_X)
                for val in colors_x:
                    if val['value'] > xm:
                        return '#' + val['color'][2:] if val['color'][:2] == '0x' else val['color']

        conf = readyConfig(self.section)
        if macros is None:
            xwn8 = value.get('xwn8', None)
            xwtr = value.get('xwtr', None)
            xeff = value.get('xeff', None)
            xwgr = value.get('xwgr', None)
            macros = {'vehicle': value['shortUserString'],
                      'name': value['name'],
                      'clannb': value['clanAbbrev'],
                      'clan': ''.join(['[', value['clanAbbrev'], ']']) if value['clanAbbrev'] else '',
                      'level': value['level'],
                      'clanicon': value.get('clanicon', None),
                      'squad-num': value['squadnum'],
                      'reloadGun': value['reloadGun'],
                      'my-alive': 'al' if value['isAlive'] else None,
                      'gun-caliber': value['caliber'],
                      'shell-dmg': value['shellDamage'],
                      'wn8': value.get('wn8', None),
                      'xwn8': value.get('xwn8', None),
                      'wtr': value.get('wtr', None),
                      'xwtr': value.get('xwtr', None),
                      'eff': value.get('eff', None),
                      'xeff': value.get('xeff', None),
                      'wgr': value.get('wgr', None),
                      'xwgr': value.get('xwgr', None),
                      'xte': value.get('xte', None),
                      'r': '{{%s}}' % chooseRating,
                      'xr': '{{%s}}' % chooseRating if chooseRating[0] == 'x' else '{{x%s}}' % chooseRating,
                      'c:r': '{{c:%s}}' % chooseRating,
                      'c:xr': '{{c:%s}}' % chooseRating if chooseRating[0] == 'x' else '{{c:x%s}}' % chooseRating,
                      'c:wn8': readColor('wn8', value.get('wn8', None), xwn8),
                      'c:xwn8': readColor('x', xwn8),
                      'c:wtr': readColor('wtr', value.get('wtr', None), xwtr),
                      'c:xwtr': readColor('x', xwtr),
                      'c:eff': readColor('eff', value.get('eff', None), xeff),
                      'c:xeff': readColor('x', xeff),
                      'c:wgr': readColor('wgr', value.get('wgr', None), xwgr),
                      'c:xwgr': readColor('x', xwgr),
                      'c:xte': readColor('x', value.get('xte', None)),
                      'diff-masses': value.get('diff-masses', None),
                      'nation': value.get('nation', None),
                      'my-blownup': 'blownup' if value['blownup'] else None,
                      'type-shell-key': value['shellKind'],
                      'stun-duration': value.get('stun-duration', None),
                      'vehiclename': value.get('attackerVehicleName', '')
                      }

        macros.update({'c:team-dmg': conf['c_teamDmg'][value['teamDmg']],
                       'team-dmg': conf['teamDmg'].get(value['teamDmg'], ''),
                       'vtype': conf['vehicleClass'].get(VEHICLE_CLASSES_SHORT[value['attackerVehicleType']], ''),
                       'c:costShell': conf['c_Shell'][value['costShell']],
                       'costShell': conf['costShell'].get(value['costShell'], 'unknown'),
                       'c:dmg-kind': conf['c_typeHit'][ATTACK_REASONS[value['attackReasonID']]],
                       'dmg-kind': conf['typeHit'].get(ATTACK_REASONS[value['attackReasonID']], 'reason: %s' % value['attackReasonID']),
                       'c:vtype': conf['c_VehicleClass'].get(VEHICLE_CLASSES_SHORT[value['attackerVehicleType']], '#CCCCCC'),
                       'comp-name': conf['compNames'].get(value['compName'], 'unknown'),
                       'splash-hit': conf['splashHit'].get(value['splashHit'], 'unknown'),
                       'critical-hit': conf['criticalHit'].get('critical') if value['criticalHit'] else conf['criticalHit'].get('no-critical'),
                       'type-shell': conf['typeShell'][value['shellKind']],
                       'c:type-shell': conf['c_typeShell'][value['shellKind']],
                       'c:hit-effects': conf['c_hitEffect'].get(value['hitEffect'], 'unknown'),
                       'hit-effects': conf['hitEffect'].get(value['hitEffect'], 'unknown'),
                       'crit-device': conf['critDevice'].get(value.get('critDevice', '')),
                       'number': value['number'],
                       'dmg': value['damage'],
                       'dmg-ratio': value['dmgRatio'],
                       'fire-duration': value.get('fireDuration', None),
                       'hitTime': value['hitTime']
                       })

    def getShadow(self):
        return {SHADOW_OPTIONS.DISTANCE: parser(_config.get(self.SHADOW_DISTANCE)),
                SHADOW_OPTIONS.ANGLE: parser(_config.get(self.SHADOW_ANGLE)),
                SHADOW_OPTIONS.ALPHA: parser(_config.get(self.SHADOW_ALPHA)),
                SHADOW_OPTIONS.BLUR: parser(_config.get(self.SHADOW_BLUR)),
                SHADOW_OPTIONS.STRENGTH: parser(_config.get(self.SHADOW_STRENGTH)),
                SHADOW_OPTIONS.COLOR: parser(_config.get(self.SHADOW_COLOR)),
                SHADOW_OPTIONS.HIDE_OBJECT: parser(_config.get(self.SHADOW_HIDE_OBJECT)),
                SHADOW_OPTIONS.INNER: parser(_config.get(self.SHADOW_INNER)),
                SHADOW_OPTIONS.KNOCKOUT: parser(_config.get(self.SHADOW_KNOCKOUT)),
                SHADOW_OPTIONS.QUALITY: parser(_config.get(self.SHADOW_QUALITY))
                }


class DamageLog(_Base):

    def __init__(self, section):
        _Base.__init__(self, section)
        self.S_FORMAT_HISTORY = section + FORMAT_HISTORY
        self.listLog = []
        self.dataLog = {}
        self.scrollList = []
        if _config.get(self.S_MOVE_IN_BATTLE):
            _data = userprefs.get(DAMAGE_LOG_SECTIONS.LOG, {'x': _config.get(self.S_X), 'y': _config.get(self.S_Y)})
            if section == DAMAGE_LOG_SECTIONS.LOG:
                as_callback("damageLog_mouseDown", self.mouse_down)
                as_callback("damageLog_mouseUp", self.mouse_up)
                as_callback("damageLog_mouseMove", self.mouse_move)
        else:
            _data = {'x': _config.get(self.S_X), 'y': _config.get(self.S_Y)}
        as_callback("damageLog_mouseWheel", self.mouse_wheel)
        self.x = _data['x']
        self.y = _data['y']
        self.section = section
        self.callEvent = True

    def reset(self, section):
        super(DamageLog, self).reset()
        self.listLog = []
        self.scrollList = []
        self.section = section
        self.dataLog = {}
        self.callEvent = True
        self.dictVehicle.clear()
        if (None not in [self.x, self.y]) and _config.get(self.S_MOVE_IN_BATTLE) and section == DAMAGE_LOG_SECTIONS.LOG:
            userprefs.set(DAMAGE_LOG_SECTIONS.LOG, {'x': self.x, 'y': self.y})

    def mouse_move(self, _data):
        self._mouse_move(_data, EVENTS_NAMES.ON_HIT)

    def mouse_wheel(self, _data):
        if _data['delta'] < 0:
            if self.listLog:
                self.scrollList.append(self.listLog.pop(0))
                as_event(EVENTS_NAMES.ON_HIT)
        else:
            if self.scrollList:
                self.listLog.insert(0, self.scrollList.pop())
                as_event(EVENTS_NAMES.ON_HIT)

    def setOutParameters(self, numberLine):
        self.updateValueMacros(self.dataLog)
        if numberLine == ADD_LINE:
            self.listLog = [parser(_config.get(self.S_FORMAT_HISTORY))] + self.listLog
        else:
            self.listLog[numberLine] = parser(_config.get(self.S_FORMAT_HISTORY))
        if (self.section == DAMAGE_LOG_SECTIONS.LOG) or (self.section == DAMAGE_LOG_SECTIONS.LOG_ALT):
            if not _config.get(self.S_MOVE_IN_BATTLE):
                self.x = parser(_config.get(self.S_X))
                self.y = parser(_config.get(self.S_Y))
            self.shadow = self.getShadow()

    def updateNumberLine(self, attackerID, attackReasonID):
        for attacker in self.dictVehicle:
            dictAttacker = self.dictVehicle[attacker]
            for attack in dictAttacker:
                if (attacker != attackerID) or (attack != attackReasonID):
                    dictAttacker[attack]['numberLine'] += 1

    def addLine(self, attackerID=None, attackReasonID=None):
        if not (attackerID is None or attackReasonID is None):
            self.dictVehicle[attackerID][attackReasonID] = {'time': BigWorld.serverTime(),
                                                            'damage': self.dataLog['damage'],
                                                            'criticalHit': self.dataLog['criticalHit'],
                                                            'numberLine': 0,
                                                            'startAction': BigWorld.time() if attackReasonID == 1 else None,
                                                            'hitTime': self.dataLog['hitTime']
                                                            }
        self.dataLog['number'] = len(self.listLog) + 1
        self.dataLog['fireDuration'] = BigWorld.time() - self.dictVehicle[attackerID][attackReasonID]['startAction'] if attackReasonID == 1 else None
        self.setOutParameters(ADD_LINE)
        self.updateNumberLine(attackerID, attackReasonID)

    def reset_scrolling(self):
        if self.scrollList:
            self.scrollList.extend(self.listLog)
            self.listLog = self.scrollList
            self.scrollList = []

    def updateGroupedValues(self, parametersDmg):
        parametersDmg['time'] = BigWorld.serverTime()
        parametersDmg['damage'] += self.dataLog['damage']
        parametersDmg['criticalHit'] = (parametersDmg['criticalHit'] or self.dataLog['criticalHit'])
        if parametersDmg['damage'] > 0:
            self.dataLog['hitEffect'] = 'armor_pierced'
        self.dataLog['criticalHit'] = parametersDmg['criticalHit']
        self.dataLog['damage'] = parametersDmg['damage']
        self.dataLog['dmgRatio'] = self.dataLog['damage'] * 100 // self.dataLog['maxHealth']
        self.dataLog['number'] = len(self.listLog) - parametersDmg['numberLine']
        if (self.dataLog['attackReasonID'] == 1) and (parametersDmg['startAction'] is not None):
            self.dataLog['fireDuration'] = BigWorld.time() - parametersDmg['startAction']
        else:
            self.dataLog['fireDuration'] = None
        self.dataLog['hitTime'] = parametersDmg['hitTime']
        self.setOutParameters(parametersDmg['numberLine'])

    def groupDmg(self):
        self.dataLog = data.data.copy()
        attackerID = self.dataLog['attackerID']
        attackReasonID = self.dataLog['attackReasonID']
        if attackerID in self.dictVehicle:
            if attackReasonID in self.dictVehicle[attackerID]:
                parametersDmg = self.dictVehicle[attackerID][attackReasonID]
                if (BigWorld.serverTime() - parametersDmg['time']) < 1.0:
                    self.updateGroupedValues(parametersDmg)
                    return
                else:
                    del self.dictVehicle[attackerID][attackReasonID]
        else:
            self.dictVehicle[attackerID] = {}
        self.addLine(attackerID, attackReasonID)

    def isGroupDmg(self):
        attackReasonID = data.data['attackReasonID']
        isGroupRamming_WorldCollision = (attackReasonID in [2, 3]) and _config.get(self.S_GROUP_DAMAGE_RAMMING_COLLISION)
        isGroupFire = (attackReasonID == 1) and _config.get(self.S_GROUP_DAMAGE_FIRE)
        isGroupArtAndAirstrike = (attackReasonID in [24, 25]) and _config.get(self.S_GROUP_DAMAGE_ART_AND_AIRSTRIKE)
        return isGroupRamming_WorldCollision or isGroupFire or isGroupArtAndAirstrike

    def output(self):
        if _config.get(self.S_SHOW_HIT_NO_DAMAGE) or data.data['isDamage']:
            self.reset_scrolling()
            if self.isGroupDmg():
                self.groupDmg()
            else:
                self.dataLog = data.data
                self.addLine()
            if self.callEvent:
                as_event(EVENTS_NAMES.ON_HIT)


class LastHit(_Base):

    def __init__(self, section):
        _Base.__init__(self, section)
        self.strLastHit = ''
        self.S_FORMAT_LAST_HIT = section + FORMAT_LAST_HIT
        self.S_TIME_DISPLAY_LAST_HIT = section + TIME_DISPLAY_LAST_HIT
        if _config.get(self.S_MOVE_IN_BATTLE):
            _data = userprefs.get(DAMAGE_LOG_SECTIONS.LAST_HIT, {'x': _config.get(self.S_X), 'y': _config.get(self.S_Y)})
            as_callback("lastHit_mouseDown", self.mouse_down)
            as_callback("lastHit_mouseUp", self.mouse_up)
            as_callback("lastHit_mouseMove", self.mouse_move)
        else:
            _data = {'x': _config.get(self.S_X), 'y': _config.get(self.S_Y)}
        self.x = _data['x']
        self.y = _data['y']
        self.timerLastHit = None

    def reset(self):
        super(LastHit, self).reset()
        self.strLastHit = ''
        if (self.timerLastHit is not None) and self.timerLastHit.isStarted:
            self.timerLastHit.stop()
        if (None not in [self.x, self.y]) and _config.get(self.S_MOVE_IN_BATTLE):
            userprefs.set(DAMAGE_LOG_SECTIONS.LAST_HIT, {'x': self.x, 'y': self.y})

    def mouse_move(self, _data):
        self._mouse_move(_data, EVENTS_NAMES.ON_LAST_HIT)

    def hideLastHit(self):
        self.strLastHit = ''
        if (self.timerLastHit is not None) and self.timerLastHit.isStarted:
            self.timerLastHit.stop()
        as_event(EVENTS_NAMES.ON_LAST_HIT)

    def setOutParameters(self, dataLog):
        self.updateValueMacros(dataLog)
        self.strLastHit = parser(_config.get(self.S_FORMAT_LAST_HIT))
        if not _config.get(self.S_MOVE_IN_BATTLE):
            self.x = parser(_config.get(self.S_X))
            self.y = parser(_config.get(self.S_Y))
        self.shadow = self.getShadow()

    def initGroupedValues(self, dmg, hitTime, attackReasonID):
        return {'time': BigWorld.serverTime(),
                'damage': dmg,
                'startAction': BigWorld.time() if attackReasonID == 1 else None,
                'hitTime': hitTime}

    def groupDmg(self):
        dataLog = data.data.copy()
        attackerID = dataLog['attackerID']
        attackReasonID = dataLog['attackReasonID']
        if attackerID in self.dictVehicle:
            if attackReasonID in self.dictVehicle[attackerID]:
                key = self.dictVehicle[attackerID][attackReasonID]
                if ('time' in key) and ('damage' in key) and ((BigWorld.serverTime() - key['time']) < 1):
                    key['time'] = BigWorld.serverTime()
                    key['damage'] += dataLog['damage']
                    dataLog['damage'] = key['damage']
                    dataLog['dmgRatio'] = key['damage'] * 100 // dataLog['maxHealth']
                    dataLog['fireDuration'] = BigWorld.time() - key['startAction'] if (attackReasonID == 1) and (key['startAction'] is not None) else None
                    dataLog['hitTime'] = key['hitTime']
            else:
                self.dictVehicle[attackerID][attackReasonID] = self.initGroupedValues(dataLog['damage'], dataLog['hitTime'], attackReasonID)
                dataLog['fireDuration'] = 0 if attackReasonID == 1 else None
        else:
            self.dictVehicle[attackerID] = {}
            self.dictVehicle[attackerID][attackReasonID] = self.initGroupedValues(dataLog['damage'], dataLog['hitTime'], attackReasonID)
            dataLog['fireDuration'] = 0 if attackReasonID == 1 else None
        return dataLog

    def isGroupDmg(self):
        attackReasonID = data.data['attackReasonID']
        isGroupRamming_WorldCollision = (attackReasonID in [2, 3]) and _config.get(self.S_GROUP_DAMAGE_RAMMING_COLLISION)
        isGroupFire = (attackReasonID == 1) and _config.get(self.S_GROUP_DAMAGE_FIRE)
        isGroupArtAndAirstrike = (attackReasonID in [24, 25]) and _config.get(self.S_GROUP_DAMAGE_ART_AND_AIRSTRIKE)
        return isGroupRamming_WorldCollision or isGroupFire or isGroupArtAndAirstrike

    def output(self):
        if _config.get(self.S_SHOW_HIT_NO_DAMAGE) or data.data['isDamage']:
            if self.isGroupDmg():
                self.setOutParameters(self.groupDmg())
            else:
                self.setOutParameters(data.data)
            if self.strLastHit:
                if (self.timerLastHit is not None) and self.timerLastHit.isStarted:
                    self.timerLastHit.stop()
                timeDisplayLastHit = float(parser(_config.get(self.S_TIME_DISPLAY_LAST_HIT)))
                self.timerLastHit = TimeInterval(timeDisplayLastHit, self, 'hideLastHit')
                self.timerLastHit.start()
                as_event(EVENTS_NAMES.ON_LAST_HIT)
        return


_log = DamageLog(DAMAGE_LOG_SECTIONS.LOG)
_logAlt = DamageLog(DAMAGE_LOG_SECTIONS.LOG_ALT)
_logBackground = DamageLog(DAMAGE_LOG_SECTIONS.LOG_BACKGROUND)
_logAltBackground = DamageLog(DAMAGE_LOG_SECTIONS.LOG_ALT_BACKGROUND)
_lastHit = LastHit(DAMAGE_LOG_SECTIONS.LAST_HIT)
_lastHitBackground = LastHit(DAMAGE_LOG_SECTIONS.LAST_HIT_BACKGROUND)


@registerEvent(PlayerAvatar, 'onBecomePlayer')
def _PlayerAvatar_onBecomePlayer(self):
    global isShowDamageLog
    isShowDamageLog = _config.get(DAMAGE_LOG_ENABLED) and battle.isBattleTypeSupported


@overrideMethod(DamageLogPanel, '_addToTopLog')
def DamageLogPanel_addToTopLog(base, self, value, actionTypeImg, vehicleTypeImg, vehicleName, shellTypeStr, shellTypeBG):
    if not (_config.get(DAMAGE_LOG_DISABLED_DETAIL_STATS) and isShowDamageLog):
        return base(self, value, actionTypeImg, vehicleTypeImg, vehicleName, shellTypeStr, shellTypeBG)


@overrideMethod(DamageLogPanel, '_addToBottomLog')
def DamageLogPanel_addToBottomLog(base, self, value, actionTypeImg, vehicleTypeImg, vehicleName, shellTypeStr, shellTypeBG):
    if not (_config.get(DAMAGE_LOG_DISABLED_DETAIL_STATS) and isShowDamageLog):
        return base(self, value, actionTypeImg, vehicleTypeImg, vehicleName, shellTypeStr, shellTypeBG)


@overrideMethod(DamageLogPanel, 'as_summaryStatsS')
def DamageLogPanel_as_summaryStatsS(base, self, damage, blocked, assist, stun):
    if not (_config.get(DAMAGE_LOG_DISABLED_SUMMARY_STATS) and isShowDamageLog):
        return base(self, damage, blocked, assist, stun)


@overrideMethod(DamageLogPanel, 'as_updateSummaryDamageValueS')
def as_updateSummaryDamageValueS(base, self, value):
    if not (_config.get(DAMAGE_LOG_DISABLED_SUMMARY_STATS) and isShowDamageLog):
        return base(self, value)


@overrideMethod(DamageLogPanel, 'as_updateSummaryBlockedValueS')
def as_updateSummaryBlockedValueS(base, self, value):
    if not (_config.get(DAMAGE_LOG_DISABLED_SUMMARY_STATS) and isShowDamageLog):
        return base(self, value)


@overrideMethod(DamageLogPanel, 'as_updateSummaryAssistValueS')
def as_updateSummaryAssistValueS(base, self, value):
    if not (_config.get(DAMAGE_LOG_DISABLED_SUMMARY_STATS) and isShowDamageLog):
        return base(self, value)


@overrideMethod(DamageLogPanel, 'as_updateSummaryStunValueS')
def as_updateSummaryStunValueS(base, self, value):
    if not (_config.get(DAMAGE_LOG_DISABLED_SUMMARY_STATS) and isShowDamageLog):
        return base(self, value)


@registerEvent(Vehicle, 'onHealthChanged')
def Vehicle_onHealthChanged(self, newHealth, attackerID, attackReasonID):
    global on_fire, isImpact
    if not isImpact and self.isPlayerVehicle:
        isImpact = True
        as_event(EVENTS_NAMES.ON_IMPACT)
    if isShowDamageLog:
        if self.isPlayerVehicle and data.data['isAlive']:
            data.onHealthChanged(self, newHealth, attackerID, attackReasonID)
            if newHealth <= 0:
                on_fire = 0
                as_event(EVENTS_NAMES.ON_FIRE)
        else:
            v = vId = getattr(BigWorld.player().inputHandler.ctrl, 'curVehicleID', None)
            if isinstance(vId, int):
                v = BigWorld.entity(vId)
            if isinstance(v, Vehicle) and (self.id == v.id) and not v.isAlive():
                on_fire = 0
                as_event(EVENTS_NAMES.ON_FIRE)
            elif not isinstance(v, Vehicle) and v is not None:
                log('[DamageLog] Type(BigWorld.player().inputHandler.ctrl.curVehicleID) = %s' % v)


@registerEvent(PlayerAvatar, 'showVehicleDamageInfo')
def PlayerAvatar_showVehicleDamageInfo(self, vehicleID, damageIndex, extraIndex, entityID, equipmentID):
    global isImpact
    if self.playerVehicleID == vehicleID:
        if not isImpact:
            damageCode = DAMAGE_INFO_CODES[damageIndex]
            isImpact = damageCode not in ['DEVICE_REPAIRED_TO_CRITICAL', 'DEVICE_REPAIRED', 'TANKMAN_RESTORED', 'FIRE_STOPPED']
            if isImpact:
                as_event(EVENTS_NAMES.ON_IMPACT)
        if isShowDamageLog:
            data.showVehicleDamageInfo(self, vehicleID, damageIndex, extraIndex, entityID, equipmentID)


@registerEvent(PlayerAvatar, 'updateVehicleHealth')
def updateVehicleHealth(self, vehicleID, health, deathReasonID, isCrewActive, isRespawn):
    if (vehicleID == self.playerVehicleID) and isShowDamageLog:
        data.data['isDamage'] = (max(0, health) != data.data['oldHealth'])


@registerEvent(Vehicle, 'onEnterWorld')
def Vehicle_onEnterWorld(self, prereqs):
    if self.isPlayerVehicle:
        global isShowDamageLog
        isShowDamageLog = _config.get(DAMAGE_LOG_ENABLED) and battle.isBattleTypeSupported
        if isShowDamageLog:
            global on_fire, damageLogConfig, chooseRating
            scale = config.networkServicesSettings.scale
            name = config.networkServicesSettings.rating
            r = '{}_{}'.format(scale, name)
            if r in RATINGS:
                chooseRating = RATINGS[r]['name']
            else:
                chooseRating = 'xwgr' if scale == 'xvm' else 'wgr'
            if not (config.config_autoreload or damageLogConfig):
                damageLogConfig = {section: readyConfig(section) for section in DAMAGE_LOG_SECTIONS.SECTIONS}
            on_fire = 0
            data.data['oldHealth'] = self.health
            data.data['maxHealth'] = self.health
            data.data['isAlive'] = self.isAlive()


@registerEvent(Vehicle, 'showDamageFromShot')
def Vehicle_showDamageFromShot(self, attackerID, points, effectsIndex, damageFactor):
    global isImpact
    if not isImpact and self.isPlayerVehicle:
        isImpact = True
        as_event(EVENTS_NAMES.ON_IMPACT)
    if self.isPlayerVehicle and data.data['isAlive'] and isShowDamageLog:
        data.showDamageFromShot(self, attackerID, points, effectsIndex, damageFactor)


@registerEvent(Vehicle, 'showDamageFromExplosion')
def Vehicle_showDamageFromExplosion(self, attackerID, center, effectsIndex, damageFactor):
    global isImpact
    if not isImpact and self.isPlayerVehicle:
        isImpact = True
        as_event(EVENTS_NAMES.ON_IMPACT)
    if self.isPlayerVehicle and data.data['isAlive'] and isShowDamageLog:
        data.showDamageFromExplosion(self, attackerID, center, effectsIndex, damageFactor)


@registerEvent(Vehicle, 'updateStunInfo')
def Vehicle_updateStunInfo(self):
    if self.isPlayerVehicle and isShowDamageLog:
        stunDuration = self.stunInfo - BigWorld.serverTime() if self.stunInfo else None
        if stunDuration is not None:
            data.updateStunInfo(self, stunDuration)


@registerEvent(DamagePanelMeta, 'as_setFireInVehicleS')
def DamagePanelMeta_as_setFireInVehicleS(self, isInFire):
    global on_fire
    if isShowDamageLog and data.data['isAlive']:
        on_fire = 100 if isInFire else 0
        as_event(EVENTS_NAMES.ON_FIRE)


@registerEvent(PlayerAvatar, '_PlayerAvatar__destroyGUI')
def PlayerAvatar__destroyGUI(self):
    global on_fire, isImpact
    isImpact = False
    on_fire = 0
    data.reset()
    _log.reset(_log.section)
    _logAlt.reset(_logAlt.section)
    _logBackground.reset(_logBackground.section)
    _logAltBackground.reset(_logAltBackground.section)
    _lastHit.reset()
    _lastHitBackground.reset()


@registerEvent(PlayerAvatar, 'handleKey')
def PlayerAvatar_handleKey(self, isDown, key, mods):
    global isDownAlt
    if isShowDamageLog:
        hotkey = _config.get('hotkeys/damageLogAltMode')
        if hotkey[ENABLED] and (key == hotkey['keyCode']):
            if isDown:
                if hotkey['onHold']:
                    if not isDownAlt:
                        isDownAlt = True
                        as_event(EVENTS_NAMES.ON_HIT)
                else:
                    isDownAlt = not isDownAlt
                    as_event(EVENTS_NAMES.ON_HIT)
            else:
                if hotkey['onHold']:
                    if isDownAlt:
                        isDownAlt = False
                        as_event(EVENTS_NAMES.ON_HIT)


def dLog():
    return '\n'.join(_logAlt.listLog) if isDownAlt else '\n'.join(_log.listLog)


def dLog_bg():
    return '\n'.join(_logAltBackground.listLog) if isDownAlt else '\n'.join(_logBackground.listLog)


def dLog_shadow(setting):
    return _logAlt.shadow.get(setting, None) if isDownAlt else _log.shadow.get(setting, None)


def dLog_x():
    return _log.x


def dLog_y():
    return _log.y


def lastHit():
    return _lastHit.strLastHit


def lastHit_bg():
    return _lastHitBackground.strLastHit


def lastHit_shadow(setting):
    return _lastHit.shadow.get(setting, None)


def lastHit_x():
    return _lastHit.x


def lastHit_y():
    return _lastHit.y


def fire():
    return on_fire
