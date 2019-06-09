# Addons: "HitLog"
# ktulho <https://kr.cm/f/p/17624/>

import BigWorld
import nations
import ResMgr
from Vehicle import Vehicle
from DestructibleEntity import DestructibleEntity
from Avatar import PlayerAvatar
from constants import ITEM_DEFS_PATH, ARENA_GUI_TYPE, VEHICLE_CLASSES
from helpers import dependency
from items import _xml
from VehicleEffects import DamageFromShotDecoder
from skeletons.gui.battle_session import IBattleSessionProvider
from vehicle_systems.tankStructure import TankPartIndexes
from gui.battle_control import avatar_getter
from constants import ATTACK_REASON

from xfw import *
from xfw_actionscript.python import *
from xvm_main.python.logger import *
from xvm_main.python.stats import _stat
from xvm_main.python.xvm import l10n
import xvm_main.python.config as config
import xvm_main.python.userprefs as userprefs
import xvm_battle.python.battle as battle

from xvm.damageLog import HIT_EFFECT_CODES, keyLower, chooseRating, ATTACK_REASONS, RATINGS, VEHICLE_CLASSES_SHORT, ConfigCache
import parser_addon

macros = None
hitLogConfig = {}
isDownAlt = False

BATTLE_TYPE = {ARENA_GUI_TYPE.UNKNOWN: "unknown",
               ARENA_GUI_TYPE.RANDOM: "regular",
               ARENA_GUI_TYPE.TRAINING: "training",
               ARENA_GUI_TYPE.TUTORIAL: "tutorial",
               ARENA_GUI_TYPE.CYBERSPORT: "cybersport",
               ARENA_GUI_TYPE.EVENT_BATTLES: "event_battles",
               ARENA_GUI_TYPE.RATED_SANDBOX: "rated_sandbox",
               ARENA_GUI_TYPE.SANDBOX: "sandbox",
               ARENA_GUI_TYPE.FALLOUT_CLASSIC: "fallout_classic",
               ARENA_GUI_TYPE.FALLOUT_MULTITEAM: "fallout_multiteam",
               ARENA_GUI_TYPE.SORTIE_2: "sortie_2",
               ARENA_GUI_TYPE.FORT_BATTLE_2: "fort_battle_2",
               ARENA_GUI_TYPE.RANKED: "ranked",
               ARENA_GUI_TYPE.BOOTCAMP: "bootcamp",
               ARENA_GUI_TYPE.EPIC_RANDOM: "epic_random",
               ARENA_GUI_TYPE.EPIC_RANDOM_TRAINING: "epic_random_training",
               ARENA_GUI_TYPE.EPIC_BATTLE:  "epic_battle",
               ARENA_GUI_TYPE.EPIC_TRAINING:  "epic_battle"}

HIT_LOG = 'hitLog/'
FORMAT_HISTORY = 'formatHistory'
GROUP_HITS_PLAYER = 'groupHitsByPlayer'
ADD_TO_END = 'addToEnd'
LINES = 'lines'
MOVE_IN_BATTLE = 'moveInBattle'
HIT_LOG_ENABLED = HIT_LOG + 'enabled'
SHOW_SELF_DAMAGE = HIT_LOG + 'showSelfDamage'
SHOW_ALLY_DAMAGE = HIT_LOG + 'showAllyDamage'
ON_HIT_LOG = 'ON_HIT_LOG'

PILLBOX = 'pillbox'

APPEND = 0
CHANGE = 1
INSERT = 2

class HIT_LOG_SECTIONS(object):
    LOG = HIT_LOG + 'log/'
    ALT_LOG = HIT_LOG + 'logAlt/'
    BACKGROUND = HIT_LOG + 'logBackground/'
    ALT_BACKGROUND = HIT_LOG + 'logAltBackground/'
    SECTIONS = (LOG, ALT_LOG, BACKGROUND, ALT_BACKGROUND)


_config = ConfigCache()


def readyConfig(section):
    if config.config_autoreload or (section not in hitLogConfig):
        return {'vehicleClass': keyLower(_config.get(section + 'vtype')),
                'c_Shell': keyLower(_config.get(section + 'c:costShell')),
                'costShell': keyLower(_config.get(section + 'costShell')),
                'c_dmg-kind': keyLower(_config.get(section + 'c:dmg-kind')),
                'c_VehicleClass': keyLower(_config.get(section + 'c:vtype')),
                'dmg-kind': keyLower(_config.get(section + 'dmg-kind')),
                'dmg-kind-player': keyLower(_config.get(section + 'dmg-kind-player')),
                'c_teamDmg': keyLower(_config.get(section + 'c:team-dmg')),
                'teamDmg': keyLower(_config.get(section + 'team-dmg')),
                'compNames': keyLower(_config.get(section + 'comp-name')),
                'typeShell': keyLower(_config.get(section + 'type-shell')),
                'c_typeShell': keyLower(_config.get(section + 'c:type-shell')),
                }
    else:
        return hitLogConfig[section]


