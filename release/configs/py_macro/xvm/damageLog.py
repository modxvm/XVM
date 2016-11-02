# Addons: "DamageLog"
# ktulho <http://www.koreanrandom.com/forum/user/17624-ktulho/>

import BigWorld
import Keys
import copy
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
from gui.Scaleform.daapi.view.battle.shared.damage_panel import DamagePanel
from gui.Scaleform.daapi.view.battle.shared.damage_log_panel import DamageLogPanel
from items import vehicles


on_fire = 0
isDownAlt = False


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
    None: 'unknown',
    0: 'intermediate_ricochet',
    1: 'final_ricochet',
    2: 'armor_not_pierced',
    3: 'armor_pierced_no_damage',
    4: 'armor_pierced',
    5: 'critical_hit'
}


MACROS_NAME = ['number', 'critical-hit', 'vehicle', 'name', 'vtype', 'c:costShell', 'costShell', 'comp-name', 'clan',
               'dmg-kind', 'c:dmg-kind', 'c:vtype', 'type-shell', 'dmg', 'timer', 'c:team-dmg', 'c:hit-effects',
               'level', 'clanicon', 'clannb', 'marksOnGun', 'squad-num', 'dmg-ratio', 'hit-effects', 'c:type-shell',
               'splash-hit', 'team-dmg']


def keyLower(_dict):
    if _dict is not None:
        dict_return = {}
        for key, value in _dict.items():
            dict_return[key.lower()] = value
        return dict_return
    else:
        return None


def keyUpper(_dict):
    if _dict is not None:
        dict_return = {}
        for key, value in _dict.items():
            dict_return[key.upper()] = value
        return dict_return
    else:
        return None


def readyConfig(section):
    res = {'vehicleClass': keyLower(config.get(section + 'vtype')),
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
           # 'showHitNoDamage': config.get(section + 'showHitNoDamage'),
           'hitEffect': keyLower(config.get(section + 'hit-effects')),
           'c_HitEffect': keyLower(config.get(section + 'c:hit-effects')),
           'typeShell': keyLower(config.get(section + 'type-shell')),
           'c_typeShell': keyLower(config.get(section + 'c:type-shell'))
           }
    return res


def parser(strHTML, macroes):
    old_strHTML = ''
    while old_strHTML != strHTML:
        old_strHTML = strHTML
        for s in MACROS_NAME:
            if s in macroes:
                strHTML = strHTML.replace('{{' + s + '}}', str(macroes[s]))
    return strHTML


