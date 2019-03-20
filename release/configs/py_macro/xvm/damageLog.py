# Addons: "DamageLog"
# ktulho <https://kr.cm/f/p/17624/>

import copy

import BigWorld
import GUI
import ResMgr
import nations
import BattleReplay
from Avatar import PlayerAvatar
from Vehicle import Vehicle
from VehicleEffects import DamageFromShotDecoder
from vehicle_systems.tankStructure import TankPartIndexes
from constants import ITEM_DEFS_PATH, DAMAGE_INFO_CODES, VEHICLE_CLASSES
from gui.Scaleform.daapi.view.battle.shared.damage_log_panel import DamageLogPanel
from gui.Scaleform.daapi.view.battle.shared.battle_loading import BattleLoading
from gui.Scaleform.daapi.view.meta.DamagePanelMeta import DamagePanelMeta
from gui.shared.utils.TimeInterval import TimeInterval
from items import vehicles, _xml
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider
from skeletons.gui.game_control import IBootcampController

from xfw import *
from xfw_actionscript.python import *

from xvm_main.python.logger import *
from xvm_main.python.stats import _stat
import xvm_main.python.config as config
import xvm_main.python.userprefs as userprefs
import xvm_battle.python.battle as battle

import parser_addon

on_fire = 0
isDownAlt = False
autoReloadConfig = None
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
    15: 'none',
    24: 'art_attack',
    25: 'air_strike'
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
FORMAT_LAST_HIT = 'formatLastHit'
GROUP_DAMAGE_RAMMING_COLLISION = 'groupDamagesFromRamming_WorldCollision'
GROUP_DAMAGE_FIRE = 'groupDamagesFromFire'
SHOW_HIT_NO_DAMAGE = 'showHitNoDamage'
MOVE_IN_BATTLE = 'moveInBattle'
TIME_DISPLAY_LAST_HIT = 'timeDisplayLastHit'
DAMAGE_LOG_ENABLED = 'damageLog/enabled'

SECTION_LOG = 'damageLog/log/'
SECTION_LOG_ALT = 'damageLog/logAlt/'
SECTION_LOG_BACKGROUND = 'damageLog/logBackground/'
SECTION_LOG_ALT_BACKGROUND = 'damageLog/logAltBackground/'
SECTION_LASTHIT = 'damageLog/lastHit/'
SECTIONS = (SECTION_LOG, SECTION_LOG_ALT, SECTION_LOG_BACKGROUND, SECTION_LOG_ALT_BACKGROUND, SECTION_LASTHIT)

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


def keyLower(_dict):
    return {key.lower(): _dict[key] for key in _dict.iterkeys()} if _dict is not None else None


def readyConfig(section):
    if autoReloadConfig or (section not in damageLogConfig):
        return {'vehicleClass': keyLower(config.get(section + 'vtype')),
                'c_Shell': keyLower(config.get(section + 'c:costShell')),
                'costShell': keyLower(config.get(section + 'costShell')),
                'c_typeHit': keyLower(config.get(section + 'c:dmg-kind')),
                'c_VehicleClass': keyLower(config.get(section + 'c:vtype')),
                'typeHit': keyLower(config.get(section + 'dmg-kind')),
                'c_teamDmg': keyLower(config.get(section + 'c:team-dmg')),
                'teamDmg': keyLower(config.get(section + 'team-dmg')),
                'compNames': keyLower(config.get(section + 'comp-name')),
                'splashHit': keyLower(config.get(section + 'splash-hit')),
                'criticalHit': keyLower(config.get(section + 'critical-hit')),
                'hitEffect': keyLower(config.get(section + 'hit-effects')),
                'c_hitEffect': keyLower(config.get(section + 'c:hit-effects')),
                'typeShell': keyLower(config.get(section + 'type-shell')),
                'c_typeShell': keyLower(config.get(section + 'c:type-shell')),
                'critDevice': keyLower(config.get(section + 'crit-device'))
                }
    else:
        return damageLogConfig[section]