def parser(strHTML, _macros=None):
    if strHTML:
        if _macros is not None:
            return parser_addon.parser_addon(strHTML, _macros)
        if macros is not None:
            return parser_addon.parser_addon(strHTML, macros)
    return strHTML


def removePlayerFromLogs(vehicleID):
    def del_key(_dict, key):
        if key in _dict:
            _dict[key].clear()
            del _dict[key]

    del_key(_log.groupHitByPlayer.players, vehicleID)
    del_key(_logAlt.groupHitByPlayer.players, vehicleID)
    del_key(_logBackground.groupHitByPlayer.players, vehicleID)
    del_key(_logAltBackground.groupHitByPlayer.players, vehicleID)
    del_key(_log.groupHitByFireRamming.players, vehicleID)
    del_key(_logAlt.groupHitByFireRamming.players, vehicleID)
    del_key(_logBackground.groupHitByFireRamming.players, vehicleID)
    del_key(_logAltBackground.groupHitByFireRamming.players, vehicleID)


class DataHitLog(object):

    guiSessionProvider = dependency.descriptor(IBattleSessionProvider)

    def __init__(self):
        self.player = None
        self.shells = {}
        self.reset()
        self.ammo = None

    def reset(self):
        self.shellType = None
        self.playerVehicleID = None
        self.vehHealth = {}
        self.vehDead = []
        for i in self.shells:
            if isinstance(i, dict):
                i.clear()
        self.shells = {}
        self.totalDamage = 0
        self.old_totalDamage = 0
        self.isVehicle = True
        self.entityNumber = None
        self.vehicleID = None
        self.intCD = None
        self.data = {'damage': 0,
                     'dmgRatio': 0,
                     'attackReasonID': 0,
                     'blownup': False,
                     # 'hitEffect': None,
                     'costShell': 'unknown',
                     'shellKind': None,
                     'splashHit': False,
                     'criticalHit': False,
                     'isAlive': True,
                     'compName': None,
                     'attackedVehicleType': 'not_vehicle',
                     'shortUserString': None,
                     'level': None,
                     'nation': None,
                     'diff-masses': 0,
                     'name': None,
                     'clanAbbrev': None,
                     'clanicon': None,
                     'squadnum': None,
                     'teamDmg': 'unknown',
                     'damageDeviation': None,
                     'attackerVehicleName': '',
                     'battletype-key': 'unknown'
                     }

    def updateLabels(self):
        # start_t = time.clock()
        global macros
        macros = None
        _log.callEvent = _logBackground.callEvent = not isDownAlt
        _logAlt.callEvent = _logAltBackground.callEvent = isDownAlt
        _logAlt.output()
        _log.output()
        # start_t = time.clock()
        # log('updateLabels')
        # global prof_time
        # prof_time += time.clock() - start_t
        # log('time_func = %.6f         |        total_time = %.6f' % (time.clock() - start_t, prof_time))
        _logBackground.output()
        _logAltBackground.output()
        if not self.data['isAlive']:
            removePlayerFromLogs(self.vehicleID)
        self.data['splashHit'] = False

    def resetDataStats(self):
        self.data['wn8'] = None
        self.data['xwn8'] = None
        self.data['wtr'] = None
        self.data['xwtr'] = None
        self.data['eff'] = None
        self.data['xeff'] = None
        self.data['wgr'] = None
        self.data['xwgr'] = None
        self.data['xte'] = None

    def resetDataVehInfo(self):
        self.data['attackedVehicleType'] = 'not_vehicle'
        self.data['shortUserString'] = ''
        self.data['attackerVehicleName'] = ''
        self.data['level'] = None
        self.data['nation'] = None
        self.data['diff-masses'] = None

    def getTeamDmg(self, vehicleID):
        pl = _stat.players.get(vehicleID, None)
        if pl is not None:
            if pl.team != self.player.team:
                return 'enemy-dmg'
            return 'player' if pl.name == self.player.name else 'ally-dmg'
        return self.data['teamDmg'] if not self.isVehicle else 'unknown'


    def updateData(self):
        self.data['teamDmg'] = self.getTeamDmg(self.vehicleID)
        maxHealth = self.vehHealth[self.vehicleID]['maxHealth'] if self.vehicleID in self.vehHealth else 0
        self.data['dmgRatio'] = self.data['damage'] * 100 // maxHealth if maxHealth != 0 else 0
        if self.vehicleID:
            attacked = self.player.arena.vehicles.get(self.vehicleID)
            if attacked is not None:
                vehicleType = attacked['vehicleType']
                self.data['name'] = attacked['name']
                self.data['clanAbbrev'] = attacked['clanAbbrev']
                if vehicleType:
                    _type = vehicleType.type
                    self.data['attackedVehicleType'] = list(_type.tags.intersection(VEHICLE_CLASSES))[0]
                    self.data['attackerVehicleName'] = vehicleType.name.replace(':', '-', 1) if vehicleType.name else ''
                    self.data['shortUserString'] = _type.shortUserString
                    self.data['level'] = vehicleType.level
                    self.data['nation'] = nations.NAMES[_type.customizationNationID]
                    self.data['diff-masses'] = (self.player.vehicleTypeDescriptor.physics['weight'] - vehicleType.physics['weight']) / 1000.0 if self.data['attackReasonID'] == 2 else None
                else:
                    self.resetDataVehInfo()
                if (_stat.resp is not None) and (attacked['name'] in _stat.resp['players']):
                    stats = _stat.resp['players'][attacked['name']]
                    self.data['wn8'] = stats.get('wn8', None)
                    self.data['xwn8'] = stats.get('xwn8', None)
                    self.data['wtr'] = stats.get('wtr', None)
                    self.data['xwtr'] = stats.get('xwtr', None)
                    self.data['eff'] = stats.get('e', None)
                    self.data['xeff'] = stats.get('xeff', None)
                    self.data['wgr'] = stats.get('wgr', None)
                    self.data['xwgr'] = stats.get('xwgr', None)
                    self.data['xte'] = stats.get('v').get('xte', None)
                else:
                    self.resetDataStats()
            elif not self.isVehicle:
                self.resetDataStats()
                self.resetDataVehInfo()
                self.data['shortUserString'] = l10n(PILLBOX).format(self.entityNumber)
                self.data['name'] = ''
                self.data['clanAbbrev'] = ''
                self.data['clanicon'] = None
                self.data['squadnum'] = None
                self.data['compName'] = None
                self.data['criticalHit'] = None
            else:
                self.data['name'] = ''
                self.data['clanAbbrev'] = ''
                self.resetDataStats()
                self.resetDataVehInfo()
            self.data['clanicon'] = _stat.getClanIcon(self.vehicleID)

            arenaDP = self.guiSessionProvider.getArenaDP()
            if arenaDP is not None:
                vInfo = arenaDP.getVehicleInfo(vID=self.vehicleID)
                self.data['squadnum'] = vInfo.squadIndex if vInfo.squadIndex != 0 else None
            else:
                self.data['squadnum'] = None
        else:
            self.resetDataVehInfo()
            self.resetDataStats()
            self.data['name'] = ''
            self.data['clanAbbrev'] = ''
            self.data['clanicon'] = None
            self.data['squadnum'] = None
        self.updateLabels()

    def loaded(self):
        self.intCD = self.ammo.getCurrentShellCD()

    def onHealthChanged(self, vehicle, newHealth, attackerID, attackReasonID, isVehicle=True):
        self.isVehicle = isVehicle
        if attackReasonID < 8:
            self.data['attackReasonID'] = attackReasonID
        elif attackReasonID in [9, 10, 13, 24]:
            self.data['attackReasonID'] = 24
        elif attackReasonID in [11, 14, 25]:
            self.data['attackReasonID'] = 25
        self.data['blownup'] = newHealth <= -5
        newHealth = max(0, newHealth)
        self.data['damage'] = (self.vehHealth[vehicle.id]['health'] - newHealth) if vehicle.id in self.vehHealth else (- newHealth)
        self.data['damageDeviation'] = None
        if self.data['attackReasonID'] != 0:
            self.data['costShell'] = 'unknown'
            self.data['criticalHit'] = False
            self.data['shellKind'] = 'not_shell'
            self.data['splashHit'] = False
            self.data['compName'] = None
        else:
            if self.intCD is None:
                self.data['costShell'] = 'unknown'
                self.data['shellKind'] = 'not_shell'
            else:
                _shells = self.shells[self.intCD]
                self.data['shellKind'] = _shells['shellKind']
                self.data['costShell'] = _shells['costShell']
                self.data['damageDeviation'] = 0.0
                if newHealth > 0:
                    self.data['damageDeviation'] = (self.data['damage'] - _shells['shellDamage']) / float(_shells['shellDamage'])
                    if (_shells['shellKind'] in ['high_explosive', 'armor_piercing_he']) and (self.data['damageDeviation'] < -0.25):
                        self.data['damageDeviation'] = 0.0
        if not self.isVehicle:
            self.entityNumber = vehicle.destructibleEntityID
        self.vehicleID = vehicle.id
        self.data['isAlive'] = vehicle.isAlive()
        self.updateData()

    def showDamageFromShot(self, vehicle, attackerID, points, effectsIndex, damageFactor):
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
        self.data['criticalHit'] = (maxHitEffectCode == 5)

    def onEnterWorld(self, vehicle):
        self.player = BigWorld.player()
        self.playerVehicleID = self.player.playerVehicleID
        self.ammo = self.guiSessionProvider.shared.ammo
        shots = vehicle.typeDescriptor.gun.shots
        nation = nations.NAMES[vehicle.typeDescriptor.type.id[0]]
        xmlPath = '%s%s%s%s' % (ITEM_DEFS_PATH, 'vehicles/', nation, '/components/shells.xml')
        xmlCtx_s = (((None, '{}/{}'.format(xmlPath, n)), s) for n, s in ResMgr.openSection(xmlPath).items() if (n != 'icons') and (n != 'xmlns:xmlref'))
        goldShells = [_xml.readInt(xmlCtx, s, 'id', 0, 65535) for xmlCtx, s in xmlCtx_s if s.readBool('improved', False)]
        for shot in shots:
            shell = shot.shell
            intCD = shell.compactDescr
            self.shells[intCD] = {}
            self.shells[intCD]['shellKind'] = shell.kind.lower()
            self.shells[intCD]['shellDamage'] = shell.damage[0]
            self.shells[intCD]['costShell'] = 'gold-shell' if shell.id[1] in goldShells else 'silver-shell'
        ResMgr.purge(xmlPath, True)
        arena = avatar_getter.getArena()
        self.data['battletype-key'] = BATTLE_TYPE.get(arena.guiType, ARENA_GUI_TYPE.UNKNOWN)

    def updateVehInfo(self, vehicle):
        if vehicle.id not in self.vehHealth:
            self.vehHealth[vehicle.id] = {}
        self.vehHealth[vehicle.id]['health'] = int(vehicle.health)
        self.vehHealth[vehicle.id]['maxHealth'] = int(vehicle.maxHealth) if isinstance(vehicle, DestructibleEntity) else vehicle.typeDescriptor.maxHealth
        if not vehicle.isAlive() and vehicle.id not in self.vehDead:
            self.vehDead.append(vehicle.id)