class Data(object):

    def __init__(self):
        self.data = {'isAlive': True,
                     'isDamage': False,
                     'attackReasonID': 0,
                     'attackerID': 0,
                     'compName': 'unknown',
                     'splashHit': 'no-splash',
                     'criticalHit': False,
                     'hitEffect': None,
                     'damage': 0,
                     'dmgRatio': 0,
                     'oldHealth': 0,
                     'maxHealth': 0,
                     'costShell': 'unknown',
                     'shellKind': 'not_shell',
                     'teamDmg': 'unknown',
                     'attackerVehicleType': '',
                     'shortUserString': '',
                     'name': '',
                     'clanAbbrev': '',
                     'level': 1,
                     'clanicon': '',
                     'squadnum': 0,
                     'fireStage': -1,
                     'isInFire': False,
                     'isBeginFire': False,
                     'number': None,
                     'timer': 0
                     }

    def reset(self):
        self.__init__()

    def updateData(self):
        player = BigWorld.player()
        self.data['dmgRatio'] = self.data['damage'] * 100 // self.data['maxHealth']
        if self.data['attackerID']:
            attacker = player.arena.vehicles.get(self.data['attackerID'])
            entity = BigWorld.entity(self.data['attackerID'])
            statXVM = _stat.players.get(self.data['attackerID'], None)
            self.data['teamDmg'] = 'unknown'
            if attacker['team'] != player.team:
                self.data['teamDmg'] = 'enemy-dmg'
            elif attacker['name'] == player.name:
                self.data['teamDmg'] = 'player'
            else:
                self.data['teamDmg'] = 'ally-dmg'
            if attacker['vehicleType']:
                self.data['attackerVehicleType'] = list(attacker['vehicleType'].type.tags.intersection(VEHICLE_CLASSES))[0].lower()
                self.data['shortUserString'] = attacker['vehicleType'].type.shortUserString
                self.data['level'] = attacker['vehicleType'].level
            else:
                self.data['attackerVehicleType'] = ''
                self.data['shortUserString'] = ''
                self.data['level'] = ''
            self.data['name'] = attacker['name']
            self.data['clanAbbrev'] = attacker['clanAbbrev']
            self.data['clanicon'] = _stat.getClanIcon(self.data['attackerID'])
            if statXVM is not None:
                self.data['squadnum'] = statXVM.squadnum
            self.data['marksOnGun'] = '_' + str(entity.publicInfo['marksOnGun']) if entity is not None else ''
        else:
            self.data['teamDmg'] = 'unknown'
            self.data['attackerVehicleType'] = ''
            self.data['shortUserString'] = ''
            self.data['name'] = ''
            self.data['clanAbbrev'] = ''
            self.data['level'] = ''
            self.data['clanicon'] = ''
            self.data['squadnum'] = ''
            self.data['marksOnGun'] = ''

    def typeShell(self, effectsIndex):
        self.data['costShell'] = 'unknown'
        self.data['shellKind'] = 'not_shell'
        if (self.data['attackerID'] == 0) or (self.data['attackReasonID'] != 0):
            return
        player = BigWorld.player()
        attacker = player.arena.vehicles.get(self.data['attackerID'])
        if not attacker['vehicleType']:
            return
        for shell in attacker['vehicleType'].gun['shots']:
            if effectsIndex == shell['shell']['effectsIndex']:
                self.data['shellKind'] = str(shell['shell']['kind']).lower()
                xmlPath = ITEM_DEFS_PATH + 'vehicles/' + nations.NAMES[shell['shell']['id'][0]] + '/components/shells.xml'
                for name, subsection in ResMgr.openSection(xmlPath).items():
                    if name != 'icons':
                        xmlCtx = (None, xmlPath + '/' + name)
                        if _xml.readInt(xmlCtx, subsection, 'id', 0, 65535) == shell['shell']['id'][1]:
                            price = _xml.readPrice(xmlCtx, subsection, 'price')
                            self.data['costShell'] = 'gold-shell' if price[1] else 'silver-shell'
                            break
                ResMgr.purge(xmlPath, True)
                break

    def timeReload(self, attackerID):
        if self.data['attackerID']:
            player = BigWorld.player()
            attacker = player.arena.vehicles.get(attackerID)
            if attacker['vehicleType']:
                reload_orig = attacker['vehicleType'].gun['reloadTime']
                crew = 0.94 if attacker['vehicleType'].miscAttrs['crewLevelIncrease'] != 0 else 1
                if (attacker['vehicleType'].gun['clip'][0] == 1) and (attacker['vehicleType'].miscAttrs['gunReloadTimeFactor'] != 0):
                    rammer = attacker['vehicleType'].miscAttrs['gunReloadTimeFactor']
                else:
                    rammer = 1
                return reload_orig * crew * rammer
            else:
                return 0
        else:
            return 0

    def hitShell(self, attackerID, effectsIndex, damageFactor):
        self.data['isDamage'] = damageFactor > 0
        if self.data['fireStage'] == 2:
            self.data['fireStage'] = -1
        self.data['attackerID'] = attackerID
        self.data['attackReasonID'] = effectsIndex if effectsIndex in [24, 25] else 0
        self.data['timer'] = self.timeReload(attackerID)
        self.typeShell(effectsIndex)
        if damageFactor:
            self.data['hitEffect'] = HIT_EFFECT_CODES[4]
        else:
            self.data['damage'] = 0
            self.updateData()
            self.updateLabels()
            as_event('ON_HIT')

    def updateLabels(self):
        _logAlt.output()
        _log.output()
        _lastHit.output()
        _timerReload.output()

    def showDamageFromShot(self, vehicle, attackerID, points, effectsIndex, damageFactor):
        if vehicle.isPlayerVehicle and self.data['isAlive']:
            self.data['isAlive'] = vehicle.health > 0
            maxHitEffectCode, decodedPoints = DamageFromShotDecoder.decodeHitPoints(points, vehicle.typeDescriptor)
            self.data['compName'] = decodedPoints[0].componentName if decodedPoints else 'unknown'
            self.data['splashHit'] = 'no-splash'
            self.data['criticalHit'] = (maxHitEffectCode == 5)
            if damageFactor == 0:
                self.data['hitEffect'] = HIT_EFFECT_CODES[min(3, maxHitEffectCode)]
            self.hitShell(attackerID, effectsIndex, damageFactor)

    def showDamageFromExplosion(self, vehicle, attackerID, center, effectsIndex, damageFactor):
        if vehicle.isPlayerVehicle and self.data['isAlive']:
            self.data['isAlive'] = vehicle.health > 0
            self.data['splashHit'] = 'splash'
            self.data['criticalHit'] = False
            if damageFactor == 0:
                self.data['hitEffect'] = HIT_EFFECT_CODES[3]
            self.hitShell(attackerID, effectsIndex, damageFactor)

    def onHealthChanged(self, vehicle, newHealth, attackerID, attackReasonID):
        if vehicle.isPlayerVehicle:
            if (attackReasonID == 1) and (self.data['fireStage'] < 0) and self.data['isBeginFire']:
                self.data['fireStage'] = 0
            elif (attackReasonID == 1) and (self.data['fireStage'] == 0) and self.data['isInFire']:
                self.data['fireStage'] = 1
            elif (self.data['fireStage'] in [0, 1]) and not self.data['isInFire']:
                self.data['fireStage'] = 2
            elif self.data['fireStage'] == 2:
                self.data['fireStage'] = -1
            if self.data['attackReasonID'] not in [24, 25]:
                self.data['attackReasonID'] = attackReasonID
            self.data['isDamage'] = True
            self.data['hitEffect'] = HIT_EFFECT_CODES[4]
            if self.data['attackReasonID'] != 0:
                self.data['costShell'] = 'unknown'
                self.data['shellKind'] = 'not_shell'
                self.data['timer'] = 0
            self.data['attackerID'] = attackerID
            self.data['damage'] = self.data['oldHealth'] - max(0, newHealth)
            self.data['oldHealth'] = newHealth
            self.updateData()
            self.updateLabels()
            self.data['isBeginFire'] = self.data['isInFire']
            as_event('ON_HIT')


