import BigWorld
import Keys
import xvm_main.python.config as config
import xvm_main.python.stats as stats
import xvm_main.python.vehinfo as vehinfo
from items import vehicles, _xml
from Avatar import PlayerAvatar
from Vehicle import Vehicle
from xfw import *
from xvm_main.python.logger import *
from VehicleEffects import DamageFromShotDecoder
import ResMgr
from constants import ITEM_DEFS_PATH
import nations
from gui.shared.utils.TimeInterval import TimeInterval

ATTACK_REASONS = {
    0: 'shot',
    1: 'fire',
    2: 'ramming',
    3: 'world_collision',
    4: 'death_zone',
    5: 'drowning',
    6: 'gas_attack',
    7: 'overturn',
    24: 'art_attack',
    25: 'air_strike'
}

SHELL_TYPES_DEFAULT = {
    'ARMOR_PIERCING': 'ББ',
    'HIGH_EXPLOSIVE': 'ОФ',
    'ARMOR_PIERCING_CR': 'БП',
    'ARMOR_PIERCING_HE': 'ХФ',
    'HOLLOW_CHARGE': 'КС'
}

VEHICLE_CLASS = {
    'mediumtank': "<font face = 'xvm'>&#x3B;</font>",
    'lighttank': "<font face = 'xvm'>&#x3A;</font>",
    'heavytank': "<font face = 'xvm'>&#x3F;</font>",
    'at-spg': "<font face = 'xvm'>&#x2E;</font>",
    'spg': "<font face = 'xvm'>&#x2D;</font>"
}

COLOR_VEHICLE_CLASS = {
    'mediumtank': '#E9D600',
    'lighttank': '#0FD711',
    'heavytank': '#BBBBBB',
    'at-spg': '#2E9FFF',
    'spg': '#FF2120'
}

TYPE_HIT_DEFAULT = {
    'shot': "<font face = 'xvm'>&#x50;</font>",
    'fire': "<font face = 'xvm'>&#x51;</font>",
    'ramming': "<font face = 'xvm'>&#x52;</font>",
    'world_collision': "<font face = 'xvm'>&#x53;</font>",
    'death_zone': "DZ",
    'drowning': "Dr",
    'gas_attack': "GA",
    'overturn': "<font face = 'xvm'>&#x112;</font>",
    'art_attack': "<font face = 'xvm'>&#x110;</font>",
    'air_strike': "<font face = 'xvm'>&#x111;</font>"
}

COLOR_TYPE_HIT_DEFAULT = {
    'shot': '#E3E3E3',
    'fire': '#FF211C',
    'ramming': '#E3E3E3',
    'world_collision': '#E3E3E3',
    'death_zone': '#E3E3E3',
    'drowning': '#E3E3E3',
    'gas_attack': '#E3E3E3',
    'overturn': '#E3E3E3',
    'art_attack': '#E3E3E3',
    'air_strike': '#E3E3E3'
}

COLOR_TEAM_DAMAGE = '#34A0FF'

VEHICLE_CLASSES = frozenset(['mediumTank', 'lightTank', 'heavyTank', 'AT-SPG', 'SPG'])

HIT_EFFECT_CODES = {
    0: 'intermediate_ricochet',
    1: 'final_ricochet',
    2: 'armor_not_pierced',
    3: 'armor_pierced_no_damage',
    4: 'armor_pierced',
    5: 'critical_hit'
}

HIT_EFFECTS = {
    'intermediate_ricochet': 'рикошет',
    'final_ricochet': 'рикошет',
    'armor_not_pierced': 'не пробито',
    'armor_pierced_no_damage': 'без урона'
}

MACROS_NAME = ['number', 'critical-hit', 'vehicle', 'name', 'vtype', 'c:costShell', 'costShell', 'comp-name', 'clan',
               'dmg-kind', 'c:dmg-kind', 'c:vtype', 'type-shell', 'dmg', 'timer', 'c:team-dmg', 'c:hit-effects',
               'splash-hit', 'level', 'clanicon', 'clannb', 'marksOnGun']

TANK_PART_NAMES = {
    'turret': 'башня',
    'hull': 'корпус',
    'chassis': 'шасси',
    'gun': 'орудие',
    'none': ''
}

def keyLower(_dict):
    dict_return = {}
    for key, value in _dict.items():
        dict_return[key.lower()] = value
    return dict_return