_data = DataHitLog()


class GroupHit(object):

    def __init__(self, section):
        self.section = section
        self.listLog = []
        self.players = {}
        self.countLines = 0
        self.maxCountLines = None
        self.isAddToEnd = False
        self.S_LINES = section + LINES
        self.S_ADD_TO_END = section + ADD_TO_END
        self.S_FORMAT_HISTORY = section + FORMAT_HISTORY
        self.ATTACK_REASON_FIRE_ID = ATTACK_REASON.getIndex(ATTACK_REASON.FIRE)
        self.ATTACK_REASON_RAM_ID = ATTACK_REASON.getIndex(ATTACK_REASON.RAM)
        self.attackReasonID = 0
        self.damage = 0
        self.isGroup = False
        self.vehID = 0

    def sumDmg(self):
        player = self.players[self.vehID]
        player['dmg-player'] += self.damage
        if self.attackReasonID not in player['dmg-kind-player']:
            player['dmg-kind-player'].append(self.attackReasonID)
        maxHealth = _data.vehHealth[self.vehID]['maxHealth'] if self.vehID in _data.vehHealth else 0
        player['dmg-ratio-player'] = (player['dmg-player'] * 100 // maxHealth) if maxHealth != 0 else 0

    def updateValueMacros(self, value):
        global macros

        def readColor(sec, _value, _xvalue=None):

            def getColor(c, v):
                for i in c:
                    if i['value'] > v:
                        color = i['color']
                        return '#' + color[2:] if color[:2] == '0x' else color
                return None

            colors = _config.get('colors/' + sec)
            if _value is not None and colors is not None:
                return getColor(colors, _value)
            elif _xvalue is not None:
                colors_x = _config.get('colors/x')
                return getColor(colors_x, _xvalue)

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
                      'clanicon': value['clanicon'],
                      'squad-num': value['squadnum'],
                      'alive': 'al' if value['isAlive'] else None,
                      'splash-hit': 'splash' if value['splashHit'] else None,
                      'critical-hit': 'crit' if value['criticalHit'] else None,
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
                      'blownup': 'blownup' if value['blownup'] else None,
                      'vehiclename': value.get('attackerVehicleName', None),
                      'battletype-key': value.get('battletype-key', ARENA_GUI_TYPE.UNKNOWN)
                      }
        macros.update({'c:team-dmg': conf['c_teamDmg'].get(value['teamDmg'], '#FFFFFF'),
                       'team-dmg': conf['teamDmg'].get(value['teamDmg'], ''),
                       'vtype': conf['vehicleClass'].get(VEHICLE_CLASSES_SHORT[value['attackedVehicleType']], ''),
                       'c:costShell': conf['c_Shell'].get(value['costShell'], None),
                       'costShell': conf['costShell'].get(value['costShell'], None),
                       'c:dmg-kind': conf['c_dmg-kind'][ATTACK_REASONS[value['attackReasonID']]],
                       'dmg-kind': conf['dmg-kind'].get(ATTACK_REASONS[value['attackReasonID']],
                                                        'reason: %s' % value['attackReasonID']),
                       'dmg-kind-player': ''.join([conf['dmg-kind-player'].get(ATTACK_REASONS[i], None) for i in
                                                   value.get('dmg-kind-player', [])]),
                       'c:vtype': conf['c_VehicleClass'].get(VEHICLE_CLASSES_SHORT[value['attackedVehicleType']], '#CCCCCC'),
                       'comp-name': conf['compNames'].get(value['compName'], None),
                       'type-shell': conf['typeShell'].get(value['shellKind'], None),
                       'type-shell-key': value['shellKind'] if value['shellKind'] is not None else 'not_shell',
                       'c:type-shell': conf['c_typeShell'].get(value['shellKind'], None),
                       'dmg': value['damage'],
                       'dmg-ratio': value['dmgRatio'],
                       'n-player': value.get('n-player', 0),
                       'dmg-player': value.get('dmg-player', 0),
                       'dmg-ratio-player': value.get('dmg-ratio-player', 0),
                       'c:dmg-ratio-player': readColor('dmg_ratio_player', value.get('dmg-ratio-player', None)),
                       'dmg-deviation': value['damageDeviation'] * 100 if value['damageDeviation'] is not None else None
                       })

    def setParametrsHitLog(self):
        self.countLines = len(self.listLog)
        self.attackReasonID = _data.data['attackReasonID']
        self.damage = _data.data['damage']
        self.vehID = _data.vehicleID
        try:
            self.maxCountLines = int(parser(_config.get(self.S_LINES, 7), {'battletype-key': _data.data.get('battletype-key', ARENA_GUI_TYPE.UNKNOWN)}))
        except TypeError:
            self.maxCountLines = 7
        self.isAddToEnd = _config.get(self.S_ADD_TO_END, False)

    def reset(self):
        self.players = {}
        self.listLog = []
        self.countLines = 0
        self.maxCountLines = None