data = Data()


def getValueMacroes(section, value):
    conf = readyConfig(section)#.copy()
    macro = {'c:team-dmg': conf['c_teamDmg'].get(value['teamDmg']),
             'team-dmg': conf['teamDmg'].get(value['teamDmg'], ''),
             'vtype': conf['vehicleClass'].get(value['attackerVehicleType'], 'not_vehicle'),
             'c:costShell': conf['c_Shell'].get(value['costShell']),
             'costShell': conf['costShell'].get(value['costShell'], 'unknown'),
             'c:dmg-kind': conf['c_typeHit'].get(ATTACK_REASONS[value['attackReasonID']]),
             'dmg-kind': conf['typeHit'].get(ATTACK_REASONS[value['attackReasonID']], 'reason: %s' % value['attackReasonID']),
             'c:vtype': conf['c_VehicleClass'].get(value['attackerVehicleType'], 'not_vehicle'),
             'comp-name': conf['compNames'].get(value['compName'], 'unknown'),
             'splash-hit': conf['splashHit'].get(value['splashHit'], 'unknown'),
             'critical-hit': conf['criticalHit'].get('critical') if value['criticalHit'] else conf['criticalHit'].get('no-critical'),
             'type-shell': conf['typeShell'].get(value['shellKind'], 'unknown'),
             'c:type-shell': conf['c_typeShell'].get(value['shellKind']),
             'c:hit-effects': conf['c_HitEffect'].get(value['hitEffect']),
             'hit-effects': conf['hitEffect'].get(value['hitEffect'], 'unknown'),
             'number': '{:0>2}'.format(value['number']) if value['number'] is not None else None,
             'dmg': value['damage'],
             'dmg-ratio': value['dmgRatio'],
             'vehicle': value['shortUserString'],
             'name': value['name'],
             'clannb': value['clanAbbrev'],
             'clan': ''.join(['[', value['clanAbbrev'], ']']) if value['clanAbbrev'] else '',
             'level': value['level'],
             'clanicon': value['clanicon'],
             'squad-num': value['squadnum'],
             'timer': round(value['timer'], 1)
             }
    return macro