def parser(strHTML):
    s = parser_addon.parser_addon(strHTML, macros)
    return s


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
                     'clanicon': '',
                     'squadnum': 0,
                     'number': None,
                     'reloadGun': 0.0,
                     'caliber': None,
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
        if attackerID:
            self.data['teamDmg'] = 'unknown'
            attacker = player.arena.vehicles.get(attackerID)
            if attacker is not None:
                if attacker['team'] != player.team:
                    self.data['teamDmg'] = 'enemy-dmg'
                elif attacker['name'] == player.name:
                    self.data['teamDmg'] = 'player'
                else:
                    self.data['teamDmg'] = 'ally-dmg'
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
                    elif self.data['diff-masses'] is not None:
                        self.data['diff-masses'] = None
                else:
                    self.data['attackerVehicleType'] = 'not_vehicle'
                    self.data['attackerVehicleName'] = ''
                    self.data['shortUserString'] = None
                    self.data['level'] = None
                    self.data['nation'] = None
                    self.data['diff-masses'] = None
                self.data['name'] = attacker['name']
                if (_stat.resp is not None) and (attacker['name'] in _stat.resp['players']):
                    stats = _stat.resp['players'][attacker['name']]
                    self.data['wn8'] = stats.get('wn8', None)
                    self.data['xwn8'] = stats.get('xwn8', None)
                    self.data['wtr'] = stats.get('wtr', None)
                    self.data['xwtr'] = stats.get('xwtr', None)
                    self.data['eff'] = stats.get('eff', None)
                    self.data['xeff'] = stats.get('xeff', None)
                    self.data['wgr'] = stats.get('wgr', None)
                    self.data['xwgr'] = stats.get('xwgr', None)
                    self.data['xte'] = stats.get('v').get('xte', None)
                else:
                    self.data['wn8'] = None
                    self.data['xwn8'] = None
                    self.data['wtr'] = None
                    self.data['xwtr'] = None
                    self.data['eff'] = None
                    self.data['xeff'] = None
                    self.data['wgr'] = None
                    self.data['xwgr'] = None
                    self.data['xte'] = None
                self.data['clanAbbrev'] = attacker['clanAbbrev']
            self.data['clanicon'] = _stat.getClanIcon(attackerID)
            self.data['squadnum'] = None
            arenaDP = self.sessionProvider.getArenaDP()
            if arenaDP is not None:
                vInfo = arenaDP.getVehicleInfo(vID=attackerID)
                self.data['squadnum'] = vInfo.squadIndex if vInfo.squadIndex != 0 else None
        else:
            self.data['teamDmg'] = 'unknown'
            self.data['attackerVehicleType'] = 'not_vehicle'
            self.data['attackerVehicleName'] = ''
            self.data['shortUserString'] = ''
            self.data['name'] = ''
            self.data['clanAbbrev'] = ''
            self.data['level'] = None
            self.data['clanicon'] = None
            self.data['squadnum'] = None
        self.updateLabels()


    def typeShell(self, effectsIndex):
        self.data['costShell'] = 'unknown'
        self.data['shellKind'] = 'not_shell'
        if (self.data['attackerID'] == 0) or (self.data['attackReasonID'] != 0):
            return
        player = BigWorld.player()
        attacker = player.arena.vehicles.get(self.data['attackerID'])
        if (attacker is None) or not attacker['vehicleType']:
            self.data['shellKind'] = 'not_shell'
            self.data['caliber'] = None
            self.data['costShell'] = 'unknown'
            return
        for shot in attacker['vehicleType'].gun.shots:
            _shell = shot.shell
            if effectsIndex == _shell.effectsIndex:
                self.data['shellKind'] = str(_shell.kind).lower()
                self.data['caliber'] = _shell.caliber
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
        self.data['attackReasonID'] = effectsIndex if effectsIndex in [24, 25] else 0
        self.data['reloadGun'] = self.timeReload(attackerID)
        self.typeShell(effectsIndex)
        self.data['damage'] = 0
        if self.data['isDamage']:
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
        _logBackground.output()
        _logAltBackground.output()
        self.data['critDevice'] = 'no-critical'
        self.data['criticalHit'] = False
        self.data['isDamage'] = False
        self.data['hitEffect'] = 'unknown'
        self.data['splashHit'] = 'no-splash'

    def showDamageFromShot(self, vehicle, attackerID, points, effectsIndex, damageFactor):
        if not vehicle.isStarted:
            return
        maxComponentIdx = TankPartIndexes.ALL[-1]
        wheelsConfig = vehicle.appearance.typeDescriptor.chassis.generalWheelsAnimatorConfig
        if wheelsConfig:
            maxComponentIdx += wheelsConfig.getWheelsCount()
        maxHitEffectCode, decodedPoints, maxDamagedComponent = DamageFromShotDecoder.decodeHitPoints(points, vehicle.appearance.collisions, maxComponentIdx)
        compName = decodedPoints[0].componentName
        if decodedPoints:
            self.data['compName'] = compName if compName[0] != 'W' else 'wheel'
        else:
            self.data['compName'] = 'unknown'

        # self.data['criticalHit'] = (maxHitEffectCode == 5)
        if not self.data['isDamage']:
            self.data['hitEffect'] = HIT_EFFECT_CODES[min(3, maxHitEffectCode)]
            self.data['isAlive'] = bool(vehicle.isCrewActive)
        self.hitShell(attackerID, effectsIndex, damageFactor)

    def showDamageFromExplosion(self, vehicle, attackerID, center, effectsIndex, damageFactor):
        self.data['splashHit'] = 'splash'
        # self.data['criticalHit'] = False
        if not self.data['isDamage']:
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
        if attackReasonID < 8:
            self.data['attackReasonID'] = attackReasonID
        elif attackReasonID in [9, 10, 13, 24]:
            self.data['attackReasonID'] = 24
        elif attackReasonID in [11, 14, 25]:
            self.data['attackReasonID'] = 25

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