class GroupHitByPlayer(GroupHit):

    def updateList(self, playerData, mode):
        playerData.update(_data.data)
        if playerData['attackReasonID'] == 1:
            playerData['damage'] = playerData['fireDmg']
        elif playerData['attackReasonID'] == 2:
            playerData['damage'] = playerData['rammingDmg']
        self.updateValueMacros(playerData)
        if mode == APPEND:
            self.listLog.append(parser(_config.get(self.S_FORMAT_HISTORY, '')))
        elif mode == INSERT:
            self.listLog.insert(0, parser(_config.get(self.S_FORMAT_HISTORY, '')))
        elif mode == CHANGE:
            self.listLog[playerData['numberLine']] = parser(_config.get(self.S_FORMAT_HISTORY, ''))

    def updateGroupFireRamming(self, playerData):

        def updateDmg(typeTime, typeDmg):
            if (BigWorld.time() - playerData[typeTime]) < 1.0:
                playerData[typeDmg] += self.damage
            else:
                playerData[typeDmg] = self.damage
                playerData['n-player'] += 1
            playerData[typeTime] = BigWorld.time()

        if self.attackReasonID == 0:
            playerData['n-player'] += 1
        elif self.attackReasonID == 1:
            updateDmg('fireTime', 'fireDmg')
        elif self.attackReasonID == 2:
            updateDmg('rammingTime', 'rammingDmg')

    def updatePlayers(self, vehID):
        self.sumDmg()
        pl = self.players[vehID]
        self.updateGroupFireRamming(pl)
        if self.maxCountLines == 1:
            self.players[vehID]['numberLine'] = 0
            self.updateList(self.players[vehID], CHANGE if self.countLines else APPEND)
        elif self.isAddToEnd:
            if pl['numberLine'] == self.countLines - 1:
                self.updateList(pl, CHANGE)
            else:
                if (pl['numberLine'] >= 0) and (pl['numberLine'] < self.countLines):
                    self.listLog.pop(pl['numberLine'])
                else:
                    self.listLog.pop(0)
                for v in self.players:
                    if self.players[v]['numberLine'] > pl['numberLine']:
                        self.players[v]['numberLine'] -= 1
                pl['numberLine'] = self.countLines - 1
                self.updateList(pl, APPEND)
        else:
            if pl['numberLine'] == 0:
                self.updateList(pl, CHANGE)
            else:
                if (pl['numberLine'] > 0) and (pl['numberLine'] < self.countLines):
                    self.listLog.pop(pl['numberLine'])
                else:
                    self.listLog.pop(self.countLines - 1)
                for v in self.players:
                    if self.players[v]['numberLine'] < pl['numberLine']:
                        self.players[v]['numberLine'] += 1
                pl['numberLine'] = 0
                self.updateList(pl, INSERT)

    def addPlayer(self):
        return {'dmg-player': self.damage,
                'dmg-ratio-player': _data.data['dmgRatio'],
                'n-player': 1,
                'fireDmg': 0,
                'fireTime': 0,
                'rammingDmg': 0,
                'rammingTime': 0,
                'numberLine': 0,
                'dmg-kind-player': [_data.data['attackReasonID']]
                }

    def addPlayers(self, vehID):
        self.players[vehID] = self.addPlayer()
        if self.attackReasonID == 2:
            self.players[vehID]['rammingDmg'] = self.damage
            self.players[vehID]['rammingTime'] = BigWorld.time()
        if self.maxCountLines == 1:
            self.players[vehID]['numberLine'] = 0
            self.updateList(self.players[vehID], CHANGE if self.countLines else APPEND)
        elif self.isAddToEnd:
            if self.countLines >= self.maxCountLines:
                if 0 < self.countLines:
                    self.listLog.pop(0)
                for v in self.players:
                    self.players[v]['numberLine'] -= 1
            self.players[vehID]['numberLine'] = min(self.countLines, self.maxCountLines - 1)
            self.updateList(self.players[vehID], APPEND)
        else:
            if self.countLines >= self.maxCountLines:
                if 0 < self.countLines:
                    self.listLog.pop(self.countLines - 1)
            for v in self.players:
                self.players[v]['numberLine'] += 1
            self.players[vehID]['numberLine'] = 0
            self.updateList(self.players[vehID], INSERT)

    def getListLog(self):
        self.setParametrsHitLog()
        vehID = _data.vehicleID
        if vehID in self.players:
            self.updatePlayers(vehID)
        else:
            self.addPlayers(vehID)
        return self.listLog


