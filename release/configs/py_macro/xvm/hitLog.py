import BigWorld
from Vehicle import Vehicle
from DestructibleEntity import DestructibleEntity
from Avatar import PlayerAvatar
import nations
import ResMgr
from constants import ITEM_DEFS_PATH, ARENA_GUI_TYPE, VEHICLE_CLASSES
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider
from VehicleEffects import DamageFromShotDecoder
from vehicle_systems.tankStructure import TankPartIndexes
from items import _xml

from xfw import *
from xfw_actionscript.python import *
from xvm_main.python.logger import *
from xvm_main.python.stats import _stat
from xvm_main.python.xvm import l10n
import xvm_main.python.config as config
import xvm_main.python.userprefs as userprefs
import xvm_battle.python.battle as battle


from xvm.damageLog import HIT_EFFECT_CODES, keyLower, chooseRating, ATTACK_REASONS, RATINGS, VEHICLE_CLASSES_SHORT
import parser_addon

macros = None
autoReloadConfig = None
hitLogConfig = {}
isDownAlt = False


HIT_LOG = 'hitLog/'
FORMAT_HISTORY = 'formatHistory'
GROUP_HITS_PLAYER = 'groupHitsByPlayer'
ADD_TO_END = 'addToEnd'
LINES = 'lines'
MOVE_IN_BATTLE = 'moveInBattle'
ENABLED = HIT_LOG + 'enabled'
SHOW_SELF_DAMAGE = HIT_LOG + 'showSelfDamage'
SHOW_ALLY_DAMAGE = HIT_LOG + 'showAllyDamage'
DEFAULT_X = 320
DEFAULT_Y = 0

SECTION_LOG = HIT_LOG + 'log/'
SECTION_ALT_LOG = HIT_LOG + 'logAlt/'
SECTION_BACKGROUND = HIT_LOG + 'logBackground/'
SECTION_ALT_BACKGROUND = HIT_LOG + 'logAltBackground/'
SECTIONS = (SECTION_LOG, SECTION_ALT_LOG, SECTION_BACKGROUND, SECTION_ALT_BACKGROUND)

PILLBOX = 'pillbox'

APPEND = 0
CHANGE = 1
INSERT = 2

def readyConfig(section):
    if autoReloadConfig or (section not in hitLogConfig):
        return {'vehicleClass': keyLower(config.get(section + 'vtype')),
                'c_Shell': keyLower(config.get(section + 'c:costShell')),
                'costShell': keyLower(config.get(section + 'costShell')),
                'c_dmg-kind': keyLower(config.get(section + 'c:dmg-kind')),
                'c_VehicleClass': keyLower(config.get(section + 'c:vtype')),
                'dmg-kind': keyLower(config.get(section + 'dmg-kind')),
                'dmg-kind-player': keyLower(config.get(section + 'dmg-kind-player')),
                'c_teamDmg': keyLower(config.get(section + 'c:team-dmg')),
                'teamDmg': keyLower(config.get(section + 'team-dmg')),
                'compNames': keyLower(config.get(section + 'comp-name')),
                'typeShell': keyLower(config.get(section + 'type-shell')),
                'c_typeShell': keyLower(config.get(section + 'c:type-shell')),
                }
    else:
        return hitLogConfig[section]


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
                  'blownup': 'blownup' if value['blownup'] else None
                  }
    macros.update({'c:team-dmg': conf['c_teamDmg'].get(value['teamDmg'], '#FFFFFF'),
                   'team-dmg': conf['teamDmg'].get(value['teamDmg'], ''),
                   'vtype': conf['vehicleClass'].get(VEHICLE_CLASSES_SHORT[value['attackedVehicleType']], ''),
                   'c:costShell': conf['c_Shell'].get(value['costShell'], None),
                   'costShell': conf['costShell'].get(value['costShell'], None),
                   'c:dmg-kind': conf['c_dmg-kind'][ATTACK_REASONS[value['attackReasonID']]],
                   'dmg-kind': conf['dmg-kind'].get(ATTACK_REASONS[value['attackReasonID']], 'reason: %s' % value['attackReasonID']),
                   'dmg-kind-player': ''.join([conf['dmg-kind-player'].get(ATTACK_REASONS[i], None) for i in value['dmg-kind-player']]),
                   'c:vtype': conf['c_VehicleClass'].get(VEHICLE_CLASSES_SHORT[value['attackedVehicleType']], '#CCCCCC'),
                   'comp-name': conf['compNames'].get(value['compName'], None),
                   'type-shell': conf['typeShell'].get(value['shellKind'], None),
                   'type-shell-key': value['shellKind'] if value['shellKind'] is not None else 'not_shell',
                   'c:type-shell': conf['c_typeShell'].get(value['shellKind'], None),
                   'dmg': value['damage'],
                   'dmg-ratio': value['dmgRatio'],
                   'n-player': value['n-player'],
                   'dmg-player': value['dmg-player'],
                   'dmg-ratio-player': value['dmg-ratio-player'],
                   'c:dmg-ratio-player': readColor('dmg_ratio_player', value.get('dmg-ratio-player', None)),
                   'dmg-deviation': value['damageDeviation'] * 100 if value['damageDeviation'] is not None else None
                   })