def updateValueMacros(section, value):
    global macros

    def readColor(sec, m, xm=None):
        colors = config.get('colors/' + sec)
        if m is not None and colors is not None:
            for val in colors:
                if val['value'] > m:
                    return '#' + val['color'][2:] if val['color'][:2] == '0x' else val['color']
        elif xm is not None:
            colors_x = config.get('colors/x')
            for val in colors_x:
                if val['value'] > xm:
                    return '#' + val['color'][2:] if val['color'][:2] == '0x' else val['color']

    conf = readyConfig(section)
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
                  'clanicon': value['clanicon'],
                  'squad-num': value['squadnum'],
                  'reloadGun': value['reloadGun'],
                  'my-alive': 'al' if value['isAlive'] else None,
                  'gun-caliber': value['caliber'],
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
                  'vehiclename': value.get('attackerVehicleName', None)
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


def shadow_value(section):
    return {'distance': parser(config.get(section + 'shadow/distance')),
            'angle': parser(config.get(section + 'shadow/angle')),
            'alpha': parser(config.get(section + 'shadow/alpha')),
            'blur': parser(config.get(section + 'shadow/blur')),
            'strength': parser(config.get(section + 'shadow/strength')),
            'color': parser(config.get(section + 'shadow/color')),
            'hideObject': parser(config.get(section + 'shadow/hideObject')),
            'inner': parser(config.get(section + 'shadow/inner')),
            'knockout': parser(config.get(section + 'shadow/knockout')),
            'quality': parser(config.get(section + 'shadow/quality'))
            }


class _Base(object):
    def __init__(self, section):
        self.S_MOVE_IN_BATTLE = section + MOVE_IN_BATTLE
        self.S_SHOW_HIT_NO_DAMAGE = section + SHOW_HIT_NO_DAMAGE
        self.S_GROUP_DAMAGE_RAMMING_COLLISION = section + GROUP_DAMAGE_RAMMING_COLLISION
        self.S_GROUP_DAMAGE_FIRE = section + GROUP_DAMAGE_FIRE
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