class GroupHitByFireRamming(GroupHit):

    def udateData(self):
        data = _data.data.copy()
        player = self.players[self.vehID]
        data['dmg-player'] = player['dmg-player']
        data['dmg-ratio-player'] = player['dmg-ratio-player']
        data['damage'] = player['damage']
        data['n-player'] = player['n-player']
        data['dmg-kind-player'] = player['dmg-kind-player']
        self.updateValueMacros(data)

    def udateListLog(self):
        player = self.players[self.vehID]
        if self.isGroup:
            self.listLog[player[self.attackReasonID]['numberLine']] = parser(_config.get(self.S_FORMAT_HISTORY, ''))
        elif self.isAddToEnd:
            if self.countLines >= self.maxCountLines and 0 < self.countLines:
                self.listLog.pop(0)
                for v in self.players.itervalues():
                    if self.ATTACK_REASON_FIRE_ID in v:
                        v[self.ATTACK_REASON_FIRE_ID]['numberLine'] -= 1
                    if self.ATTACK_REASON_RAM_ID in v:
                        v[self.ATTACK_REASON_RAM_ID]['numberLine'] -= 1
            self.listLog.append(parser(_config.get(self.S_FORMAT_HISTORY, '')))
        else:
            if self.countLines >= self.maxCountLines and 0 < self.countLines:
                self.listLog.pop(self.countLines - 1)
            for v in self.players.itervalues():
                if self.ATTACK_REASON_FIRE_ID in v:
                    v[self.ATTACK_REASON_FIRE_ID]['numberLine'] += 1
                if self.ATTACK_REASON_RAM_ID in v:
                    v[self.ATTACK_REASON_RAM_ID]['numberLine'] += 1
            self.listLog.insert(0, parser(_config.get(self.S_FORMAT_HISTORY, '')))

    def addAttackReasonID(self):
        return {'damage': self.damage,
                'leftTime': BigWorld.time(),
                'numberLine': self.countLines if self.isAddToEnd else -1}

    def addPlayer(self):
        return {'dmg-player': self.damage,
                'dmg-ratio-player': _data.data['dmgRatio'],
                'damage': self.damage,
                'n-player': 1,
                'dmg-kind-player': [self.attackReasonID]}

    def updateAttackReasonID(self):
        player = self.players[self.vehID]
        if self.attackReasonID in player:
            paramAttack = player[self.attackReasonID]
            if (BigWorld.time() - paramAttack['leftTime']) < 1.0:
                self.isGroup = True
                paramAttack['damage'] += self.damage
            else:
                player['n-player'] += 1
                paramAttack['damage'] = self.damage
                paramAttack['numberLine'] = self.countLines if self.isAddToEnd else -1
            paramAttack['leftTime'] = BigWorld.time()
            player['damage'] = paramAttack['damage']
        else:
            player[self.attackReasonID] = self.addAttackReasonID()
            player['damage'] = self.damage

    def updatePlayer(self):
        self.isGroup = False
        if self.vehID in self.players:
            player = self.players[self.vehID]
            if self.attackReasonID in [1, 2]:
                self.updateAttackReasonID()
            else:
                player['n-player'] += 1
                player['damage'] = self.damage
            self.sumDmg()
        else:
            self.players[self.vehID] = self.addPlayer()
            if self.attackReasonID in [1, 2]:
                self.players[self.vehID][self.attackReasonID] = self.addAttackReasonID()

    def getListLog(self):
        self.setParametrsHitLog()
        self.updatePlayer()
        self.udateData()
        self.udateListLog()
        return self.listLog


