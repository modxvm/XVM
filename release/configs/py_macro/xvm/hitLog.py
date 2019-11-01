# Addons: "HitLog"
# ktulho <https://kr.cm/f/p/17624/>

import BigWorld
import ResMgr
import nations
from Avatar import PlayerAvatar
from DestructibleEntity import DestructibleEntity
from Vehicle import Vehicle
from VehicleEffects import DamageFromShotDecoder
from constants import ATTACK_REASON
from constants import ITEM_DEFS_PATH, ARENA_GUI_TYPE, VEHICLE_CLASSES
from gui.battle_control import avatar_getter
from helpers import dependency
from items import _xml
from skeletons.gui.battle_session import IBattleSessionProvider
from vehicle_systems.tankStructure import TankPartIndexes

import xvm_battle.python.battle as battle
import xvm_main.python.config as config
import xvm_main.python.userprefs as userprefs
from xfw import *
from xfw_actionscript.python import *
from xvm_main.python.logger import *
from xvm_main.python.stats import _stat
from xvm_main.python.xvm import l10n

import parser_addon
from xvm.damageLog import HIT_EFFECT_CODES, keyLower, ATTACK_REASONS, RATINGS, VEHICLE_CLASSES_SHORT, ConfigCache

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
               ARENA_GUI_TYPE.EPIC_BATTLE: "epic_battle",
               ARENA_GUI_TYPE.EPIC_TRAINING: "epic_battle"}

HIT_LOG = 'hitLog/'
FORMAT_HISTORY = 'formatHistory'
GROUP_HITS_PLAYER = 'groupHitsByPlayer'
SCROLL_LOG = 'scrollLog'
ADD_TO_END = 'addToEnd'
LINES = 'lines'
MOVE_IN_BATTLE = 'moveInBattle'
HIT_LOG_ENABLED = HIT_LOG + 'enabled'
SHOW_SELF_DAMAGE = HIT_LOG + 'showSelfDamage'
SHOW_ALLY_DAMAGE = HIT_LOG + 'showAllyDamage'
ON_HIT_LOG = 'ON_HIT_LOG'

PILLBOX = 'pillbox'


class HIT_LOG_SECTIONS(object):
    LOG = HIT_LOG + 'log/'
    ALT_LOG = HIT_LOG + 'logAlt/'
    BACKGROUND = HIT_LOG + 'logBackground/'
    ALT_BACKGROUND = HIT_LOG + 'logAltBackground/'
    SECTIONS = (LOG, ALT_LOG, BACKGROUND, ALT_BACKGROUND)


_config = ConfigCache()


def parser(notParsedStr, macros):
    if notParsedStr and macros:
        return parser_addon.parser_addon(notParsedStr, macros)
    return notParsedStr


def readColor(section, value, xvalue=None):

    def getColor(c, v):
        for i in c:
            if i['value'] > v:
                color = i['color']
                return '#' + color[2:] if color[:2] == '0x' else color
        return None

    colors = _config.get('colors/' + section)
    if value is not None and colors is not None:
        return getColor(colors, value)
    elif xvalue is not None:
        colors_x = _config.get('colors/x')
        return getColor(colors_x, xvalue)