class DamageLog(_Base):
    def __init__(self, section):
        _Base.__init__(self, section)
        self.S_FORMAT_HISTORY = section + FORMAT_HISTORY
        self.listLog = []
        self.dataLog = {}
        self.scrollList = []
        if config.get(self.S_MOVE_IN_BATTLE):
            _data = userprefs.get('damageLog/log', {'x': config.get(self.S_X), 'y': config.get(self.S_Y)})
            if section == SECTION_LOG:
                as_callback("damageLog_mouseDown", self.mouse_down)
                as_callback("damageLog_mouseUp", self.mouse_up)
                as_callback("damageLog_mouseMove", self.mouse_move)
        else:
            _data = {'x': config.get(self.S_X), 'y': config.get(self.S_Y)}
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
        if (None not in [self.x, self.y]) and config.get(self.S_MOVE_IN_BATTLE) and section == SECTION_LOG:
            userprefs.set('damageLog/log', {'x': self.x, 'y': self.y})

    def mouse_move(self, _data):
        self._mouse_move(_data, 'ON_HIT')

    def mouse_wheel(self, _data):
        if _data['delta'] < 0:
            if self.listLog:
                self.scrollList.append(self.listLog.pop(0))
                as_event('ON_HIT')
        else:
            if self.scrollList:
                self.listLog.insert(0, self.scrollList.pop())
                as_event('ON_HIT')

    def setOutParameters(self, numberLine):
        updateValueMacros(self.section, self.dataLog)
        if numberLine == ADD_LINE:
            self.listLog = [parser(config.get(self.S_FORMAT_HISTORY))] + self.listLog
        else:
            self.listLog[numberLine] = parser(config.get(self.S_FORMAT_HISTORY))
        if (self.section == SECTION_LOG) or (self.section == SECTION_LOG_ALT):
            if not config.get(self.S_MOVE_IN_BATTLE):
                self.x = parser(config.get(self.S_X))
                self.y = parser(config.get(self.S_Y))
            self.shadow = shadow_value(self.section)

    def addLine(self, attackerID=None, attackReasonID=None):
        if not (attackerID is None or attackReasonID is None):
            self.dictVehicle[attackerID][attackReasonID] = {'time': BigWorld.serverTime(),
                                                            'damage':  self.dataLog['damage'],
                                                            'criticalHit':  self.dataLog['criticalHit'],
                                                            'numberLine': 0,
                                                            'startAction': BigWorld.time() if attackReasonID == 1 else None,
                                                            'hitTime': self.dataLog['hitTime']
                                                            }
        self.dataLog['number'] = len(self.listLog) + 1
        self.dataLog['fireDuration'] = BigWorld.time() - self.dictVehicle[attackerID][attackReasonID]['startAction'] if attackReasonID == 1 else None
        self.setOutParameters(ADD_LINE)
        for attacker in self.dictVehicle:
            dictAttacker = self.dictVehicle[attacker]
            for attack in dictAttacker:
                if (attacker != attackerID) or (attack != attackReasonID):
                    dictAttacker[attack]['numberLine'] += 1

    def reset_scrolling(self):
        if self.scrollList:
            self.scrollList.extend(self.listLog)
            self.listLog = self.scrollList
            self.scrollList = []

    def output(self):
        if config.get(self.S_SHOW_HIT_NO_DAMAGE) or data.data['isDamage']:
            self.reset_scrolling()
            isGroupRamming_WorldCollision = (data.data['attackReasonID'] in [2, 3]) and config.get(self.S_GROUP_DAMAGE_RAMMING_COLLISION)
            isGroupFire = (data.data['attackReasonID'] == 1) and config.get(self.S_GROUP_DAMAGE_FIRE)
            if isGroupRamming_WorldCollision or isGroupFire:
                self.dataLog = data.data.copy()
                attackerID = self.dataLog['attackerID']
                attackReasonID = self.dataLog['attackReasonID']
                if attackerID in self.dictVehicle:
                    if (attackReasonID in self.dictVehicle[attackerID]) and ((BigWorld.serverTime() - self.dictVehicle[attackerID][attackReasonID]['time']) < 1.0):
                        key = self.dictVehicle[attackerID][attackReasonID]
                        key['time'] = BigWorld.serverTime()
                        key['damage'] += self.dataLog['damage']
                        key['criticalHit'] = (key['criticalHit'] or self.dataLog['criticalHit'])
                        if key['damage'] > 0:
                            self.dataLog['hitEffect'] = 'armor_pierced'
                        self.dataLog['criticalHit'] = key['criticalHit']
                        self.dataLog['damage'] = key['damage']
                        self.dataLog['dmgRatio'] = self.dataLog['damage'] * 100 // self.dataLog['maxHealth']
                        self.dataLog['number'] = len(self.listLog) - key['numberLine']
                        self.dataLog['fireDuration'] = BigWorld.time() - key['startAction'] if (attackReasonID == 1) and (key['startAction'] is not None) else None
                        self.dataLog['hitTime'] = key['hitTime']
                        self.setOutParameters(key['numberLine'])
                    else:
                        if attackReasonID in self.dictVehicle[attackerID]:
                            del self.dictVehicle[attackerID][attackReasonID]
                        self.addLine(attackerID, attackReasonID)
                else:
                    self.dictVehicle[attackerID] = {}
                    self.addLine(attackerID, attackReasonID)
            else:
                self.dataLog = data.data
                self.addLine()
            if self.callEvent:
                as_event('ON_HIT')