class HitLog(object):

    def __init__(self, section):
        self.section = section
        self.listLog = []
        self.groupHitByPlayer = GroupHitByPlayer(section)
        self.groupHitByFireRamming = GroupHitByFireRamming(section)
        self.S_GROUP_HITS_PLAYER = section + GROUP_HITS_PLAYER
        self.S_MOVE_IN_BATTLE = HIT_LOG_SECTIONS.LOG + MOVE_IN_BATTLE
        self.DEFAULT_X = 320
        self.DEFAULT_Y = 0
        self.S_X = HIT_LOG_SECTIONS.LOG + 'x'
        self.S_Y = HIT_LOG_SECTIONS.LOG + 'y'
        self.x = 0
        self.y = 0

    def setPosition(self, battleType):
        self._data = None
        positon = {'x': _config.get(self.S_X, self.DEFAULT_X), 'y': _config.get(self.S_Y, self.DEFAULT_Y)}
        if _config.get(self.S_MOVE_IN_BATTLE, False):
            _data = userprefs.get(HIT_LOG_SECTIONS.LOG + '{}'.format(battleType), positon)
            as_callback("hitLog_mouseDown", self.mouse_down)
            as_callback("hitLog_mouseUp", self.mouse_up)
            as_callback("hitLog_mouseMove", self.mouse_move)
        else:
            _data = positon
        self.x = _data['x']
        self.y = _data['y']

    def savePosition(self, battleType):
        if (None not in [self.x, self.y]) and _config.get(self.S_MOVE_IN_BATTLE, False):
            userprefs.set(HIT_LOG_SECTIONS.LOG + '{}'.format(battleType), {'x': self.x, 'y': self.y})

    def reset(self):
        self.groupHitByPlayer.reset()
        self.groupHitByFireRamming.reset()

    def mouse_down(self, _data):
        if _data['buttonIdx'] == 0:
            self._data = _data

    def mouse_up(self, _data):
        if _data['buttonIdx'] == 0:
            self._data = None

    def mouse_move(self, _data):
        if self._data:
            self.x += (_data['x'] - self._data['x'])
            self.y += (_data['y'] - self._data['y'])
            as_event(ON_HIT_LOG)

    def updatePosition(self):
        if (self.section == HIT_LOG_SECTIONS.LOG) or (self.section == HIT_LOG_SECTIONS.ALT_LOG):
            if not _config.get(self.S_MOVE_IN_BATTLE, False):
                self.x = parser(_config.get(self.S_X, self.DEFAULT_X))
                self.y = parser(_config.get(self.S_Y, self.DEFAULT_Y))

    def output(self):
        if _config.get(self.S_GROUP_HITS_PLAYER, True):
            self.listLog = self.groupHitByPlayer.getListLog()
        else:
            self.listLog = self.groupHitByFireRamming.getListLog()
        self.updatePosition()
        if self.callEvent:
            as_event(ON_HIT_LOG)