def keyUpper(_dict):
    dict_return = {}
    for key, value in _dict.items():
        dict_return[key.upper()] = value
    return dict_return

class DamageLog(object):

    def __init__(self):
        self.msgNoAlt = []
        self.msgAlt = []
        self.isDownAlt = False
        self.lastHit = ''
        self.currentTime = ''
        self.isAlive = True
        self.oldHealth = None
        self.timerLastHit = None
        self.timerReloadAttacker = None
        self.macros = {'number': 0, 'critical-hit': '', 'vehicle': '', 'name': '', 'vtype': '', 'clan': '',
                       'c:costShell': '', 'dmg-kind': '', 'c:dmg-kind': '', 'c:vtype': '', 'type-shell': '',
                       'dmg': '', 'timer': 0, 'c:team-dmg': '', 'c:hit-effects': '', 'comp-name': '',
                       'splash-hit': '', 'level': '', 'clanicon': '', 'clannb': '', 'marksOnGun': ''}
        self.data = {'attackReasonID': 0, 'isGoldShell': False, 'isFire': False}
        self.config = {}

    def reset(self):
        self.msgNoAlt = []
        self.msgAlt = []
        self.isDownAlt = False
        self.lastHit = ''
        self.currentTime = ''
        self.isAlive = True
        self.oldHealth = None
        if (self.timerLastHit is not None) and (self.timerLastHit.isStarted):
            self.timerLastHit.stop()
        if (self.timerReloadAttacker is not None) and (self.timerReloadAttacker.isStarted):
            self.timerReloadAttacker.stop()
        self.macros = {'number': 0, 'critical-hit': '', 'vehicle': '', 'name': '', 'vtype': '', 'clan': '',
                       'c:costShell': '', 'dmg-kind': '', 'c:dmg-kind': '', 'c:vtype': '', 'type-shell': '',
                       'dmg': '', 'timer': 0, 'c:team-dmg': '', 'c:hit-effects': '', 'comp-name': '',
                       'splash-hit': '', 'level': '', 'clanicon': '', 'clannb': '', 'marksOnGun': ''}
        self.data = {'attackReasonID': 0, 'isGoldShell': False, 'isFire': False}
        self.config = {}

    def parser(self, strHTML):
        old_strHTML = ''
        # log('log = %s' % strHTML)
        while old_strHTML != strHTML:
            old_strHTML = strHTML
            for s in MACROS_NAME:
                strHTML = strHTML.replace('{{' + s + '}}', str(self.macros[s]))
        return strHTML

    def addStringLog(self):
        self.msgNoAlt.insert(0, self.parser(config.get('damageLog/log/formatHistory', '')))
        self.msgAlt.insert(0, self.parser(config.get('damageLog/log/formatHistoryAlt', '')))
        # log('log = %s' % self.msgNoAlt.insert(0, self.parser(config.get('damageLog/formatHistory', ''))))
        as_event('ON_HIT')

    def hideLastHit (self):
        self.lastHit = ''
        self.timerLastHit.stop()
        as_event('ON_LAST_HIT')

    def updateLastHit(self):
        timeDisplayLastHit = float(config.get('damageLog/lastHit/timeDisplayLastHit', 7))
        self.lastHit = self.parser(config.get('damageLog/lastHit/formatLastHit', ''))
        if self.lastHit:
            if (self.timerLastHit is not None) and (self.timerLastHit.isStarted):
                self.timerLastHit.stop()
            self.timerLastHit = TimeInterval(timeDisplayLastHit, self, 'hideLastHit')
            self.timerLastHit.start()
            as_event('ON_LAST_HIT')

    def afterTimerReload(self):
        self.currentTime = ''
        self.timerReloadAttacker.stop()
        as_event('ON_TIMER_RELOAD')

    def currentTimeReload(self):
        self.macros['timer'] = round(self.finishTime - BigWorld.serverTime(), 1)
        self.config['timeTextAfterReload'] = float(config.get('damageLog/timeReload/timeTextAfterReload', 3))
        if self.macros['timer'] > 0:
            self.currentTime = self.parser(config.get('damageLog/timeReload/formatTimer', ''))
        else:
            self.timerReloadAttacker.stop()
            if self.config['timeTextAfterReload'] > 0:
                self.timerReloadAttacker = TimeInterval(self.config['timeTextAfterReload'], self, 'afterTimerReload')
                self.currentTime = self.parser(config.get('damageLog/timeReload/formatTimerAfterReload', ''))
                self.timerReloadAttacker.start()
            else:
                self.currentTime = ''
        as_event('ON_TIMER_RELOAD')

    def timeReload(self):
        reload_orig = self.data['typeDescriptor'].gun['reloadTime']
        crew = 0.94 if self.data['typeDescriptor'].miscAttrs['crewLevelIncrease'] != 0 else 1
        if (self.data['typeDescriptor'].gun['clip'][0] == 1) and (self.data['typeDescriptor'].miscAttrs['gunReloadTimeFactor'] != 0):
            rammer = self.data['typeDescriptor'].miscAttrs['gunReloadTimeFactor']
        else:
            rammer = 1
        self.macros['timer'] = round(reload_orig * crew * rammer, 1)
        self.currentTime = self.parser(config.get('damageLog/timeReload/formatTimer', ''))
        as_event('ON_TIMER_RELOAD')
        self.finishTime = self.macros['timer'] + BigWorld.serverTime()
        if (self.timerReloadAttacker is not None) and (self.timerReloadAttacker.isStarted):
            self.timerReloadAttacker.stop()
        self.timerReloadAttacker = TimeInterval(0.1, self, 'currentTimeReload')
        self.timerReloadAttacker.start()

    def readyConfig(self, section):
        self.config['vehicleClass'] = keyLower(config.get(section + 'vtype', VEHICLE_CLASS))
        self.config['colorGoldShell'] = config.get(section + 'c:costShell/gold-shell', '#EEDE00')
        self.config['colorSilverShell'] = config.get(section + 'c:costShell/silver-shell', '#E3E3E3')
        self.config['goldShell'] = config.get(section + 'costShell/gold-shell', '')
        self.config['silverShell'] = config.get(section + 'costShell/silver-shell', '')
        self.config['color_type_hit'] = keyLower(config.get(section + 'c:dmg-kind', COLOR_TYPE_HIT_DEFAULT))
        self.config['colorVehicleClass'] = keyLower(config.get(section + 'c:vtype', {}))
        self.config['type_hit'] = keyLower(config.get(section + 'dmg-kind', TYPE_HIT_DEFAULT))
        if self.data['isEnemyAttacker']:
            self.config['c:team-dmg'] = config.get(section + 'c:team-dmg/no-team-dmg', '#E3E3E3')
        elif self.data['playerAttacker']:
            self.config['c:team-dmg'] = config.get(section + 'c:team-dmg/player', '#34A0FF')
        else:
            self.config['c:team-dmg'] = config.get(section + 'c:team-dmg/team-dmg', '#34A0FF')
        self.config['no-splash'] = config.get(section + 'splash-hit/no-splash', '')
        self.config['splash'] = config.get(section + 'splash-hit/splash', '')
        self.config['compNames'] = keyLower(config.get(section + 'comp-name', TANK_PART_NAMES))
        if self.data['maxHitEffectCode'] == 5:
            self.config['critical-hit'] = config.get(section + 'critical-hit/critical', '*')
        else:
            self.config['critical-hit'] = config.get(section + 'critical-hit/no-critical', '')
        self.config['showHitNoDamage'] = config.get(section + 'showHitNoDamage', True)
        self.config['hitEffect'] = keyLower(config.get(section + 'hit-effects', HIT_EFFECTS))
        self.config['colorHitEffect'] = keyLower(config.get(section + 'c:hit-effects'))
        self.config['type-shell'] = config.get(section + 'type-shell', SHELL_TYPES_DEFAULT)

    def setMacros(self):
        self.macros['c:team-dmg'] = self.config['c:team-dmg']
        self.macros['vtype'] = self.config['vehicleClass'].get(self.data['attackerVehicleType'], '')
        self.macros['c:costShell'] = self.config['colorGoldShell'] if self.data['isGoldShell'] else self.config['colorSilverShell']
        self.macros['costShell'] = self.config['goldShell'] if self.data['isGoldShell'] else self.config['silverShell']
        self.macros['c:dmg-kind'] = self.config['color_type_hit'].get(ATTACK_REASONS[self.data['attackReasonID']], '#E3E3E3')
        self.macros['dmg-kind'] = self.config['type_hit'].get(ATTACK_REASONS[self.data['attackReasonID']], 'reason: %s' % self.data['attackReasonID'])
        self.macros['c:vtype'] = self.config['colorVehicleClass'].get(self.data['attackerVehicleType'], '#E3E3E3')
        self.macros['splash-hit'] = self.config['splash'] if self.data['isSplash'] else self.config['no-splash']
        self.macros['comp-name'] = self.config['compNames'][self.data['compName']]
        self.macros['critical-hit'] = self.config['critical-hit']
        self.macros['type-shell'] = self.config['type-shell'][self.data['shellKind']]
        self.macros['c:hit-effects'] = self.config['colorHitEffect'].get(self.data['HIT_EFFECT_CODE'], '#E3E3E3')
        if not self.data['isDamage']:
            # if self.data['maxHitEffectCode'] < 4:
            self.macros['dmg'] = self.config['hitEffect'][self.data['HIT_EFFECT_CODE']]
                # self.macros['c:hit-effects'] = self.config['colorHitEffect'].get(self.data['HIT_EFFECT_CODE'], '#E3E3E3')
            # elif (self.data['maxHitEffectCode'] == 5):
            #     self.macros['dmg'] = self.config['hitEffect']['armor_pierced_no_damage']
            #     self.macros['c:hit-effects'] = self.config['colorHitEffect'].get('armor_pierced_no_damage', '#E3E3E3')
        else:
            self.macros['dmg'] = self.data['dmg']

    def updateMacros(self):
        player = BigWorld.player()
        attacker = player.arena.vehicles.get(self.data['attackerID'])
        entity = BigWorld.entity(self.data['attackerID'])
        # log('attacker = %s' % attacker['vehicleType'].level)
        # log('entity= %s' % (filter(lambda x: not x.startswith('_'), dir(entity))))
        self.data['isEnemyAttacker'] = attacker['team'] != player.team
        self.data['playerAttacker'] = attacker['name'] == player.name
        self.data['typeDescriptor'] = attacker['vehicleType']
        self.data['attackerVehicleType'] = list(attacker['vehicleType'].type.tags.intersection(VEHICLE_CLASSES))[0].lower()
        if entity is not None:
            self.data['marksOnGun'] = '_' + str(entity.publicInfo['marksOnGun'])
            log('entity = %s [%s]' % (entity.publicInfo['marksOnGun'], entity.publicInfo['name']))
        else:
            self.data['marksOnGun'] = ''

        self.config['marksOnGun'] = config.get('texts/marksOnGun')

        self.macros['number'] += 1
        self.macros['vehicle'] = self.data['typeDescriptor'].type.shortUserString
        self.macros['name'] = attacker['name']
        self.macros['clannb'] = attacker['clanAbbrev']
        self.macros['clan'] = '[' + attacker['clanAbbrev'] + ']' if attacker['clanAbbrev'] else ''
        self.macros['level'] = self.data['typeDescriptor'].level
        self.macros['clanicon'] = stats.getClanIcon(self.data['attackerID'])
        self.macros['marksOnGun'] = self.config['marksOnGun'][self.data['marksOnGun']] if self.data['marksOnGun'] else ''

        self.readyConfig('damageLog/log/')
        self.setMacros()
        if self.config['showHitNoDamage']:
            self.addStringLog()
        elif self.data['isDamage']:
            self.addStringLog()
        self.readyConfig('damageLog/lastHit/')
        self.setMacros()
        self.updateLastHit()
        if self.data['attackReasonID'] == 0:
            self.readyConfig('damageLog/timeReload/')
            self.setMacros()
            self.timeReload()
        return

    def typeShell(self, effectsIndex):
        player = BigWorld.player()
        attacker = player.arena.vehicles.get(self.data['attackerID'])
        self.data['isGoldShell'] = False
        for shell in attacker['vehicleType'].gun['shots']:
            if effectsIndex == shell['shell']['effectsIndex']:
                self.data['shellKind'] = str(shell['shell']['kind']).lower()
                xmlPath = ITEM_DEFS_PATH + 'vehicles/' + nations.NAMES[shell['shell']['id'][0]] + '/components/shells.xml'
                for name, subsection in ResMgr.openSection(xmlPath).items():
                    if name != 'icons':
                        xmlCtx = (None, xmlPath + '/' + name)
                        if _xml.readInt(xmlCtx, subsection, 'id', 0, 65535) == shell['shell']['id'][1]:
                            price = _xml.readPrice(xmlCtx, subsection, 'price')
                            self.data['isGoldShell'] = bool(price[1])
                            break
                ResMgr.purge(xmlPath, True)
                break
        return

    def showDamageFromShot(self, vehicle, attackerID, points, effectsIndex, damageFactor):
        if vehicle.isPlayerVehicle and self.isAlive:
            self.isAlive = vehicle.health > 0
            self.data['isSplash'] = False
            maxHitEffectCode, decodedPoints = DamageFromShotDecoder.decodeHitPoints(points, vehicle.typeDescriptor)
            self.data['compName'] = decodedPoints[0].componentName if decodedPoints else 'none'
            # log('decodedPoints= %s {%s} %s' % (decodedPoints, compName, maxHitEffectCode))
            self.data['maxHitEffectCode'] = maxHitEffectCode
            self.data['attackReasonID'] = 0
            self.data['attackerID'] = attackerID
            self.data['damageFactor'] = damageFactor
            self.typeShell(effectsIndex)
            if maxHitEffectCode < 4:
                self.data['isDamage'] = False
                self.data['HIT_EFFECT_CODE'] = HIT_EFFECT_CODES[maxHitEffectCode]
                self.updateMacros()
            elif (maxHitEffectCode == 5) and (damageFactor == 0):
                self.data['isDamage'] = False
                self.data['HIT_EFFECT_CODE'] = 'armor_pierced_no_damage'
                self.updateMacros()

    def showDamageFromExplosion(self, vehicle, attackerID, center, effectsIndex, damageFactor):
        if vehicle.isPlayerVehicle and self.isAlive:
            self.isAlive = vehicle.health > 0
            self.data['isSplash'] = True
            self.data['attackerID'] = attackerID
            self.typeShell(effectsIndex)
            if (damageFactor == 0):
                self.data['HIT_EFFECT_CODE'] = 'armor_pierced_no_damage'
                self.updateMacros()

    def onHealthChanged(self, vehicle, newHealth, attackerID, attackReasonID):
        # log('attackerID= %s' % attackerID)
        if vehicle.isPlayerVehicle:
            self.data['attackReasonID'] = attackReasonID
            self.data['isDamage'] = True
            if attackReasonID == 1:
                self.data['isFire'] = True
            self.data['attackerID'] = attackerID
            # log('PlayerID= %s' % attackerID)
            self.data['dmg'] = self.oldHealth - newHealth
            self.oldHealth = newHealth
            self.data['HIT_EFFECT_CODE'] = 'armor_pierced'
            self.updateMacros()