class LastHit(_Base):
    def __init__(self, section):
        _Base.__init__(self, section)
        self.strLastHit = ''
        self.S_FORMAT_LAST_HIT = section + FORMAT_LAST_HIT
        self.S_TIME_DISPLAY_LAST_HIT = section + TIME_DISPLAY_LAST_HIT
        if config.get(self.S_MOVE_IN_BATTLE):
            _data = userprefs.get('damageLog/lastHit', {'x': config.get(self.S_X), 'y': config.get(self.S_Y)})
            as_callback("lastHit_mouseDown", self.mouse_down)
            as_callback("lastHit_mouseUp", self.mouse_up)
            as_callback("lastHit_mouseMove", self.mouse_move)
        else:
            _data = {'x': config.get(self.S_X), 'y': config.get(self.S_Y)}
        self.x = _data['x']
        self.y = _data['y']
        self.timerLastHit = None

    def reset(self):
        super(LastHit, self).reset()
        self.strLastHit = ''
        if (self.timerLastHit is not None) and self.timerLastHit.isStarted:
            self.timerLastHit.stop()
        if (None not in [self.x, self.y]) and config.get(self.S_MOVE_IN_BATTLE):
            userprefs.set('damageLog/lastHit', {'x': self.x, 'y': self.y})

    def mouse_move(self, _data):
        self._mouse_move(_data, 'ON_LAST_HIT')

    def hideLastHit(self):
        self.strLastHit = ''
        if (self.timerLastHit is not None) and self.timerLastHit.isStarted:
            self.timerLastHit.stop()
        as_event('ON_LAST_HIT')

    def setOutParameters(self, dataLog):
        updateValueMacros(self.section, dataLog)
        self.strLastHit = parser(config.get(self.S_FORMAT_LAST_HIT))
        if not config.get(self.S_MOVE_IN_BATTLE):
            self.x = parser(config.get(self.S_X))
            self.y = parser(config.get(self.S_Y))
        self.shadow = shadow_value(self.section)

    def groupDamages(self):
        isGroupRamming_WorldCollision = (data.data['attackReasonID'] in [2, 3]) and config.get(self.S_GROUP_DAMAGE_RAMMING_COLLISION)
        isGroupFire = (data.data['attackReasonID'] == 1) and config.get(self.S_GROUP_DAMAGE_FIRE)
        if isGroupRamming_WorldCollision or isGroupFire:
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
                        dataLog['dmgRatio'] = dataLog['damage'] * 100 // dataLog['maxHealth']
                        dataLog['fireDuration'] = BigWorld.time() - key['startAction'] if (attackReasonID == 1) and (key['startAction'] is not None) else None
                        dataLog['hitTime'] = key['hitTime']
                else:
                    self.dictVehicle[attackerID][attackReasonID] = {'time': BigWorld.serverTime(),
                                                                    'damage': dataLog['damage'],
                                                                    'startAction': BigWorld.time() if attackReasonID == 1 else None,
                                                                    'hitTime': dataLog['hitTime']}
                    dataLog['fireDuration'] = 0 if attackReasonID == 1 else None
            else:
                self.dictVehicle[attackerID] = {}
                self.dictVehicle[attackerID][attackReasonID] = {'time': BigWorld.serverTime(),
                                                                'damage': dataLog['damage'],
                                                                'startAction': BigWorld.time() if attackReasonID == 1 else None,
                                                                'hitTime': dataLog['hitTime']}
                dataLog['fireDuration'] = 0 if attackReasonID == 1 else None
            self.setOutParameters(dataLog)
        else:
            self.setOutParameters(data.data)

    def output(self):
        if config.get(self.S_SHOW_HIT_NO_DAMAGE) or data.data['isDamage']:
            self.groupDamages()
            if self.strLastHit:
                if (self.timerLastHit is not None) and self.timerLastHit.isStarted:
                    self.timerLastHit.stop()
                timeDisplayLastHit = float(parser(config.get(self.S_TIME_DISPLAY_LAST_HIT)))
                self.timerLastHit = TimeInterval(timeDisplayLastHit, self, 'hideLastHit')
                self.timerLastHit.start()
                as_event('ON_LAST_HIT')