_log = HitLog(HIT_LOG_SECTIONS.LOG)
_logAlt = HitLog(HIT_LOG_SECTIONS.ALT_LOG)
_logBackground = HitLog(HIT_LOG_SECTIONS.BACKGROUND)
_logAltBackground = HitLog(HIT_LOG_SECTIONS.ALT_BACKGROUND)


@registerEvent(PlayerAvatar, '_PlayerAvatar__processVehicleAmmo')
def PlayerAvatar__processVehicleAmmo(self, vehicleID, compactDescr, quantity, quantityInClip, _, __):
    if battle.isBattleTypeSupported and _config.get(HIT_LOG_ENABLED, True):
        _data.loaded()


@registerEvent(DestructibleEntity, 'onEnterWorld')
def DestructibleEntity_onEnterWorld(self, prereqs):
    if self.isAlive():
        _data.updateVehInfo(self)


@registerEvent(DestructibleEntity, 'onHealthChanged')
def DestructibleEntity_onHealthChanged(self, newHealth, attackerID, attackReasonID, hitFlags):
    destructibleEntityComponent = BigWorld.player().arena.componentSystem.destructibleEntityComponent
    if _config.get(HIT_LOG_ENABLED, True) and battle.isBattleTypeSupported and (destructibleEntityComponent is not None):
        if (_data.playerVehicleID == attackerID) and (self.id not in _data.vehDead):
            if not self.isPlayerTeam or _config.get(SHOW_ALLY_DAMAGE, True):
                _data.onHealthChanged(self, newHealth, attackerID, attackReasonID, False)
        _data.updateVehInfo(self)