class Log(object):

    def __init__(self, section):
        self.listLog = []
        self.section = section
        self.sumFireDmg = 0
        self.dataLogFire = None
        self.numberLine = 0
        self.dictVehicle = {}

    def reset(self):
        self.__init__(self.section)

    def addLine(self, attackerID, attackReasonID):
        self.dataLog['number'] = '{:>2}'.format(len(self.listLog) + 1)
        macroes = getValueMacroes(self.section, self.dataLog)
        self.listLog.insert(0, parser(config.get(self.section + 'formatHistory'), macroes))
        self.numberLine += 1
        for attacker in self.dictVehicle:
            for attack in self.dictVehicle[attacker]:
                if (attacker != attackerID) and (attack != attackReasonID):
                    self.dictVehicle[attacker][attack]['numberLine'] += 1

    def output(self):
        if (data.data['attackReasonID'] == 1) and config.get(self.section + 'groupDamagesFromFire'):
            if data.data['fireStage'] == 0:
                self.dataLogFire = data.data.copy()
                self.numberLine = 0
                self.dataLogFire['number'] = '{:>2}'.format(len(self.listLog) + 1)
                macroes = getValueMacroes(self.section, self.dataLogFire)
                self.listLog.insert(0, parser(config.get(self.section + 'formatHistory'), macroes))
                # self.addLine(None, None)
            elif data.data['fireStage'] in [1, 2]:
                self.dataLogFire['damage'] += data.data['damage']
                self.dataLogFire['dmgRatio'] = self.dataLogFire['damage'] * 100 // data.data['maxHealth']
                macroes = getValueMacroes(self.section, self.dataLogFire)
                self.listLog[self.numberLine] = parser(config.get(self.section + 'formatHistory'), macroes)
        elif (data.data['attackReasonID'] in [2, 3]) and config.get(self.section + 'groupDamagesFromRamming_WorldCollision'):
            self.dataLog = data.data.copy()
            attackerID = data.data['attackerID']
            attackReasonID = data.data['attackReasonID']
            if attackerID in self.dictVehicle:
                if (attackReasonID in self.dictVehicle[attackerID] and
                   ('time' in self.dictVehicle[attackerID][attackReasonID]) and
                   ('damage' in self.dictVehicle[attackerID][attackReasonID]) and
                   ((BigWorld.serverTime() - self.dictVehicle[attackerID][attackReasonID]['time']) < 1)):
                    self.dictVehicle[attackerID][attackReasonID]['time'] = BigWorld.serverTime()
                    self.dictVehicle[attackerID][attackReasonID]['damage'] += data.data['damage']
                    self.dataLog['damage'] = self.dictVehicle[attackerID][attackReasonID]['damage']
                    self.dataLog['dmgRatio'] = self.dataLog['damage'] * 100 // data.data['maxHealth']
                    self.dataLog['number'] = '{:>2}'.format(len(self.listLog))
                    numberLine = self.dictVehicle[attackerID][attackReasonID]['numberLine']
                    macroes = getValueMacroes(self.section, self.dataLog)
                    self.listLog[numberLine] = parser(config.get(self.section + 'formatHistory'), macroes)
                else:
                    self.dictVehicle[attackerID][attackReasonID] = {'time': BigWorld.serverTime(),
                                                                    'damage': data.data['damage'],
                                                                    'numberLine': 0}
                    self.addLine(attackerID, attackReasonID)
            else:
                self.dictVehicle[attackerID] = {}
                self.dictVehicle[attackerID][attackReasonID] = {'time': BigWorld.serverTime(),
                                                                'damage': data.data['damage'],
                                                                'numberLine': 0}
                self.addLine(attackerID, attackReasonID)
        else:
            if config.get(self.section + 'showHitNoDamage') or data.data['isDamage']:
                self.dataLog = data.data
                self.addLine(None, None)
        as_event('ON_HIT')
        return


