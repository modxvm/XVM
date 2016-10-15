# Addons: "DamageLog"
# ktulho <http://www.koreanrandom.com/forum/user/17624-ktulho/>

import BigWorld
import Keys
import xvm_main.python.config as config
from xvm_main.python.stats import _stat
import xvm_main.python.stats as stats
import xvm_main.python.vehinfo as vehinfo
import xvm_main.python.vehinfo_wn8 as vehinfo_wn8
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

VEHICLE_CLASSES = frozenset(['mediumTank', 'lightTank', 'heavyTank', 'AT-SPG', 'SPG'])

HIT_EFFECT_CODES = {
    0: 'intermediate_ricochet',
    1: 'final_ricochet',
    2: 'armor_not_pierced',
    3: 'armor_pierced_no_damage',
    4: 'armor_pierced',
    5: 'critical_hit'
}

MACROS_NAME = ['number', 'critical-hit', 'vehicle', 'name', 'vtype', 'c:costShell', 'costShell', 'comp-name', 'clan',
               'dmg-kind', 'c:dmg-kind', 'c:vtype', 'type-shell', 'dmg', 'timer', 'c:team-dmg', 'c:hit-effects',
               'splash-hit', 'level', 'clanicon', 'clannb', 'marksOnGun', 'squad-num']

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
                       'splash-hit': '', 'level': '', 'clanicon': '', 'clannb': '', 'marksOnGun': '', 'squad-num': None}
        self.data = {'attackReasonID': 0, 'isGoldShell': False, 'isFire': False, 'n': 0, 'maxHitEffectCode': -1,
                     'compName': '', 'isSplash': False}
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
                       'splash-hit': '', 'level': '', 'clanicon': '', 'clannb': '', 'marksOnGun': '', 'squad-num': None}
        self.data = {'attackReasonID': 0, 'isGoldShell': False, 'isFire': False, 'n': 0, 'maxHitEffectCode': -1,
                     'compName': '', 'isSplash': False}
        self.config = {}

    def parser(self, strHTML):
        old_strHTML = ''
        while old_strHTML != strHTML:
            old_strHTML = strHTML
            for s in MACROS_NAME:
                strHTML = strHTML.replace('{{' + s + '}}', str(self.macros[s]))
        return strHTML

    def addStringLog(self):
        self.msgNoAlt.insert(0, self.parser(config.get('damageLog/log/formatHistory')))
        self.msgAlt.insert(0, self.parser(config.get('damageLog/log/formatHistoryAlt')))
        as_event('ON_HIT')

    def hideLastHit (self):
        self.lastHit = ''
        self.timerLastHit.stop()
        as_event('ON_LAST_HIT')

    def updateLastHit(self):
        timeDisplayLastHit = float(config.get('damageLog/lastHit/timeDisplayLastHit'))
        self.lastHit = self.parser(config.get('damageLog/lastHit/formatLastHit'))
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
        self.config['timeTextAfterReload'] = float(config.get('damageLog/timeReload/timeTextAfterReload'))
        if self.macros['timer'] > 0:
            self.currentTime = self.parser(config.get('damageLog/timeReload/formatTimer'))
        else:
            self.timerReloadAttacker.stop()
            if self.config['timeTextAfterReload'] > 0:
                self.timerReloadAttacker = TimeInterval(self.config['timeTextAfterReload'], self, 'afterTimerReload')
                self.currentTime = self.parser(config.get('damageLog/timeReload/formatTimerAfterReload'))
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
        self.currentTime = self.parser(config.get('damageLog/timeReload/formatTimer'))
        as_event('ON_TIMER_RELOAD')
        self.finishTime = self.macros['timer'] + BigWorld.serverTime()
        if (self.timerReloadAttacker is not None) and (self.timerReloadAttacker.isStarted):
            self.timerReloadAttacker.stop()
        self.timerReloadAttacker = TimeInterval(0.1, self, 'currentTimeReload')
        self.timerReloadAttacker.start()

    def readyConfig(self, section):
        self.config['vehicleClass'] = keyLower(config.get(section + 'vtype'))
        self.config['colorGoldShell'] = config.get(section + 'c:costShell/gold-shell')
        self.config['colorSilverShell'] = config.get(section + 'c:costShell/silver-shell')
        self.config['goldShell'] = config.get(section + 'costShell/gold-shell')
        self.config['silverShell'] = config.get(section + 'costShell/silver-shell')
        self.config['color_type_hit'] = keyLower(config.get(section + 'c:dmg-kind'))
        self.config['colorVehicleClass'] = keyLower(config.get(section + 'c:vtype'))
        self.config['type_hit'] = keyLower(config.get(section + 'dmg-kind'))
        if self.data['isEnemyAttacker']:
            self.config['c:team-dmg'] = config.get(section + 'c:team-dmg/no-team-dmg')
        elif self.data['playerAttacker']:
            self.config['c:team-dmg'] = config.get(section + 'c:team-dmg/player')
        else:
            self.config['c:team-dmg'] = config.get(section + 'c:team-dmg/team-dmg')
        self.config['no-splash'] = config.get(section + 'splash-hit/no-splash')
        self.config['splash'] = config.get(section + 'splash-hit/splash')
        self.config['compNames'] = keyLower(config.get(section + 'comp-name'))
        if self.data['maxHitEffectCode'] == 5:
            self.config['critical-hit'] = config.get(section + 'critical-hit/critical')
        else:
            self.config['critical-hit'] = config.get(section + 'critical-hit/no-critical')
        self.config['showHitNoDamage'] = config.get(section + 'showHitNoDamage')
        self.config['hitEffect'] = keyLower(config.get(section + 'hit-effects'))
        self.config['colorHitEffect'] = keyLower(config.get(section + 'c:hit-effects'))
        self.config['type-shell'] = config.get(section + 'type-shell')

    def setMacros(self):
        self.macros['c:team-dmg'] = self.config['c:team-dmg']
        self.macros['vtype'] = self.config['vehicleClass'].get(self.data['attackerVehicleType']) if self.data['attackerVehicleType'] else ''
        self.macros['c:costShell'] = self.config['colorGoldShell'] if self.data['isGoldShell'] else self.config['colorSilverShell']
        self.macros['costShell'] = self.config['goldShell'] if self.data['isGoldShell'] else self.config['silverShell']
        self.macros['c:dmg-kind'] = self.config['color_type_hit'].get(ATTACK_REASONS[self.data['attackReasonID']])
        self.macros['dmg-kind'] = self.config['type_hit'].get(ATTACK_REASONS[self.data['attackReasonID']], 'reason: %s' % self.data['attackReasonID'])
        self.macros['c:vtype'] = self.config['colorVehicleClass'].get(self.data['attackerVehicleType'])
        self.macros['splash-hit'] = self.config['splash'] if self.data['isSplash'] else self.config['no-splash']
        self.macros['comp-name'] = self.config['compNames'][self.data['compName']] if self.data['compName'] else ''
        self.macros['critical-hit'] = self.config['critical-hit']
        self.macros['type-shell'] = self.config['type-shell'][self.data['shellKind']] if self.data['shellKind'] else ''
        self.macros['c:hit-effects'] = self.config['colorHitEffect'].get(self.data['HIT_EFFECT_CODE'])
        if not self.data['isDamage']:
            self.macros['dmg'] = self.config['hitEffect'][self.data['HIT_EFFECT_CODE']]
        else:
            self.macros['dmg'] = self.data['dmg']

    def updateMacros(self):
        player = BigWorld.player()
        self.data['n'] += 1
        if self.data['attackerID'] != 0:
            attacker = player.arena.vehicles.get(self.data['attackerID'])
            entity = BigWorld.entity(self.data['attackerID'])
            statXVM = _stat.players.get(self.data['attackerID'])
            # log('statXVM= %s' % [arg for arg in dir(statXVM) if not arg.startswith('vn')])
            # log('statXVM= %s' % (statXVM))
            self.data['isEnemyAttacker'] = attacker['team'] != player.team
            self.data['playerAttacker'] = attacker['name'] == player.name
            self.data['typeDescriptor'] = attacker['vehicleType']
            self.data['vehCD'] = attacker['vehicleType'].type.compactDescr
            self.data['attackerVehicleType'] = list(attacker['vehicleType'].type.tags.intersection(VEHICLE_CLASSES))[0].lower()
            self.data['shortUserString'] = self.data['typeDescriptor'].type.shortUserString
            self.data['name'] = attacker['name']
            self.data['clanAbbrev'] = attacker['clanAbbrev']
            self.data['level'] = self.data['typeDescriptor'].level
            self.data['clanicon'] = _stat.getClanIcon(self.data['attackerID'])
            if (statXVM is not None) and (statXVM.squadnum > 0):
                self.data['squadnum'] = statXVM.squadnum
            else:
                self.data['squadnum'] = ''
            if entity is not None:
                self.data['marksOnGun'] = '_' + str(entity.publicInfo['marksOnGun'])
            else:
                self.data['marksOnGun'] = ''
        else:
            self.data['isEnemyAttacker'] = True
            self.data['playerAttacker'] = False
            self.data['typeDescriptor'] = None
            self.data['vehCD'] = None
            self.data['attackerVehicleType'] = ''
            self.data['shortUserString'] = ''
            self.data['name'] = ''
            self.data['clanAbbrev'] = ''
            self.data['level'] = ''
            self.data['clanicon'] = ''
            self.data['squadnum'] = ''
            self.data['marksOnGun'] = ''

        self.config['marksOnGun'] = config.get('texts/marksOnGun')

        self.macros['number'] = '{:0>2}'.format(self.data['n'])
        self.macros['vehicle'] = self.data['shortUserString']
        self.macros['name'] = self.data['name']
        self.macros['clannb'] = self.data['clanAbbrev']
        self.macros['clan'] = '[' + self.data['clanAbbrev'] + ']' if self.data['clanAbbrev'] else ''
        self.macros['level'] = self.data['level']
        self.macros['clanicon'] = self.data.get('clanicon', '')
        self.macros['marksOnGun'] = self.config['marksOnGun'][self.data['marksOnGun']] if self.data['marksOnGun'] else ''
        self.macros['squad-num'] = self.data['squadnum']
        self.readyConfig('damageLog/log/')
        self.setMacros()
        if self.config['showHitNoDamage']:
            self.addStringLog()
        elif self.data['isDamage']:
            self.addStringLog()
        self.readyConfig('damageLog/lastHit/')
        self.setMacros()
        self.updateLastHit()
        if (self.data['attackReasonID'] == 0) and (self.data['attackerID'] != 0):
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
            self.data['isDamage'] = damageFactor > 0
            maxHitEffectCode, decodedPoints = DamageFromShotDecoder.decodeHitPoints(points, vehicle.typeDescriptor)
            self.data['compName'] = decodedPoints[0].componentName if decodedPoints else ''
            self.data['maxHitEffectCode'] = maxHitEffectCode
            self.data['attackReasonID'] = 0
            self.data['attackerID'] = attackerID
            self.data['damageFactor'] = damageFactor
            if attackerID != 0:
                self.typeShell(effectsIndex)
            else:
                self.data['isGoldShell'] = False
                self.data['shellKind'] = ''
            if (maxHitEffectCode < 4):
                self.data['isDamage'] = False
                self.data['HIT_EFFECT_CODE'] = HIT_EFFECT_CODES[maxHitEffectCode]
                self.updateMacros()
            elif (maxHitEffectCode == 5) and (damageFactor == 0):
                self.data['isDamage'] = False
                self.data['HIT_EFFECT_CODE'] = 'armor_pierced_no_damage'
                self.updateMacros()
            if (effectsIndex == 24) or (effectsIndex == 25):
                self.data['attackReasonID'] = effectsIndex

    def showDamageFromExplosion(self, vehicle, attackerID, center, effectsIndex, damageFactor):
        if vehicle.isPlayerVehicle and self.isAlive:
            self.isAlive = vehicle.health > 0
            self.data['isSplash'] = True
            self.data['isDamage'] = damageFactor > 0
            self.data['attackerID'] = attackerID
            if attackerID != 0:
                self.typeShell(effectsIndex)
            else:
                self.data['isGoldShell'] = False
                self.data['shellKind'] = ''
            if (effectsIndex == 24) or (effectsIndex == 25):
                self.data['attackReasonID'] = effectsIndex
            if (damageFactor == 0):
                self.data['HIT_EFFECT_CODE'] = 'armor_pierced_no_damage'
                self.updateMacros()

    def onHealthChanged(self, vehicle, newHealth, attackerID, attackReasonID):
        if vehicle.isPlayerVehicle:
            if (attackReasonID != 0) or (self.data['attackReasonID'] != 24 and self.data['attackReasonID'] != 25):
                self.data['attackReasonID'] = attackReasonID
            self.data['isDamage'] = True
            if attackReasonID == 1:
                self.data['isFire'] = True
            self.data['attackerID'] = attackerID
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