_log = DamageLog(SECTION_LOG)
_logAlt = DamageLog(SECTION_LOG_ALT)
_logBackground = DamageLog(SECTION_LOG_BACKGROUND)
_logAltBackground = DamageLog(SECTION_LOG_ALT_BACKGROUND)
_lastHit = LastHit(SECTION_LASTHIT)


@registerEvent(PlayerAvatar, 'onBecomePlayer')
def _PlayerAvatar_onBecomePlayer(self):
    global isShowDamageLog
    isShowDamageLog = config.get(DAMAGE_LOG_ENABLED) and battle.isBattleTypeSupported

@overrideMethod(DamageLogPanel, '_addToTopLog')
def DamageLogPanel_addToTopLog(base, self, value, actionTypeImg, vehicleTypeImg, vehicleName, shellTypeStr, shellTypeBG):
    if not (config.get('damageLog/disabledDetailStats') and isShowDamageLog):
        return base(self, value, actionTypeImg, vehicleTypeImg, vehicleName, shellTypeStr, shellTypeBG)


@overrideMethod(DamageLogPanel, '_addToBottomLog')
def DamageLogPanel_addToBottomLog(base, self, value, actionTypeImg, vehicleTypeImg, vehicleName, shellTypeStr, shellTypeBG):
    if not (config.get('damageLog/disabledDetailStats') and isShowDamageLog):
        return base(self, value, actionTypeImg, vehicleTypeImg, vehicleName, shellTypeStr, shellTypeBG)


@overrideMethod(DamageLogPanel, 'as_summaryStatsS')
def DamageLogPanel_as_summaryStatsS(base, self, damage, blocked, assist, stun):
    if not (config.get('damageLog/disabledSummaryStats') and isShowDamageLog):
        return base(self, damage, blocked, assist, stun)


@overrideMethod(DamageLogPanel, 'as_updateSummaryDamageValueS')
def as_updateSummaryDamageValueS(base, self, value):
    if not (config.get('damageLog/disabledSummaryStats') and isShowDamageLog):
        return base(self, value)


@overrideMethod(DamageLogPanel, 'as_updateSummaryBlockedValueS')
def as_updateSummaryBlockedValueS(base, self, value):
    if not (config.get('damageLog/disabledSummaryStats') and isShowDamageLog):
        return base(self, value)


@overrideMethod(DamageLogPanel, 'as_updateSummaryAssistValueS')
def as_updateSummaryAssistValueS(base, self, value):
    if not (config.get('damageLog/disabledSummaryStats') and isShowDamageLog):
        return base(self, value)


@overrideMethod(DamageLogPanel, 'as_updateSummaryStunValueS')
def as_updateSummaryStunValueS(base, self, value):
    if not (config.get('damageLog/disabledSummaryStats') and isShowDamageLog):
        return base(self, value)