data = DamageLog()


@registerEvent(Vehicle, 'onHealthChanged')
def onHealthChanged(self, newHealth, attackerID, attackReasonID):
    data.onHealthChanged(self, newHealth, attackerID, attackReasonID)


@registerEvent(Vehicle, 'onEnterWorld')
def onEnterWorld(self, prereqs):
    if self.isPlayerVehicle:
        data.oldHealth = self.health


@registerEvent(Vehicle, 'showDamageFromShot')
def showDamageFromShot(self, attackerID, points, effectsIndex, damageFactor):
    data.showDamageFromShot(self, attackerID, points, effectsIndex, damageFactor)


@registerEvent(Vehicle, 'showDamageFromExplosion')
def showDamageFromExplosion(self, attackerID, center, effectsIndex, damageFactor):
    data.showDamageFromExplosion(self, attackerID, center, effectsIndex, damageFactor)


@registerEvent(PlayerAvatar, '_PlayerAvatar__destroyGUI')
def destroyGUI(self):
    data.reset()


@registerEvent(PlayerAvatar, 'handleKey')
def handleKey(self, isDown, key, mods):
    if (key == Keys.KEY_LALT) and isDown and not data.isDownAlt:
        data.isDownAlt = True
        as_event('ON_HIT')
    if not ((key == Keys.KEY_LALT) and isDown) and data.isDownAlt:
        data.isDownAlt = False
        as_event('ON_HIT')


def dLog():
    msg = data.msgNoAlt if not data.isDownAlt else data.msgAlt
    return '\n'.join(msg)


def lastHit():
    return '%s' % data.lastHit


def timerReload():
    return '%s' % data.currentTime