class Macros(dict):

    def __init__(self, *a, **kw):
        dict.__init__(self, *a, **kw)
        self.chooseRating = ''

    def setChooseRating(self):
        scale = config.networkServicesSettings.scale
        name = config.networkServicesSettings.rating
        r = '{}_{}'.format(scale, name)
        if r in RATINGS:
            self.chooseRating = RATINGS[r]['name']
        else:
            self.chooseRating = 'xwgr' if scale == 'xvm' else 'wgr'

    def setCommonMacros(self):
        value = g_dataHitLog.data
        xwn8 = value.get('xwn8', None)
        xwtr = value.get('xwtr', None)
        xeff = value.get('xeff', None)
        xwgr = value.get('xwgr', None)
        self['vehicle'] = value['shortUserString']
        self['name'] = value['name']
        self['clannb'] = value['clanAbbrev']
        self['clan'] = ''.join(['[', value['clanAbbrev'], ']']) if value['clanAbbrev'] else ''
        self['level'] = value['level']
        self['clanicon'] = value['clanicon']
        self['squad-num'] = value['squadnum']
        self['alive'] = 'al' if value['isAlive'] else None
        self['splash-hit'] = 'splash' if value['splashHit'] else None
        self['critical-hit'] = 'crit' if value['criticalHit'] else None
        self['wn8'] = value.get('wn8', None)
        self['xwn8'] = value.get('xwn8', None)
        self['wtr'] = value.get('wtr', None)
        self['xwtr'] = value.get('xwtr', None)
        self['eff'] = value.get('eff', None),
        self['xeff'] = value.get('xeff', None)
        self['wgr'] = value.get('wgr', None)
        self['xwgr'] = value.get('xwgr', None)
        self['xte'] = value.get('xte', None)
        self['r'] = '{{%s}}' % self.chooseRating
        self['xr'] = '{{%s}}' % self.chooseRating if self.chooseRating[0] == 'x' else '{{x%s}}' % self.chooseRating
        self['c:r'] = '{{c:%s}}' % self.chooseRating
        self['c:xr'] = '{{c:%s}}' % self.chooseRating if self.chooseRating[0] == 'x' else '{{c:x%s}}' % self.chooseRating
        self['c:wn8'] = readColor('wn8', value.get('wn8', None), xwn8)
        self['c:xwn8'] = readColor('x', xwn8)
        self['c:wtr'] = readColor('wtr', value.get('wtr', None), xwtr)
        self['c:xwtr'] = readColor('x', xwtr)
        self['c:eff'] = readColor('eff', value.get('eff', None), xeff)
        self['c:xeff'] = readColor('x', xeff)
        self['c:wgr'] = readColor('wgr', value.get('wgr', None), xwgr)
        self['c:xwgr'] = readColor('x', xwgr)
        self['c:xte'] = readColor('x', value.get('xte', None))
        self['diff-masses'] = value.get('diff-masses', None)
        self['nation'] = value.get('nation', None)
        self['blownup'] = 'blownup' if value['blownup'] else None
        self['vehiclename'] = value.get('attackerVehicleName', None)
        self['battletype-key'] = value.get('battletype-key', ARENA_GUI_TYPE.UNKNOWN)
        self['dmg-deviation'] = value['damageDeviation'] * 100 if value['damageDeviation'] is not None else None