class LastHit(object):

    def __init__(self):
        self.dataFire = None
        self.section = 'damageLog/lastHit/'
        self.strLastHit = ''
        self.timerLastHit = None
        self.dictVehicle = {}
        if (self.timerLastHit is not None) and self.timerLastHit.isStarted:
            self.timerLastHit.stop()

    def reset(self):
        self.__init__()

    def hideLastHit (self):
        self.strLastHit = ''
        if (self.timerLastHit is not None) and self.timerLastHit.isStarted:
            self.timerLastHit.stop()
        as_event('ON_LAST_HIT')

    def output(self):
        if (data.data['attackReasonID'] == 1) and config.get(self.section + 'groupDamagesFromFire'):
            if data.data['fireStage'] == 0:
                self.dataFire = data.data.copy()
                macroes = getValueMacroes(self.section, self.dataFire)
                self.strLastHit = parser(config.get(self.section + 'formatLastHit'), macroes)
            elif data.data['fireStage'] in [1, 2]:
                self.dataFire['damage'] += data.data['damage']
                self.dataLog['dmgRatio'] = self.dataFire['damage'] * 100 // data.data['maxHealth']
                macroes = getValueMacroes(self.section, self.dataFire)
                self.strLastHit = parser(config.get(self.section + 'formatLastHit'), macroes)
        elif (data.data['attackReasonID'] in [2, 3]) and config.get(self.section + 'groupDamagesFromRamming_WorldCollision'):
            self.dataLog = data.data.copy()
            attackerID = data.data['attackerID']
            attackReasonID = data.data['attackReasonID']
            if attackerID in self.dictVehicle:
                if (attackReasonID in self.dictVehicle[attackerID] and
                   ('time' in self.dictVehicle[attackerID][attackReasonID]) and
                   ('damage' in self.dictVehicle[attackerID][attackReasonID]) and
                   ((BigWorld.serverTime() - self.dictVehicle[attackerID][attackReasonID]['time']) < 1)):
                    self.dictVehicle[attackerID][attackReasonID]['time'] = BigWorld.serverTime()
                    self.dictVehicle[attackerID][attackReasonID]['damage'] += data.data['damage']
                    self.dataLog['damage'] = self.dictVehicle[attackerID][attackReasonID]['damage']
                    self.dataLog['dmgRatio'] = self.dataLog['damage'] * 100 // data.data['maxHealth']
                else:
                    self.dictVehicle[attackerID][attackReasonID] = {'time': BigWorld.serverTime(),
                                                                    'damage': data.data['damage']}
            else:
                self.dictVehicle[attackerID] = {}
                self.dictVehicle[attackerID][attackReasonID] = {'time': BigWorld.serverTime(),
                                                                'damage': data.data['damage']}
            macroes = getValueMacroes(self.section, self.dataLog)
            self.strLastHit = parser(config.get(self.section + 'formatLastHit'), macroes)
        else:
            if config.get(self.section + 'showHitNoDamage') or data.data['isDamage']:
                macroes = getValueMacroes(self.section, data.data)
                self.strLastHit = parser(config.get(self.section + 'formatLastHit'), macroes)
            else:
                self.strLastHit = ''
        if self.strLastHit:
            if (self.timerLastHit is not None) and self.timerLastHit.isStarted:
                self.timerLastHit.stop()
            timeDisplayLastHit = float(config.get(self.section + 'timeDisplayLastHit'))
            self.timerLastHit = TimeInterval(timeDisplayLastHit, self, 'hideLastHit')
            self.timerLastHit.start()
        as_event('ON_LAST_HIT')
        return


class TimerReload(object):

    def __init__(self):
        self.strTime = ''
        self.section = 'damageLog/timeReload/'
        self.currentTime = 0
        self.finishTime = 0
        self.data = None
        self.timerReloadAttacker = None

    def reset(self):
        self.strTime = ''
        self.section = 'damageLog/timeReload/'
        self.currentTime = 0
        self.finishTime = 0
        self.data = None
        if (self.timerReloadAttacker is not None) and self.timerReloadAttacker.isStarted:
            self.timerReloadAttacker.stop()

    def afterTimerReload(self):
        self.strTime = ''
        if (self.timerReloadAttacker is not None) and self.timerReloadAttacker.isStarted:
            self.timerReloadAttacker.stop()
        as_event('ON_TIMER_RELOAD')

    def currentTimeReload(self):
        self.data['timer'] = self.finishTime - BigWorld.serverTime()
        timeTextAfterReload = float(config.get(self.section + 'timeTextAfterReload'))
        if self.data['timer'] > 0:
            macroes = getValueMacroes(self.section, self.data)
            self.strTime = parser(config.get(self.section + 'formatTimer'), macroes)
        else:
            self.timerReloadAttacker.stop()
            if timeTextAfterReload > 0:
                self.timerReloadAttacker = TimeInterval(timeTextAfterReload, self, 'afterTimerReload')
                macroes = getValueMacroes(self.section, self.data)
                self.strTime = parser(config.get(self.section + 'formatTimerAfterReload'), macroes)
                self.timerReloadAttacker.start()
            else:
                self.strTime = ''
        as_event('ON_TIMER_RELOAD')

    def output(self):
        if (data.data['attackReasonID'] == 0) and (data.data['timer'] > 0):
            self.data = data.data.copy()
            macroes = getValueMacroes(self.section, self.data)
            self.strTime = parser(config.get(self.section + 'formatTimer'), macroes)
            as_event('ON_TIMER_RELOAD')
            self.finishTime = self.data['timer'] + BigWorld.serverTime()
            if (self.timerReloadAttacker is not None) and (self.timerReloadAttacker.isStarted):
                self.timerReloadAttacker.stop()
            self.timerReloadAttacker = TimeInterval(0.1, self, 'currentTimeReload')
            self.timerReloadAttacker.start()