@registerEvent(Vehicle, 'showDamageFromShot')
def _Vehicle_showDamageFromShot(self, attackerID, points, effectsIndex, damageFactor):
    if battle.isBattleTypeSupported and (_data.playerVehicleID == attackerID) and self.isAlive() and _config.get(HIT_LOG_ENABLED, True):
        _data.showDamageFromShot(self, attackerID, points, effectsIndex, damageFactor)


@registerEvent(Vehicle, 'showDamageFromExplosion')
def _Vehicle_showDamageFromExplosion(self, attackerID, center, effectsIndex, damageFactor):
    if battle.isBattleTypeSupported and (_data.playerVehicleID == attackerID) and self.isAlive() and _config.get(HIT_LOG_ENABLED, True):
        _data.data['splashHit'] = True
        _data.data['criticalHit'] = False


@registerEvent(PlayerAvatar, '_PlayerAvatar__onArenaVehicleKilled')
def __onArenaVehicleKilled(self, targetID, attackerID, equipmentID, reason):
    if self.playerVehicleID != attackerID:
        removePlayerFromLogs(targetID)


@registerEvent(Vehicle, 'onEnterWorld')
def _Vehicle_onEnterWorld(self, prereqs):
    global hitLogConfig, chooseRating
    if _config.get(HIT_LOG_ENABLED, True) and battle.isBattleTypeSupported:
        if self.id in _data.vehDead:
            _data.vehDead.remove(self.id)
        if self.isPlayerVehicle:
            scale = config.networkServicesSettings.scale
            name = config.networkServicesSettings.rating
            r = '{}_{}'.format(scale, name)
            if r in RATINGS:
                chooseRating = RATINGS[r]['name']
            else:
                chooseRating = 'xwgr' if scale == 'xvm' else 'wgr'
            _data.onEnterWorld(self)
            if not (config.config_autoreload or hitLogConfig):
                for section in HIT_LOG_SECTIONS.SECTIONS:
                    hitLogConfig[section] = readyConfig(section)
            _log.setPosition(_data.data.get('battletype-key', None))


@registerEvent(Vehicle, 'startVisual')
def _Vehicle_startVisual(self):
    if _config.get(HIT_LOG_ENABLED, True) and battle.isBattleTypeSupported:
        _data.updateVehInfo(self)


@registerEvent(Vehicle, 'onHealthChanged')
def _Vehicle_onHealthChanged(self, newHealth, attackerID, attackReasonID):
    if _config.get(HIT_LOG_ENABLED, True) and battle.isBattleTypeSupported:
        if (_data.playerVehicleID == attackerID) and (self.id not in _data.vehDead):
            attacked = _data.player.arena.vehicles.get(self.id)
            if (_data.player.team != attacked['team']) or _config.get(SHOW_ALLY_DAMAGE, True):
                if (self.id != attackerID) or _config.get(SHOW_SELF_DAMAGE, True):
                    _data.onHealthChanged(self, newHealth, attackerID, attackReasonID)
            else:
                if (self.id == attackerID) and _config.get(SHOW_SELF_DAMAGE, True):
                    _data.onHealthChanged(self, newHealth, attackerID, attackReasonID)
        _data.updateVehInfo(self)


@registerEvent(PlayerAvatar, '_PlayerAvatar__destroyGUI')
def PlayerAvatar__destroyGUI(self):
    if _config.get(HIT_LOG_ENABLED, True) and battle.isBattleTypeSupported:
        _log.savePosition(_data.data.get('battletype-key', None))
        _log.reset()
        _logAlt.reset()
        _logBackground.reset()
        _logAltBackground.reset()
        _data.reset()


@registerEvent(PlayerAvatar, 'handleKey')
def PlayerAvatar_handleKey(self, isDown, key, mods):
    global isDownAlt
    if _config.get(HIT_LOG_ENABLED, True) and battle.isBattleTypeSupported:
        hotkey = _config.get('hotkeys/hitLogAltMode')
        if hotkey['enabled'] and (key == hotkey['keyCode']):
            if isDown:
                if hotkey['onHold']:
                    if not isDownAlt:
                        isDownAlt = True
                        as_event(ON_HIT_LOG)
                else:
                    isDownAlt = not isDownAlt
                    as_event(ON_HIT_LOG)
            else:
                if hotkey['onHold']:
                    if isDownAlt:
                        isDownAlt = False
                        as_event(ON_HIT_LOG)


def hLog():
    listLog = '\n'.join(_log.listLog) if _log.listLog else None
    listLogAlt = '\n'.join(_logAlt.listLog) if _logAlt.listLog else None
    return listLogAlt if isDownAlt else listLog


def hLog_bg():
    listLog = '\n'.join(_logBackground.listLog) if _logBackground.listLog else None
    listLogAlt = '\n'.join(_logAltBackground.listLog) if _logAltBackground.listLog else None
    return listLogAlt if isDownAlt else listLog


def hLog_x():
    return _log.x


def hLog_y():
    return _log.y