class DataHitLog(object):

    guiSessionProvider = dependency.descriptor(IBattleSessionProvider)

    def __init__(self):
        self.player = None
        self.shells = {}
        self.macros = Macros()
        self.reset()
        self.ammo = None

    def reset(self):
        self.shellType = None
        self.playerVehicleID = None
        self.vehHealth = {}
        self.vehDead = []
        self.shells.clear()
        self.macros.clear()
        self.totalDamage = 0
        self.old_totalDamage = 0
        self.isVehicle = True
        self.entityNumber = None
        self.vehicleID = None
        self.intCD = None
        self.splashHit = False
        self.criticalHit = False
        self.compName = 'unknown'
        self.battletypeKey = 'unknown'
        self.data = {
            'damage': 0,
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
        self.macros.setCommonMacros()
        g_hitLogs.output()
        self.splashHit = False

    def setRatings(self):
        if (_stat.resp is not None) and (self.data['name'] in _stat.resp['players']):
            stats = _stat.resp['players'][self.data['name']]
            self.data['wn8'] = stats.get('wn8', None)
            self.data['xwn8'] = stats.get('xwn8', None)
            self.data['wtr'] = stats.get('wtr', None)
            self.data['xwtr'] = stats.get('xwtr', None)
            self.data['eff'] = stats.get('e', None)
            self.data['xeff'] = stats.get('xeff', None)
            self.data['wgr'] = stats.get('wgr', None)
            self.data['xwgr'] = stats.get('xwgr', None)
            self.data['xte'] = stats.get('v').get('xte', None)

    def getTeamDmg(self, vInfo):
        if self.isVehicle:
            if vInfo.team != self.player.team:
                return 'enemy-dmg'
            return 'player' if vInfo.player.name == self.player.name else 'ally-dmg'
        return self.data['teamDmg']

    def resetData(self):
        self.data['attackedVehicleType'] = 'not_vehicle'
        self.data['shortUserString'] = ''
        self.data['attackerVehicleName'] = ''
        self.data['level'] = None
        self.data['nation'] = None
        self.data['diff-masses'] = None
        self.data['name'] = ''
        self.data['clanAbbrev'] = ''
        self.data['clanicon'] = None
        self.data['squadnum'] = None
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
        self.data['costShell'] = 'unknown'
        self.data['shellKind'] = 'not_shell'
        self.data['damageDeviation'] = None

    def updateData(self):
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
                    if self.data['attackReasonID'] == 2:
                        self.data['diff-masses'] = (self.player.vehicleTypeDescriptor.physics['weight'] - vehicleType.physics['weight']) / 1000.0
                self.setRatings()
            elif not self.isVehicle:
                self.data['shortUserString'] = l10n(PILLBOX).format(self.entityNumber)
                self.compName = None
                self.criticalHit = None
            self.data['clanicon'] = _stat.getClanIcon(self.vehicleID)
            arenaDP = self.guiSessionProvider.getArenaDP()
            if arenaDP is not None:
                vInfo = arenaDP.getVehicleInfo(vID=self.vehicleID)
                self.data['squadnum'] = vInfo.squadIndex if vInfo.squadIndex != 0 else None
                self.data['teamDmg'] = self.getTeamDmg(vInfo)
        self.data['splashHit'] = self.splashHit
        self.data['criticalHit'] = self.criticalHit
        self.data['compName'] = self.compName
        self.data['battletype-key'] = self.battletypeKey
        self.updateLabels()

    def loaded(self):
        self.intCD = self.ammo.getCurrentShellCD()

    def setParametersShot(self):
        if self.intCD is not None:
            _shells = self.shells[self.intCD]
            self.data['shellKind'] = _shells['shellKind']
            self.data['costShell'] = _shells['costShell']

    def getDamageDeviation(self, newHealth):
        result = None
        if newHealth > 0 and self.intCD in self.shells:
            _shells = self.shells[self.intCD]
            result = (self.data['damage'] - _shells['shellDamage']) / float(_shells['shellDamage'])
            if (_shells['shellKind'] in ['high_explosive', 'armor_piercing_he']) and (result < -0.25):
                result = 0.0
        return result

    def onHealthChanged(self, vehicle, newHealth, attackerID, attackReasonID, isVehicle=True):
        self.resetData()
        self.isVehicle = isVehicle
        self.vehicleID = vehicle.id
        self.data['isAlive'] = vehicle.isAlive()
        if attackReasonID < 8:
            self.data['attackReasonID'] = attackReasonID
        elif attackReasonID in [9, 10, 13, 24]:
            self.data['attackReasonID'] = 24
        elif attackReasonID in [11, 14, 25]:
            self.data['attackReasonID'] = 25
        self.data['blownup'] = newHealth <= -5
        newHealth = max(0, newHealth)
        self.data['damage'] = (self.vehHealth[vehicle.id]['health'] - newHealth) if vehicle.id in self.vehHealth else (- newHealth)
        if self.data['attackReasonID'] != 0:
            self.criticalHit = False
            self.splashHit = False
            self.compName = None
        else:
            self.setParametersShot()
            self.data['damageDeviation'] = self.getDamageDeviation(newHealth)
        if not self.isVehicle:
            self.entityNumber = vehicle.destructibleEntityID
            self.data['teamDmg'] = 'ally-dmg' if vehicle.isPlayerTeam else 'enemy-dmg'
            self.data['shortUserString'] = l10n(PILLBOX).format(self.entityNumber)
        self.updateData()

    def showDamageFromShot(self, vehicle, attackerID, points, effectsIndex, damageFactor):
        maxComponentIdx = TankPartIndexes.ALL[-1]
        wheelsConfig = vehicle.appearance.typeDescriptor.chassis.generalWheelsAnimatorConfig
        if wheelsConfig:
            maxComponentIdx += wheelsConfig.getWheelsCount()
        maxHitEffectCode, decodedPoints, maxDamagedComponent = DamageFromShotDecoder.decodeHitPoints(points, vehicle.appearance.collisions, maxComponentIdx)
        if decodedPoints:
            compName = decodedPoints[0].componentName
            self.compName = compName if compName[0] != 'W' else 'wheel'
        else:
            self.compName = 'unknown'
        self.criticalHit = (maxHitEffectCode == 5)

    def onEnterWorld(self, vehicle):
        self.macros.setChooseRating()
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
        self.battletypeKey = BATTLE_TYPE.get(arena.guiType, ARENA_GUI_TYPE.UNKNOWN)

    def updateVehInfo(self, vehicle):
        if vehicle.id not in self.vehHealth:
            self.vehHealth[vehicle.id] = {}
        self.vehHealth[vehicle.id]['health'] = int(vehicle.health)
        self.vehHealth[vehicle.id]['maxHealth'] = int(vehicle.maxHealth) if isinstance(vehicle, DestructibleEntity) else vehicle.typeDescriptor.maxHealth
        if not vehicle.isAlive() and vehicle.id not in self.vehDead:
            self.vehDead.append(vehicle.id)


g_dataHitLog = DataHitLog()


class GroupHit(object):

    def __init__(self, section):
        self.section = section
        self.listLog = []
        self.numberTopLine = 0
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
        self.damageRatio = 0
        self.isGroup = False
        self.vehID = 0
        self.hitLogConfig = {}

    def mouse_wheel(self, isScrollUp):
        if isScrollUp:
            if self.numberTopLine < len(self.listLog):
                self.numberTopLine += 1
                return True
        else:
            if self.numberTopLine > 0:
                self.numberTopLine -= 1
                return True

    def removePlayer(self, vehID):
        if vehID in self.players:
            del self.players[vehID]

    def sumDmg(self):
        player = self.players[self.vehID]
        player['dmg-player'] += self.damage
        if self.attackReasonID not in player['dmg-kind-player']:
            player['dmg-kind-player'].append(self.attackReasonID)
        maxHealth = g_dataHitLog.vehHealth[self.vehID]['maxHealth'] if self.vehID in g_dataHitLog.vehHealth else 0
        player['dmg-ratio-player'] = (player['dmg-player'] * 100 // maxHealth) if maxHealth != 0 else 0
        player['dmg-ratio'] = (player['damage'] * 100 // maxHealth) if maxHealth != 0 else 0

    def readyConfig(self):
        if config.config_autoreload or not self.hitLogConfig:
            self.hitLogConfig = {
                'vehicleClass': keyLower(config.get(self.section + 'vtype')),
                'c_shell': keyLower(config.get(self.section + 'c:costShell')),
                'costShell': keyLower(config.get(self.section + 'costShell')),
                'c_dmg-kind': keyLower(config.get(self.section + 'c:dmg-kind')),
                'c_vehicleClass': keyLower(config.get(self.section + 'c:vtype')),
                'dmg-kind': keyLower(config.get(self.section + 'dmg-kind')),
                'dmg-kind-player': keyLower(config.get(self.section + 'dmg-kind-player')),
                'c_teamDmg': keyLower(config.get(self.section + 'c:team-dmg')),
                'teamDmg': keyLower(config.get(self.section + 'team-dmg')),
                'compNames': keyLower(config.get(self.section + 'comp-name')),
                'typeShell': keyLower(config.get(self.section + 'type-shell')),
                'c_typeShell': keyLower(config.get(self.section + 'c:type-shell'))
            }
        return self.hitLogConfig

    def setParametrsHitLog(self):
        self.countLines = len(self.listLog)
        self.attackReasonID = g_dataHitLog.data['attackReasonID']
        self.damage = g_dataHitLog.data['damage']
        self.damageRatio = g_dataHitLog.data['dmgRatio']
        self.vehID = g_dataHitLog.vehicleID
        try:
            macro = {'battletype-key': g_dataHitLog.battletypeKey}
            self.maxCountLines = int(parser(_config.get(self.S_LINES, 7), macro))
        except TypeError:
            self.maxCountLines = 7
        self.isAddToEnd = _config.get(self.S_ADD_TO_END, False)

    def udateMacros(self):
        data = g_dataHitLog.macros
        conf = self.readyConfig()
        player = self.players[self.vehID]
        value = g_dataHitLog.data

        data['c:team-dmg'] = conf['c_teamDmg'].get(value['teamDmg'], '#FFFFFF')
        data['team-dmg'] = conf['teamDmg'].get(value['teamDmg'], '')
        data['vtype'] = conf['vehicleClass'].get(VEHICLE_CLASSES_SHORT[value['attackedVehicleType']], '')
        data['c:costShell'] = conf['c_shell'].get(value['costShell'], None)
        data['costShell'] = conf['costShell'].get(value['costShell'], None)
        data['c:dmg-kind'] = conf['c_dmg-kind'][ATTACK_REASONS[value['attackReasonID']]]
        data['dmg-kind'] = conf['dmg-kind'].get(ATTACK_REASONS[value['attackReasonID']], 'reason: %s' % value['attackReasonID'])
        data['dmg-kind-player'] = ''.join([conf['dmg-kind-player'].get(ATTACK_REASONS[i], None) for i in player.get('dmg-kind-player', [])])
        data['c:vtype'] = conf['c_vehicleClass'].get(VEHICLE_CLASSES_SHORT[value['attackedVehicleType']], '#CCCCCC')
        data['comp-name'] = conf['compNames'].get(value['compName'], None)
        data['type-shell'] = conf['typeShell'].get(value['shellKind'], 'not_shell')
        data['type-shell-key'] = value['shellKind'] if value['shellKind'] is not None else 'not_shell'
        data['c:type-shell'] = conf['c_typeShell'].get(value['shellKind'], None)
        data['dmg'] = player['damage']
        data['dmg-ratio'] = player['dmg-ratio']
        data['n-player'] = player.get('n-player', 0)
        data['dmg-player'] = player.get('dmg-player', 0)
        data['dmg-ratio-player'] = player.get('dmg-ratio-player', 0)
        data['c:dmg-ratio-player'] = readColor('dmg_ratio_player', player.get('dmg-ratio-player', None))
        return data

    def reset(self):
        self.players.clear()
        self.listLog[:] = []
        self.numberTopLine = 0
        self.countLines = 0
        self.maxCountLines = None

    def addAttackReasonID(self):
        return {'damage': self.damage,
                'time': BigWorld.time(),
                'numberLine': self.countLines if self.isAddToEnd else -1}

    def addPlayer(self):
        return {'dmg-player': self.damage,
                'dmg-ratio-player': self.damageRatio,
                'n-player': 1,
                'damage': self.damage,
                'dmg-ratio': self.damageRatio,
                'numberLine': 0,
                'dmg-kind-player': [self.attackReasonID]}


class GroupHitByPlayer(GroupHit):
    APPEND = 0
    CHANGE = 1
    INSERT = 2

    def updateList(self, mode, numberLine=0):
        macros = self.udateMacros()
        formattedString = parser(_config.get(self.S_FORMAT_HISTORY, ''), macros)
        if mode == self.APPEND:
            self.listLog.append(formattedString)
        elif mode == self.INSERT:
            self.listLog.insert(0, formattedString)
        else:
            self.listLog[numberLine] = formattedString

    def updateGroupFireRamming(self, vehicle):
        if self.attackReasonID in [1, 2]:
            if self.attackReasonID in vehicle and ((BigWorld.time() - vehicle[self.attackReasonID]['time']) < 1.0):
                vehicle[self.attackReasonID]['damage'] += self.damage
                vehicle[self.attackReasonID]['time'] = BigWorld.time()
                vehicle['damage'] = vehicle[self.attackReasonID]['damage']
            else:
                vehicle[self.attackReasonID] = self.addAttackReasonID()
                vehicle['n-player'] += 1
                vehicle['damage'] = self.damage
        else:
            vehicle['n-player'] += 1
            vehicle['damage'] = self.damage

    def updatePlayers(self):
        vehicle = self.players[self.vehID]
        self.updateGroupFireRamming(vehicle)
        self.sumDmg()
        if self.isAddToEnd:
            if vehicle['numberLine'] == self.countLines - 1:
                self.updateList(self.CHANGE, vehicle['numberLine'])
            else:
                self.listLog.pop(vehicle['numberLine'])
                for v in self.players.itervalues():
                    if v['numberLine'] > vehicle['numberLine']:
                        v['numberLine'] -= 1
                vehicle['numberLine'] = self.countLines - 1
                self.updateList(self.APPEND)
        else:
            if vehicle['numberLine'] == 0:
                self.updateList(self.CHANGE)
            else:
                self.listLog.pop(vehicle['numberLine'])
                for v in self.players.itervalues():
                    if v['numberLine'] < vehicle['numberLine']:
                        v['numberLine'] += 1
                vehicle['numberLine'] = 0
                self.updateList(self.INSERT)

    def addPlayers(self):
        self.players[self.vehID] = self.addPlayer()
        vehicle = self.players[self.vehID]
        if self.attackReasonID in [1, 2]:
            vehicle[self.attackReasonID] = self.addAttackReasonID()
        if self.isAddToEnd:
            if self.countLines >= self.maxCountLines:
                self.numberTopLine += 1
            vehicle['numberLine'] = self.countLines
            self.updateList(self.APPEND)
        else:
            for v in self.players.itervalues():
                v['numberLine'] += 1
            vehicle['numberLine'] = 0
            self.updateList(self.INSERT)

    def getListLog(self):
        self.setParametrsHitLog()
        if self.maxCountLines <= 0:
            return []
        if self.vehID in self.players:
            self.updatePlayers()
        else:
            self.addPlayers()
        return self.listLog


class GroupHitByFireRamming(GroupHit):

    DIRECTION_UP = -1
    DIRECTION_DOWN = 1

    def shiftsLines(self, direction):
        for v in self.players.itervalues():
            if self.ATTACK_REASON_FIRE_ID in v:
                v[self.ATTACK_REASON_FIRE_ID]['numberLine'] += direction
            if self.ATTACK_REASON_RAM_ID in v:
                v[self.ATTACK_REASON_RAM_ID]['numberLine'] += direction

    def udateListLog(self):
        macros = self.udateMacros()
        formattedString = parser(_config.get(self.S_FORMAT_HISTORY, ''), macros)
        if self.isGroup:
            player = self.players[self.vehID]
            self.listLog[player[self.attackReasonID]['numberLine']] = formattedString
        elif self.isAddToEnd:
            if self.maxCountLines <= self.countLines:
                self.numberTopLine += 1
            self.listLog.append(formattedString)
        else:
            self.shiftsLines(self.DIRECTION_DOWN)
            self.listLog.insert(0, formattedString)

    def updateAttackReasonID(self):
        player = self.players[self.vehID]
        if self.attackReasonID in player and ((BigWorld.time() - player[self.attackReasonID].get('time', 0)) < 1.0):
            paramAttack = player[self.attackReasonID]
            self.isGroup = True
            paramAttack['damage'] += self.damage
            paramAttack['time'] = BigWorld.time()
            player['damage'] = paramAttack['damage']
        else:
            player[self.attackReasonID] = self.addAttackReasonID()

    def updatePlayer(self):
        self.isGroup = False
        if self.vehID in self.players:
            player = self.players[self.vehID]
            if self.attackReasonID in [1, 2]:
                self.updateAttackReasonID()
            if not self.isGroup:
                player['n-player'] += 1
                player['damage'] = self.damage
            self.sumDmg()
        else:
            self.players[self.vehID] = self.addPlayer()
            if self.attackReasonID in [1, 2]:
                self.players[self.vehID][self.attackReasonID] = self.addAttackReasonID()

    def getListLog(self):
        self.setParametrsHitLog()
        if self.maxCountLines <= 0:
            return []
        self.updatePlayer()
        self.udateListLog()
        return self.listLog


class HitLog(object):

    def __init__(self, section):
        self.section = section
        self.listLog = []
        self.groupHitByPlayer = GroupHitByPlayer(section)
        self.groupHitByFireRamming = GroupHitByFireRamming(section)
        self.S_GROUP_HITS_PLAYER = section + GROUP_HITS_PLAYER
        self.S_SCROLL_LOG = section + SCROLL_LOG
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
        self.listLog[:] = []
        self.groupHitByPlayer.reset()
        self.groupHitByFireRamming.reset()

    def mouse_wheel(self, isScrollUp):
        if not _config.get(self.S_SCROLL_LOG, True):
            return False
        if _config.get(self.S_GROUP_HITS_PLAYER, True):
            return self.groupHitByPlayer.mouse_wheel(isScrollUp)
        else:
            return self.groupHitByFireRamming.mouse_wheel(isScrollUp)

    def getLog(self):

        if _config.get(self.S_GROUP_HITS_PLAYER, True):
            numberTopLine = self.groupHitByPlayer.numberTopLine
            maxCountLines = self.groupHitByPlayer.maxCountLines
        else:
            numberTopLine = self.groupHitByFireRamming.numberTopLine
            maxCountLines = self.groupHitByFireRamming.maxCountLines
        return [] if maxCountLines is None else self.listLog[numberTopLine:maxCountLines + numberTopLine]

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
                self.x = parser(_config.get(self.S_X, self.DEFAULT_X), g_dataHitLog.macros)
                self.y = parser(_config.get(self.S_Y, self.DEFAULT_Y), g_dataHitLog.macros)

    def removePlayer(self, vehID):
        self.groupHitByPlayer.removePlayer(vehID)
        self.groupHitByFireRamming.removePlayer(vehID)

    def output(self):
        if _config.get(self.S_GROUP_HITS_PLAYER, True):
            self.listLog = self.groupHitByPlayer.getListLog()
        else:
            self.listLog = self.groupHitByFireRamming.getListLog()
        self.updatePosition()
        if self.callEvent:
            as_event(ON_HIT_LOG)


class HitLogs(object):

    def __init__(self):
        self.log = HitLog(HIT_LOG_SECTIONS.LOG)
        self.logAlt = HitLog(HIT_LOG_SECTIONS.ALT_LOG)
        self.logBg = HitLog(HIT_LOG_SECTIONS.BACKGROUND)
        self.logAltBg = HitLog(HIT_LOG_SECTIONS.ALT_BACKGROUND)
        self.logs = [self.log, self.logAlt, self.logBg, self.logAltBg]
        self.isDownAlt = False
        as_callback("hitLog_mouseWheel", self.mouse_wheel)

    def mouse_wheel(self, _data):
        isRefresh = False
        isScrollUp = _data['delta'] < 0
        for log in self.logs:
            isRefresh = log.mouse_wheel(isScrollUp) or isRefresh
        if isRefresh:
            as_event(ON_HIT_LOG)

    def setPosition(self, battleType):
        self.log.setPosition(battleType)

    def savePosition(self, battleType):
        self.log.savePosition(battleType)

    def removePlayerFromLogs(self, vehicleID):
        for log in self.logs:
            log.removePlayer(vehicleID)

    def reset(self):
        for log in self.logs:
            log.reset()

    def output(self):
        self.log.callEvent = self.logBg.callEvent = not self.isDownAlt
        self.logAlt.callEvent = self.logAltBg.callEvent = self.isDownAlt
        for log in self.logs:
            log.output()
            if not g_dataHitLog.data['isAlive']:
                log.removePlayer(g_dataHitLog.vehicleID)

    def getListLog(self):
        if self.isDownAlt:
            listLog = self.logAlt.getLog()
        else:
            listLog = self.log.getLog()
        return '\n'.join(listLog) if listLog else None

    def getListLogBg(self):
        if self.isDownAlt:
            listLog = self.logAltBg.getLog()
        else:
            listLog = self.logBg.getLog()
        return '\n'.join(listLog) if listLog else None


g_hitLogs = HitLogs()


@registerEvent(PlayerAvatar, '_PlayerAvatar__processVehicleAmmo')
def PlayerAvatar__processVehicleAmmo(self, vehicleID, compactDescr, quantity, quantityInClip, _, __):
    if battle.isBattleTypeSupported and _config.get(HIT_LOG_ENABLED, True):
        g_dataHitLog.loaded()


@registerEvent(DestructibleEntity, 'onEnterWorld')
def DestructibleEntity_onEnterWorld(self, prereqs):
    if self.isAlive():
        g_dataHitLog.updateVehInfo(self)


@registerEvent(DestructibleEntity, 'onHealthChanged')
def DestructibleEntity_onHealthChanged(self, newHealth, attackerID, attackReasonID, hitFlags):
    destructibleEntityComponent = BigWorld.player().arena.componentSystem.destructibleEntityComponent
    if _config.get(HIT_LOG_ENABLED, True) and battle.isBattleTypeSupported and (destructibleEntityComponent is not None):
        if (g_dataHitLog.playerVehicleID == attackerID) and (self.id not in g_dataHitLog.vehDead):
            if not self.isPlayerTeam or _config.get(SHOW_ALLY_DAMAGE, True):
                g_dataHitLog.onHealthChanged(self, newHealth, attackerID, attackReasonID, False)
        g_dataHitLog.updateVehInfo(self)


@registerEvent(Vehicle, 'showDamageFromShot')
def _Vehicle_showDamageFromShot(self, attackerID, points, effectsIndex, damageFactor):
    if battle.isBattleTypeSupported and (g_dataHitLog.playerVehicleID == attackerID) and self.isAlive() and _config.get(HIT_LOG_ENABLED, True):
        g_dataHitLog.showDamageFromShot(self, attackerID, points, effectsIndex, damageFactor)


@registerEvent(Vehicle, 'showDamageFromExplosion')
def _Vehicle_showDamageFromExplosion(self, attackerID, center, effectsIndex, damageFactor):
    if battle.isBattleTypeSupported and (g_dataHitLog.playerVehicleID == attackerID) and self.isAlive() and _config.get(HIT_LOG_ENABLED, True):
        g_dataHitLog.splashHit = True
        g_dataHitLog.criticalHit = False


@registerEvent(PlayerAvatar, '_PlayerAvatar__onArenaVehicleKilled')
def __onArenaVehicleKilled(self, targetID, attackerID, equipmentID, reason):
    if self.playerVehicleID != attackerID:
        g_hitLogs.removePlayerFromLogs(targetID)


@registerEvent(Vehicle, 'onEnterWorld')
def _Vehicle_onEnterWorld(self, prereqs):
    if _config.get(HIT_LOG_ENABLED, True) and battle.isBattleTypeSupported:
        if self.id in g_dataHitLog.vehDead:
            g_dataHitLog.vehDead.remove(self.id)
        if self.isPlayerVehicle:
            g_dataHitLog.onEnterWorld(self)
            g_hitLogs.setPosition(g_dataHitLog.battletypeKey)


@registerEvent(Vehicle, 'startVisual')
def _Vehicle_startVisual(self):
    if _config.get(HIT_LOG_ENABLED, True) and battle.isBattleTypeSupported:
        g_dataHitLog.updateVehInfo(self)


@registerEvent(Vehicle, 'onHealthChanged')
def _Vehicle_onHealthChanged(self, newHealth, attackerID, attackReasonID):
    if _config.get(HIT_LOG_ENABLED, True) and battle.isBattleTypeSupported:
        if (g_dataHitLog.playerVehicleID == attackerID) and (self.id not in g_dataHitLog.vehDead):
            attacked = g_dataHitLog.player.arena.vehicles.get(self.id)
            if (g_dataHitLog.player.team != attacked['team']) or _config.get(SHOW_ALLY_DAMAGE, True):
                if (self.id != attackerID) or _config.get(SHOW_SELF_DAMAGE, True):
                    g_dataHitLog.onHealthChanged(self, newHealth, attackerID, attackReasonID)
            else:
                if (self.id == attackerID) and _config.get(SHOW_SELF_DAMAGE, True):
                    g_dataHitLog.onHealthChanged(self, newHealth, attackerID, attackReasonID)
        g_dataHitLog.updateVehInfo(self)


@registerEvent(PlayerAvatar, '_PlayerAvatar__destroyGUI')
def PlayerAvatar__destroyGUI(self):
    if _config.get(HIT_LOG_ENABLED, True) and battle.isBattleTypeSupported:
        g_hitLogs.savePosition(g_dataHitLog.battletypeKey)
        g_hitLogs.reset()
        g_dataHitLog.reset()


@registerEvent(PlayerAvatar, 'handleKey')
def PlayerAvatar_handleKey(self, isDown, key, mods):
    if _config.get(HIT_LOG_ENABLED, True) and battle.isBattleTypeSupported:
        hotkey = _config.get('hotkeys/hitLogAltMode')
        if hotkey['enabled'] and (key == hotkey['keyCode']):
            if isDown:
                if hotkey['onHold']:
                    if not g_hitLogs.isDownAlt:
                        g_hitLogs.isDownAlt = True
                        as_event(ON_HIT_LOG)
                else:
                    g_hitLogs.isDownAlt = not g_hitLogs.isDownAlt
                    as_event(ON_HIT_LOG)
            else:
                if hotkey['onHold']:
                    if g_hitLogs.isDownAlt:
                        g_hitLogs.isDownAlt = False
                        as_event(ON_HIT_LOG)


def hLog():
    return g_hitLogs.getListLog()


def hLog_bg():
    return g_hitLogs.getListLogBg()


def hLog_x():
    return g_hitLogs.log.x


def hLog_y():
    return g_hitLogs.log.y