_log = Log('damageLog/log/')
_logAlt = Log('damageLog/logAlt/')
_lastHit = LastHit()
_timerReload = TimerReload()


@overrideMethod(DamageLogPanel, 'as_detailStatsS')
def as_detailStatsS(base, self, isVisible, messages):
    if not config.get('damageLog/disabledDetailStats'):
        return base(self, isVisible, messages)
    else:
        return base(self, False, messages)


@overrideMethod(DamageLogPanel, 'as_summaryStatsS')
def as_summaryStatsS(base, self, damage, blocked, assist):
    if not config.get('damageLog/disabledSummaryStats'):
        return base(self, damage, blocked, assist)


@overrideMethod(DamageLogPanel, '_onTotalEfficiencyUpdated')
def _onTotalEfficiencyUpdated(base, self, diff):
    if not config.get('damageLog/disabledSummaryStats'):
        return base(self, diff)


@registerEvent(Vehicle, 'onHealthChanged')
def onHealthChanged(self, newHealth, attackerID, attackReasonID):
    data.onHealthChanged(self, newHealth, attackerID, attackReasonID)
    if (newHealth <= 0) and self.isPlayerVehicle:
        global on_fire
        on_fire = 0
        as_event('ON_FIRE')


@registerEvent(Vehicle, 'onEnterWorld')
def onEnterWorld(self, prereqs):
    if self.isPlayerVehicle:
        global on_fire
        on_fire = 0
        data.data['oldHealth'] = self.health
        data.data['maxHealth'] = self.health


@registerEvent(Vehicle, 'showDamageFromShot')
def showDamageFromShot(self, attackerID, points, effectsIndex, damageFactor):
    data.showDamageFromShot(self, attackerID, points, effectsIndex, damageFactor)


@registerEvent(Vehicle, 'showDamageFromExplosion')
def showDamageFromExplosion(self, attackerID, center, effectsIndex, damageFactor):
    data.showDamageFromExplosion(self, attackerID, center, effectsIndex, damageFactor)


@registerEvent(DamagePanel, 'as_setFireInVehicleS')
def as_setFireInVehicleS(self, isInFire):
    global on_fire
    if isInFire:
        on_fire = 100
        data.data['isBeginFire'] = True
    else:
        on_fire = 0
    data.data['isInFire'] = isInFire
    as_event('ON_FIRE')


@registerEvent(PlayerAvatar, '_PlayerAvatar__destroyGUI')
def destroyGUI(self):
    global on_fire
    on_fire = 0
    data.reset()
    _log.reset()
    _logAlt.reset()
    _lastHit.reset()
    _timerReload.reset()

@registerEvent(PlayerAvatar, 'handleKey')
def handleKey(self, isDown, key, mods):
    global isDownAlt
    if (key == Keys.KEY_LALT) and isDown and not isDownAlt:
        isDownAlt = True
        as_event('ON_HIT')
    elif not ((key == Keys.KEY_LALT) and isDown) and isDownAlt:
        isDownAlt = False
        as_event('ON_HIT')


def dLog():
    return '\n'.join(_logAlt.listLog) if isDownAlt else '\n'.join(_log.listLog)


def lastHit():
    return _lastHit.strLastHit


def timerReload():
    return _timerReload.strTime


def fire():
    return on_fire