@registerEvent(Vehicle, 'onHealthChanged')
def Vehicle_onHealthChanged(self, newHealth, attackerID, attackReasonID):
    global on_fire, isImpact
    if not isImpact and self.isPlayerVehicle:
        isImpact = True
        as_event('ON_IMPACT')
    if isShowDamageLog:
        if self.isPlayerVehicle and data.data['isAlive']:
            data.onHealthChanged(self, newHealth, attackerID, attackReasonID)
            if newHealth <= 0:
                on_fire = 0
                as_event('ON_FIRE')
        elif hasattr(BigWorld.player().inputHandler.ctrl, 'curVehicleID'):
            vId = BigWorld.player().inputHandler.ctrl.curVehicleID
            v = vId if isinstance(vId, Vehicle) else BigWorld.entity(vId)
            if (v is not None) and ((self.id == v.id) and not v.isAlive()):
                on_fire = 0
                as_event('ON_FIRE')


@registerEvent(PlayerAvatar, 'showVehicleDamageInfo')
def PlayerAvatar_showVehicleDamageInfo(self, vehicleID, damageIndex, extraIndex, entityID, equipmentID):
    global isImpact
    if self.playerVehicleID == vehicleID:
        if not isImpact:
            damageCode = DAMAGE_INFO_CODES[damageIndex]
            isImpact = damageCode not in ['DEVICE_REPAIRED_TO_CRITICAL', 'DEVICE_REPAIRED', 'TANKMAN_RESTORED', 'FIRE_STOPPED']
            if isImpact:
                as_event('ON_IMPACT')
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
        isShowDamageLog = config.get(DAMAGE_LOG_ENABLED) and battle.isBattleTypeSupported
        if isShowDamageLog:
            global on_fire, damageLogConfig, autoReloadConfig, chooseRating
            scale = config.networkServicesSettings.scale
            name = config.networkServicesSettings.rating
            r = '{}_{}'.format(scale, name)
            if r in RATINGS:
                chooseRating = RATINGS[r]['name']
            else:
                chooseRating = 'xwgr' if scale == 'xvm' else 'wgr'
            autoReloadConfig = config.get('autoReloadConfig')
            if not (autoReloadConfig or damageLogConfig):
                damageLogConfig = {section: readyConfig(section) for section in SECTIONS}
            on_fire = 0
            data.data['oldHealth'] = self.health
            data.data['maxHealth'] = self.health
            data.data['isAlive'] = self.isAlive()


@registerEvent(Vehicle, 'showDamageFromShot')
def Vehicle_showDamageFromShot(self, attackerID, points, effectsIndex, damageFactor):
    global isImpact
    if not isImpact and self.isPlayerVehicle:
        isImpact = True
        as_event('ON_IMPACT')
    if self.isPlayerVehicle and data.data['isAlive'] and isShowDamageLog:
        data.showDamageFromShot(self, attackerID, points, effectsIndex, damageFactor)


@registerEvent(Vehicle, 'showDamageFromExplosion')
def Vehicle_showDamageFromExplosion(self, attackerID, center, effectsIndex, damageFactor):
    global isImpact
    if not isImpact and self.isPlayerVehicle:
        isImpact = True
        as_event('ON_IMPACT')
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
    if isShowDamageLog:
        on_fire = 100 if isInFire else 0
        as_event('ON_FIRE')


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


@registerEvent(PlayerAvatar, 'handleKey')
def PlayerAvatar_handleKey(self, isDown, key, mods):
    global isDownAlt
    if isShowDamageLog:
        hotkey = config.get('hotkeys/damageLogAltMode')
        if hotkey['enabled'] and (key == hotkey['keyCode']):
            if isDown:
                if hotkey['onHold']:
                    if not isDownAlt:
                        isDownAlt = True
                        as_event('ON_HIT')
                else:
                    isDownAlt = not isDownAlt
                    as_event('ON_HIT')
            else:
                if hotkey['onHold']:
                    if isDownAlt:
                        isDownAlt = False
                        as_event('ON_HIT')


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


def lastHit_shadow(setting):
    return _lastHit.shadow.get(setting, None)


def lastHit_x():
    return _lastHit.x


def lastHit_y():
    return _lastHit.y


def fire():
    return on_fire