def parser(strHTML):
    s = parser_addon.parser_addon(strHTML, macros)
    return s


def removePlayerFromLogs(vehicleID):
    def del_key(_dict, key):
        if key in _dict:
            _dict[key].clear()
            del _dict[key]

    del_key(_log.players, vehicleID)
    del_key(_logAlt.players, vehicleID)
    del_key(_logBackground.players, vehicleID)
    del_key(_logAltBackground.players, vehicleID)


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
                     'damageDeviation': None
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

    def reload(self):
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

    def updateVehInfo(self, vehicle):
        if vehicle.id not in self.vehHealth:
            self.vehHealth[vehicle.id] = {}
        self.vehHealth[vehicle.id]['health'] = int(vehicle.health)
        self.vehHealth[vehicle.id]['maxHealth'] = int(vehicle.maxHealth) if isinstance(vehicle, DestructibleEntity) else vehicle.typeDescriptor.maxHealth
        if not vehicle.isAlive() and vehicle.id not in self.vehDead:
            self.vehDead.append(vehicle.id)


_data = DataHitLog()


class HitLog(object):

    def __init__(self, section):
        self.section = section
        self.players = {}
        self.listLog = []
        self.countLines = 0
        self.maxCountLines = None
        self.numberLine = 0
        self.S_GROUP_HITS_PLAYER = section + GROUP_HITS_PLAYER
        self.S_ADD_TO_END = section + ADD_TO_END
        self.S_LINES = section + LINES
        self.S_FORMAT_HISTORY = section + FORMAT_HISTORY
        self.S_MOVE_IN_BATTLE = section + MOVE_IN_BATTLE
        self.S_X = section + 'x'
        self.S_Y = section + 'y'
        self._data = None
        if config.get(self.S_MOVE_IN_BATTLE, False):
            _data = userprefs.get('hitLog/log', {'x': config.get(self.S_X, DEFAULT_X), 'y': config.get(self.S_Y, DEFAULT_Y)})
            if section == SECTION_LOG:
                as_callback("hitLog_mouseDown", self.mouse_down)
                as_callback("hitLog_mouseUp", self.mouse_up)
                as_callback("hitLog_mouseMove", self.mouse_move)
        else:
            _data = {'x': config.get(self.S_X, DEFAULT_X), 'y': config.get(self.S_Y, DEFAULT_Y)}
        self.x = _data['x']
        self.y = _data['y']

    def reset(self):
        self.players = {}
        self.listLog = []
        self.countLines = 0
        self.maxCountLines = None
        if (None not in [self.x, self.y]) and config.get(self.S_MOVE_IN_BATTLE, False) and (self.section == SECTION_LOG):
            userprefs.set('hitLog/log', {'x': self.x, 'y': self.y})

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
            as_event('ON_HIT_LOG')

    def sumDmg(self, vehID):
        pl = self.players[vehID]
        pl['dmg-player'] += _data.data['damage']
        if _data.data['attackReasonID'] not in pl['dmg-kind-player']:
            pl['dmg-kind-player'].append(_data.data['attackReasonID'])
        maxHealth = _data.vehHealth[vehID]['maxHealth'] if vehID in _data.vehHealth else 0
        pl['dmg-ratio-player'] = (pl['dmg-player'] * 100 // maxHealth) if maxHealth != 0 else 0

##------------Group hits by players name----------------

    def updateList(self, playerData, mode):
        playerData.update(_data.data)
        if playerData['attackReasonID'] == 1:
            playerData['damage'] = playerData['fireDmg']
        elif playerData['attackReasonID'] == 2:
            playerData['damage'] = playerData['rammingDmg']
        updateValueMacros(self.section, playerData)
        if mode == APPEND:
            self.listLog.append(parser(config.get(self.S_FORMAT_HISTORY, '')))
        elif mode == INSERT:
            self.listLog.insert(0, parser(config.get(self.S_FORMAT_HISTORY, '')))
        elif mode == CHANGE:
            self.listLog[playerData['numberLine']] = parser(config.get(self.S_FORMAT_HISTORY, ''))
        if (self.section == SECTION_LOG) or (self.section == SECTION_ALT_LOG):
            if not config.get(self.S_MOVE_IN_BATTLE, False):
                self.x = parser(config.get(self.S_X, DEFAULT_X))
                self.y = parser(config.get(self.S_Y, DEFAULT_Y))

    def updateGroupFireRamming(self, playerData):

        def updateDmg(typeTime, typeDmg):
            if (BigWorld.time() - playerData[typeTime]) < 1.0:
                playerData[typeDmg] += _data.data['damage']
            else:
                playerData[typeDmg] = _data.data['damage']
                playerData['n-player'] += 1
            playerData[typeTime] = BigWorld.time()

        if _data.data['attackReasonID'] == 0:
            playerData['n-player'] += 1
        elif _data.data['attackReasonID'] == 1:
            updateDmg('fireTime', 'fireDmg')
        elif _data.data['attackReasonID'] == 2:
            updateDmg('rammingTime', 'rammingDmg')

    def updatePlayers(self, vehID):
        self.sumDmg(vehID)
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
                for v in self.players:
                    if self.players[v]['numberLine'] < pl['numberLine']:
                        self.players[v]['numberLine'] += 1
                pl['numberLine'] = 0
                self.updateList(pl, INSERT)

    def addPlayers(self, vehID):
        self.players[vehID] = {'dmg-player': _data.data['damage'],
                               'dmg-ratio-player': _data.data['dmgRatio'],
                               'n-player': 1,
                               'fireDmg': 0,
                               'fireTime': 0,
                               'rammingDmg': 0,
                               'rammingTime': 0,
                               'numberLine': 0,
                               'dmg-kind-player': [_data.data['attackReasonID']]
                               }
        if _data.data['attackReasonID'] == 2:
            self.players[vehID]['rammingDmg'] = _data.data['damage']
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

    def groupHitsPlayer(self):
        vehID = _data.vehicleID
        if vehID in self.players:
            self.updatePlayers(vehID)
        else:
            self.addPlayers(vehID)

##------------Not group hits by player names----------------

    def notGroupHitsPlayer(self):

        def upGroupFireRamming(pl, typeTime, typeDmg, typeNumberLine, typeNPlayer):
            if (BigWorld.time() - pl[typeTime]) < 1.0:
                isGroup = True
                pl[typeDmg] += _data.data['damage']
            else:
                pl[typeDmg] = _data.data['damage']
                pl['n-player'] += 1
                pl[typeNPlayer] = pl['n-playerShot'] = pl['n-player']
                pl[typeNumberLine] = self.countLines + 1 if self.isAddToEnd else -1
                isGroup = False
            pl[typeTime] = BigWorld.time()
            return isGroup

        vehID = _data.vehicleID
        isGroupFire = False
        isGroupRamming = False
        if vehID in self.players:
            self.sumDmg(vehID)
            pl = self.players[vehID]
            if _data.data['attackReasonID'] == 0:
                pl['n-playerShot'] += 1
                pl['n-player'] = pl['n-playerShot']
            elif _data.data['attackReasonID'] == 1:
                isGroupFire = upGroupFireRamming(pl, 'fireTime', 'fireDmg', 'numberLineFire', 'n-playerFire')
            elif _data.data['attackReasonID'] == 2:
                isGroupFire = upGroupFireRamming(pl, 'rammingTime', 'rammingDmg', 'numberLineRamming', 'n-playerRamming')
        else:
            pl = {'dmg-player': _data.data['damage'],
                  'dmg-ratio-player': _data.data['dmgRatio'],
                  'n-player': 1,
                  'fireDmg': 0,
                  'fireTime': 0,
                  'rammingDmg': 0,
                  'rammingTime': 0,
                  'numberLineFire': 0,
                  'numberLineRamming': 0,
                  'n-playerShot': 1,
                  'n-playerFire': 1,
                  'n-playerRamming': 1,
                  'dmg-kind-player': [_data.data['attackReasonID']]}
            if _data.data['attackReasonID'] == 2:
                pl['rammingDmg'] = _data.data['damage']
                pl['numberLineRamming'] = self.countLines if self.isAddToEnd else -1
            elif _data.data['attackReasonID'] == 1:
                pl['fireDmg'] = _data.data['damage']
                pl['numberLineFire'] = self.countLines if self.isAddToEnd else -1
            self.players[vehID] = pl
        pl.update(_data.data)
        if pl['attackReasonID'] == 1:
            pl['damage'] = pl['fireDmg']
            pl['n-player'] = pl['n-playerFire']
        elif pl['attackReasonID'] == 2:
            pl['damage'] = pl['rammingDmg']
            pl['n-player'] = pl['n-playerRamming']
        else:
            pl['n-player'] = pl['n-playerShot']
        updateValueMacros(self.section, pl)
        if isGroupFire and ((pl['numberLineFire'] >= 0) or (pl['numberLineFire'] < self.maxCountLines)):
            self.listLog[pl['numberLineFire']] = parser(config.get(self.S_FORMAT_HISTORY, ''))
        elif isGroupRamming and ((pl['numberLineRamming'] >= 0) or (pl['numberLineRamming'] < self.maxCountLines)):
            self.listLog[pl['numberLineRamming']] = parser(config.get(self.S_FORMAT_HISTORY, ''))
        elif self.isAddToEnd:
            if self.countLines >= self.maxCountLines and 0 < self.countLines:
                self.listLog.pop(0)
            for v in self.players:
                self.players[v]['numberLineFire'] -= 1
                self.players[v]['numberLineRamming'] -= 1
            self.listLog.append(parser(config.get(self.S_FORMAT_HISTORY, '')))
        else:
            if self.countLines >= self.maxCountLines and 0 < self.countLines:
                self.listLog.pop(self.countLines - 1)
            for v in self.players:
                self.players[v]['numberLineFire'] += 1
                self.players[v]['numberLineRamming'] += 1
            self.listLog.insert(0, parser(config.get(self.S_FORMAT_HISTORY, '')))


    def output(self):
        self.countLines = len(self.listLog)
        self.maxCountLines = config.get(self.S_LINES, 7)
        if not self.maxCountLines:
            return
        self.isAddToEnd = config.get(self.S_ADD_TO_END, False)

        if config.get(self.S_GROUP_HITS_PLAYER, True):
            self.groupHitsPlayer()
        else:
            self.notGroupHitsPlayer()
        if self.callEvent:
            as_event('ON_HIT_LOG')

_log = HitLog(SECTION_LOG)
_logAlt = HitLog(SECTION_ALT_LOG)
_logBackground = HitLog(SECTION_BACKGROUND)
_logAltBackground = HitLog(SECTION_ALT_BACKGROUND)


@registerEvent(PlayerAvatar, 'updateVehicleGunReloadTime')
def _PlayerAvatar_updateVehicleGunReloadTime(self, vehicleID, timeLeft, baseTime):
    if battle.isBattleTypeSupported and (timeLeft <= 0.0) and config.get(ENABLED, True):
        _data.reload()


@registerEvent(DestructibleEntity, 'onEnterWorld')
def DestructibleEntity_onEnterWorld(self, prereqs):
    if self.isAlive():
        _data.updateVehInfo(self)


@registerEvent(DestructibleEntity, 'onHealthChanged')
def DestructibleEntity_onHealthChanged(self, newHealth, attackerID, attackReasonID, hitFlags):
    destructibleEntityComponent = BigWorld.player().arena.componentSystem.destructibleEntityComponent
    if config.get(ENABLED, True) and battle.isBattleTypeSupported and (destructibleEntityComponent is not None):
        if (_data.playerVehicleID == attackerID) and (self.id not in _data.vehDead):
            if not self.isPlayerTeam or config.get(SHOW_ALLY_DAMAGE, True):
                _data.onHealthChanged(self, newHealth, attackerID, attackReasonID, False)
        _data.updateVehInfo(self)


@registerEvent(Vehicle, 'showDamageFromShot')
def _Vehicle_showDamageFromShot(self, attackerID, points, effectsIndex, damageFactor):
    if battle.isBattleTypeSupported and (_data.playerVehicleID == attackerID) and self.isAlive() and config.get(ENABLED, True):
        _data.showDamageFromShot(self, attackerID, points, effectsIndex, damageFactor)


@registerEvent(Vehicle, 'showDamageFromExplosion')
def _Vehicle_showDamageFromExplosion(self, attackerID, center, effectsIndex, damageFactor):
    if battle.isBattleTypeSupported and (_data.playerVehicleID == attackerID) and self.isAlive() and config.get(ENABLED, True):
        _data.data['splashHit'] = True
        _data.data['criticalHit'] = False


@registerEvent(PlayerAvatar, '_PlayerAvatar__onArenaVehicleKilled')
def __onArenaVehicleKilled(self, targetID, attackerID, equipmentID, reason):
    if self.playerVehicleID != attackerID:
        removePlayerFromLogs(targetID)


@registerEvent(Vehicle, 'onEnterWorld')
def _Vehicle_onEnterWorld(self, prereqs):
    global autoReloadConfig, hitLogConfig, chooseRating
    if config.get(ENABLED, True) and battle.isBattleTypeSupported:
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
            autoReloadConfig = config.get('autoReloadConfig')
            if not (autoReloadConfig or hitLogConfig):
                for section in SECTIONS:
                    hitLogConfig[section] = readyConfig(section)


@registerEvent(Vehicle, 'startVisual')
def _Vehicle_startVisual(self):
    if config.get(ENABLED, True) and battle.isBattleTypeSupported:
        _data.updateVehInfo(self)


@registerEvent(Vehicle, 'onHealthChanged')
def _Vehicle_onHealthChanged(self, newHealth, attackerID, attackReasonID):
    if config.get(ENABLED, True) and battle.isBattleTypeSupported:
        if (_data.playerVehicleID == attackerID) and (self.id not in _data.vehDead):
            attacked = _data.player.arena.vehicles.get(self.id)
            if (_data.player.team != attacked['team']) or config.get(SHOW_ALLY_DAMAGE, True):
                if (self.id != attackerID) or config.get(SHOW_SELF_DAMAGE, True):
                    _data.onHealthChanged(self, newHealth, attackerID, attackReasonID)
            else:
                if (self.id == attackerID) and config.get(SHOW_SELF_DAMAGE, True):
                    _data.onHealthChanged(self, newHealth, attackerID, attackReasonID)
        _data.updateVehInfo(self)


@registerEvent(PlayerAvatar, '_PlayerAvatar__destroyGUI')
def PlayerAvatar__destroyGUI(self):
    if config.get(ENABLED, True) and battle.isBattleTypeSupported:
        _data.reset()
        _log.reset()
        _logAlt.reset()
        _logBackground.reset()
        _logAltBackground.reset()


@registerEvent(PlayerAvatar, 'handleKey')
def PlayerAvatar_handleKey(self, isDown, key, mods):
    global isDownAlt
    if config.get(ENABLED, True) and battle.isBattleTypeSupported:
        hotkey = config.get('hotkeys/hitLogAltMode')
        if hotkey['enabled'] and (key == hotkey['keyCode']):
            if isDown:
                if hotkey['onHold']:
                    if not isDownAlt:
                        isDownAlt = True
                        as_event('ON_HIT_LOG')
                else:
                    isDownAlt = not isDownAlt
                    as_event('ON_HIT_LOG')
            else:
                if hotkey['onHold']:
                    if isDownAlt:
                        isDownAlt = False
                        as_event('ON_HIT_LOG')


def getLog():
    listLog = '\n'.join(_log.listLog) if _log.listLog else None
    listLogAlt = '\n'.join(_logAlt.listLog) if _logAlt.listLog else None
    return listLogAlt if isDownAlt else listLog


def getLogBackground():
    listLog = '\n'.join(_logBackground.listLog) if _logBackground.listLog else None
    listLogAlt = '\n'.join(_logAltBackground.listLog) if _logAltBackground.listLog else None
    return listLogAlt if isDownAlt else listLog


def getLogX():
    return _log.x


def getLogY():
    return _log.y