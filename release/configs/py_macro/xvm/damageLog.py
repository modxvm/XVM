# Addons: "DamageLog"
# ktulho <http://www.koreanrandom.com/forum/user/17624-ktulho/>

import copy

import BigWorld
import GUI
import Keys
import ResMgr
import nations
import xvm_main.python.config as config
import xvm_main.python.stats as stats
import xvm_main.python.userprefs as userprefs
from Avatar import PlayerAvatar
from Vehicle import Vehicle
from VehicleEffects import DamageFromShotDecoder
from constants import ITEM_DEFS_PATH
from gui.Scaleform.daapi.view.battle.shared.damage_log_panel import DamageLogPanel
from gui.Scaleform.daapi.view.battle.shared.damage_panel import DamagePanel
from gui.shared.utils.TimeInterval import TimeInterval
from items import vehicles
from items import vehicles, _xml
from xfw import *
from xvm_main.python.logger import *
from xvm_main.python.stats import _stat

on_fire = 0
beginFire = None
isDownAlt = False
autoReloadConfig = None
damageLogConfig = {}

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
               'dmg-kind', 'c:dmg-kind', 'c:vtype', 'type-shell', 'dmg', 'reloadGun', 'c:team-dmg', 'c:hit-effects',
               'level', 'clanicon', 'clannb', 'marksOnGun', 'squad-num', 'dmg-ratio', 'hit-effects', 'c:type-shell',
               'splash-hit', 'team-dmg', 'my-alive', 'gun-caliber', 'wn8', 'xwn8', 'wn6', 'xwn6', 'eff', 'xeff', 'wgr',
               'xwgr', 'xte', 'c:wn8', 'c:xwn8', 'c:wn6', 'c:xwn6', 'c:eff', 'c:xeff', 'c:wgr', 'c:xwgr', 'c:xte',
               'fire-duration', 'diff-masses', 'nation', 'my-blownup', 'r', 'c:r']

RATINGS = {
    'xvm_wgr': {'name': 'xwgr', 'size': 2},
    'xvm_wn6': {'name': 'xwn6', 'size': 2},
    'xvm_wn8': {'name': 'xwn8', 'size': 2},
    'xvm_eff': {'name': 'xeff', 'size': 2},
    'xvm_xte': {'name': 'xte', 'size': 2},
    'basic_wgr': {'name': 'wgr', 'size': 5},
    'basic_wn6': {'name': 'wn6', 'size': 4},
    'basic_wn8': {'name': 'wn8', 'size': 4},
    'basic_eff': {'name': 'eff', 'size': 4},
    'basic_xte': {'name': 'xte', 'size': 2}
}

SECTION_LOG = 'damageLog/log/'
SECTION_LOG_ALT = 'damageLog/logAlt/'
SECTION_LOG_BACKGROUND = 'damageLog/logBackground/'
SECTION_LOG_ALT_BACKGROUND = 'damageLog/logAltBackground/'
SECTION_LASTHIT = 'damageLog/lastHit/'
SECTIONS = (SECTION_LOG, SECTION_LOG_ALT, SECTION_LOG_BACKGROUND, SECTION_LOG_ALT_BACKGROUND, SECTION_LASTHIT)

def keyLower(_dict):
    if _dict is not None:
        dict_return = {}
        for key in _dict.keys():
            dict_return[key.lower()] = _dict[key]
        return dict_return
    else:
        return None


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
                'c_HitEffect': keyLower(config.get(section + 'c:hit-effects')),
                'typeShell': keyLower(config.get(section + 'type-shell')),
                'c_typeShell': keyLower(config.get(section + 'c:type-shell'))
                }
    else:
        return damageLogConfig[section]


def readRating():
    scale = config.networkServicesSettings.scale
    name = config.networkServicesSettings.rating
    r = '{}_{}'.format(scale, name)
    if r in RATINGS:
        return RATINGS[r]['name']
    else:
        return 'xwgr' if scale == 'xvm' else 'wgr'


def comparing(_macro, _operator, _math):
    if isinstance(_macro, basestring):
        _math = str(_math)
    elif isinstance(_macro, float):
        _math = float(_math)
    elif isinstance(_macro, int):
        _math = int(_math)
    if isinstance(_macro, (float, int)) and isinstance(_math, (float, int)):
        if _operator == '>=':
            return _macro >= _math
        elif _operator == '<=':
            return _macro <= _math
        elif _operator == '!=':
            return _macro != _math
        elif _operator in ('==', '='):
            return _macro == _math
        elif _operator == '<':
            return _macro < _math
        elif _operator == '>':
            return _macro > _math
    elif isinstance(_macro, basestring) and isinstance(_math, basestring):
        if _operator in ('==', '='):
            return _macro == _math
        elif _operator == '!=':
            return _macro != _math
    else:
        return False


FLAG = {'': '>', "'": '>', '-': '<', "-'": '<', '0': '0', "0'": '0', "-0": '0<', "-0'": '0<'}


def formatMacro(macro, macroes):
    _macro = macro[2:-2]
    _macro, _, _def = _macro.partition('|')
    _macro, _, _rep = _macro.partition('?')
    fm = {'flag': '', 'type': '', 'width': '', 'suf': ''}
    _operator = ''
    for s in ('>=', '<=', '!=', '==', '=', '<', '>'):
        if s in _macro:
            _macro, _operator, _math = _macro.partition(s)
            if '<dl' in _math:
                return _macro, True
            break
    _macro, _, fm['suf'] = _macro.partition('~')
    _macro, _, t = _macro.partition('%')
    if t[-1:] in ('s', 'd', 'f', 'x', 'a'):
        fm['type'] = t[-1:]
        t = t[:-1]
    t, _, _prec = t.partition('.')
    _prec = int(_prec) if _prec.isdigit() else ''
    for s in ("-0'", "-0", "-'", "0'", '-', '0', "'"):
        if (s in t) and (s[0] == t[0]):
            _, fm['flag'], fm['width'] = t.rpartition(s)
            break
    if not fm['width'] and t.isdigit():
        fm['width'] = int(t)
    tempMacro = _macro
    if _macro in macroes:
        _macro = macroes[_macro]
        if _operator:
            if _rep and comparing(_macro, _operator, _math):
                _macro = _rep
            elif not comparing(_macro, _operator, _math):
                _macro = _def
        elif _rep and _macro:
            _macro = _rep
        elif _def and not _macro:
            _macro = _def
        if _macro == macroes[tempMacro]:
            fm['flag'] = FLAG[fm['flag']]
            fm['prec'] = ''
            if _prec != '':
                if isinstance(_macro, int):
                    _macro = int(_macro) + _prec
                elif isinstance(_macro, float):
                    fm['prec'] = '.' + str(_prec)
                elif isinstance(_macro, basestring):
                    u_macro = unicode(_macro, 'utf8')
                    if len(u_macro) > _prec:
                        if (_prec - len(unicode(fm['suf'], 'utf8'))) > 0:
                            _macro = u_macro[:(_prec - len(fm['suf']))]
                        else:
                            _macro = u_macro[:_prec]
                            fm['suf'] = ''
                    else:
                        fm['suf'] = ''
            if _macro is None:
                _macro = ''
            else:
                _macro = '{0:{flag}{width}{prec}{type}}{suf}'.format(_macro, **fm)
        return str(_macro), False
    else:
        return macro, False


def parser(strHTML, macroes):
    notMacroesDL = {}
    i = 0
    if not isinstance(strHTML, str):
        strHTML = str(strHTML)
    while '{{' in strHTML:
        b = True
        while b:
            b = False
            for s in MACROS_NAME:
                temp_str = '{{%s}}' % s
                if temp_str in strHTML:
                    _macro = str(macroes.get(s, ''))
                    strHTML = strHTML.replace(temp_str, _macro)
                    b = True
        start = strHTML.rfind('{{')
        end = strHTML.find('}}', start) + 2
        if not ((start >= 0) and (end >= 2)):
            break
        substr = strHTML[start:end]
        for s in MACROS_NAME:
            begin = substr.find(s)
            if (begin == 2) and (substr[(2 + len(s))] in ('|', '?', '~', '%', '>', '<', '!', '=')):
                _macro, non = formatMacro(substr, macroes)
                if non:
                    substr = substr.replace('{{%s' % _macro, '{{%s' % macroes[_macro], 1)
                    for s1 in MACROS_NAME:
                        if ('{{%s' % s1) in substr:
                            _macro = substr
                            break
                    else:
                        i += 1
                        _macro = '<dl%s>' % str(i)
                        notMacroesDL[_macro] = substr
                break
        else:
            i += 1
            _macro = '<dl%s>' % str(i)
            notMacroesDL[_macro] = substr
        strHTML = '%s%s%s' % (strHTML[0:start], _macro, strHTML[end:])
    b = (i > 0)
    while b:
        b = False
        _notMacroesDL = notMacroesDL.copy()
        for s in _notMacroesDL:
            if s in strHTML:
                b = True
                strHTML = strHTML.replace(s, notMacroesDL.pop(s, ''), 1)
    return strHTML


class Data(object):
    def __init__(self):
        def isGoldShell(n, s):
            if n != 'icons':
                xmlCtx = (None, xmlPath + '/' + n)
                price = _xml.readPrice(xmlCtx, s, 'price')
                return _xml.readInt(xmlCtx, s, 'id', 0, 65535) if price[1] else None

        self.initial()
        self.shells = {}
        for nation in nations.NAMES:
            xmlPath = '%s%s%s%s' % (ITEM_DEFS_PATH, 'vehicles/', nation, '/components/shells.xml')
            self.shells[nation] = [isGoldShell(name, subsection) for name, subsection in ResMgr.openSection(xmlPath).items() if isGoldShell(name, subsection) is not None]
        ResMgr.purge(xmlPath, True)

    def reset(self):
        self.initial()

    def initial(self):
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
                     'number': None,
                     'reloadGun': 0.0,
                     'caliber': None,
                     'fireDuration': None,
                     'diff-masses': None,
                     'nation': None,
                     'blownup': False
                     }

    def updateData(self):
        player = BigWorld.player()
        self.data['dmgRatio'] = self.data['damage'] * 100 // self.data['maxHealth']
        attackerID = self.data['attackerID']
        if attackerID:
            entity = BigWorld.entity(attackerID)
            self.data['marksOnGun'] = '_' + str(entity.publicInfo['marksOnGun']) if (entity is not None) else None
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
                    self.data['attackerVehicleType'] = list(_type.tags.intersection(VEHICLE_CLASSES))[0].lower()
                    self.data['shortUserString'] = _type.shortUserString
                    self.data['level'] = vehicleType.level
                    self.data['nation'] = nations.NAMES[_type.customizationNationID]
                    if self.data['attackReasonID'] == 2:
                        self.data['diff-masses'] = (player.vehicleTypeDescriptor.physics['weight'] - vehicleType.physics['weight']) / 1000.0
                    elif self.data['diff-masses'] is not None:
                        self.data['diff-masses'] = None
                else:
                    self.data['attackerVehicleType'] = None
                    self.data['shortUserString'] = None
                    self.data['level'] = None
                    self.data['nation'] = None
                    self.data['diff-masses'] = None
                self.data['name'] = attacker['name']
                if (_stat.resp is not None) and (attacker['name'] in _stat.resp['players']):
                    stats = _stat.resp['players'][attacker['name']]
                    self.data['wn8'] = stats.get('wn8', None)
                    self.data['xwn8'] = stats.get('xwn8', None)
                    self.data['wn6'] = stats.get('wn6', None)
                    self.data['xwn6'] = stats.get('xwn6', None)
                    self.data['eff'] = stats.get('e', None)
                    self.data['xeff'] = stats.get('xeff', None)
                    self.data['wgr'] = stats.get('wgr', None)
                    self.data['xwgr'] = stats.get('xwgr', None)
                    self.data['xte'] = stats.get('v').get('xte', None)
                else:
                    self.data['wn8'] = None
                    self.data['xwn8'] = None
                    self.data['wn6'] = None
                    self.data['xwn6'] = None
                    self.data['eff'] = None
                    self.data['xeff'] = None
                    self.data['wgr'] = None
                    self.data['xwgr'] = None
                    self.data['xte'] = None
                self.data['clanAbbrev'] = attacker['clanAbbrev']
            self.data['clanicon'] = _stat.getClanIcon(attackerID)
            statXVM = _stat.players.get(attackerID, None)
            self.data['squadnum'] = statXVM.squadnum if statXVM is not None else None
        else:
            self.data['teamDmg'] = 'unknown'
            self.data['attackerVehicleType'] = None
            self.data['shortUserString'] = None
            self.data['name'] = None
            self.data['clanAbbrev'] = None
            self.data['level'] = None
            self.data['clanicon'] = None
            self.data['squadnum'] = None
            self.data['marksOnGun'] = None

    def typeShell(self, effectsIndex):
        self.data['costShell'] = 'unknown'
        self.data['shellKind'] = 'not_shell'
        if (self.data['attackerID'] == 0) or (self.data['attackReasonID'] != 0):
            return
        player = BigWorld.player()
        attacker = player.arena.vehicles.get(self.data['attackerID'])
        if (attacker is None) or not attacker['vehicleType']:
            self.data['shellKind'] = None
            self.data['caliber'] = None
            self.data['costShell'] = None
            return
        for shell in attacker['vehicleType'].gun['shots']:
            _shell = shell['shell']
            if effectsIndex == _shell['effectsIndex']:
                self.data['shellKind'] = str(_shell['kind']).lower()
                self.data['caliber'] = _shell['caliber']
                _id = _shell['id']
                self.data['costShell'] = 'gold-shell' if _id[1] in self.shells[nations.NAMES[_id[0]]] else 'silver-shell'
                break

    def timeReload(self, attackerID):
        if self.data['attackerID']:
            player = BigWorld.player()
            attacker = player.arena.vehicles.get(attackerID)
            vehicleType = attacker['vehicleType']
            if (attacker is not None) and (vehicleType):
                reload_orig = vehicleType.gun['reloadTime']
                _miscAttrs = vehicleType.miscAttrs
                crew = 0.94 if _miscAttrs['crewLevelIncrease'] != 0 else 1.0
                if (vehicleType.gun['clip'][0] == 1) and (_miscAttrs['gunReloadTimeFactor'] != 0.0):
                    rammer = _miscAttrs['gunReloadTimeFactor']
                else:
                    rammer = 1
                return reload_orig * crew * rammer
            else:
                return 0.0
        else:
            return 0.0

    def hitShell(self, attackerID, effectsIndex, damageFactor):
        self.data['isDamage'] = damageFactor > 0
        self.data['attackerID'] = attackerID
        self.data['attackReasonID'] = effectsIndex if effectsIndex in [24, 25] else 0
        self.data['reloadGun'] = self.timeReload(attackerID)
        self.typeShell(effectsIndex)
        if damageFactor:
            self.data['hitEffect'] = HIT_EFFECT_CODES[4]
        else:
            self.data['damage'] = 0
            self.updateData()
            self.updateLabels()

    def updateLabels(self):
        _log.callEvent = _logBackground.callEvent = not isDownAlt
        _logAlt.callEvent = _logAltBackground.callEvent = isDownAlt
        _logAlt.output()
        _log.output()
        _lastHit.output()
        _logBackground.output()
        _logAltBackground.output()

    def showDamageFromShot(self, vehicle, attackerID, points, effectsIndex, damageFactor):
        maxHitEffectCode, decodedPoints = DamageFromShotDecoder.decodeHitPoints(points, vehicle.typeDescriptor)
        self.data['compName'] = decodedPoints[0].componentName if decodedPoints else 'unknown'
        self.data['splashHit'] = 'no-splash'
        self.data['criticalHit'] = (maxHitEffectCode == 5)
        if damageFactor == 0:
            self.data['hitEffect'] = HIT_EFFECT_CODES[min(3, maxHitEffectCode)]
            self.data['isAlive'] = bool(vehicle.isCrewActive)
        self.hitShell(attackerID, effectsIndex, damageFactor)

    def showDamageFromExplosion(self, vehicle, attackerID, center, effectsIndex, damageFactor):
        self.data['splashHit'] = 'splash'
        self.data['criticalHit'] = False
        if damageFactor == 0:
            self.data['hitEffect'] = HIT_EFFECT_CODES[3]
            self.data['isAlive'] = bool(vehicle.isCrewActive)
        self.hitShell(attackerID, effectsIndex, damageFactor)

    def onHealthChanged(self, vehicle, newHealth, attackerID, attackReasonID):
        if self.data['attackReasonID'] not in [24, 25]:
            self.data['attackReasonID'] = attackReasonID
        self.data['blownup'] = (newHealth == -13) or (newHealth == -5)
        self.data['isDamage'] = True
        self.data['hitEffect'] = HIT_EFFECT_CODES[4]
        if self.data['attackReasonID'] != 0:
            self.data['costShell'] = 'unknown'
            self.data['criticalHit'] = False
            self.data['shellKind'] = 'not_shell'
            self.data['splashHit'] = 'no-splash'
            self.data['reloadGun'] = 0.0
        else:
            self.data['reloadGun'] = self.timeReload(attackerID)
        self.data['attackerID'] = attackerID
        self.data['damage'] = self.data['oldHealth'] - max(0, newHealth)
        self.data['isAlive'] = (newHealth > 0) and bool(vehicle.isCrewActive)
        self.data['oldHealth'] = max(0, newHealth)
        self.updateData()
        self.updateLabels()


data = Data()


def getValueMacroes(section, value):
    def readColor(sec, m):
        if m is not None:
            for val in config.get('colors/' + sec):
                if val['value'] > m:
                    return '#' + val['color'][2:] if val['color'][:2] == '0x' else val['color']

    conf = readyConfig(section)
    macro = {'c:team-dmg': conf['c_teamDmg'][value['teamDmg']],
             'team-dmg': conf['teamDmg'].get(value['teamDmg'], ''),
             'vtype': conf['vehicleClass'].get(value['attackerVehicleType'], 'not_vehicle'),
             'c:costShell': conf['c_Shell'][value['costShell']],
             'costShell': conf['costShell'].get(value['costShell'], 'unknown'),
             'c:dmg-kind': conf['c_typeHit'][ATTACK_REASONS[value['attackReasonID']]],
             'dmg-kind': conf['typeHit'].get(ATTACK_REASONS[value['attackReasonID']], 'reason: %s' % value['attackReasonID']),
             'c:vtype': conf['c_VehicleClass'].get(value['attackerVehicleType'], 'not_vehicle'),
             'comp-name': conf['compNames'].get(value['compName'], 'unknown'),
             'splash-hit': conf['splashHit'].get(value['splashHit'], 'unknown'),
             'critical-hit': conf['criticalHit'].get('critical') if value['criticalHit'] else conf['criticalHit'].get('no-critical'),
             'type-shell': conf['typeShell'].get(value['shellKind'], 'unknown'),
             'c:type-shell': conf['c_typeShell'][value['shellKind']],
             'c:hit-effects': conf['c_HitEffect'][value['hitEffect']],
             'hit-effects': conf['hitEffect'].get(value['hitEffect'], 'unknown'),
             'number': value['number'],
             'dmg': value['damage'],
             'dmg-ratio': value['dmgRatio'],
             'vehicle': value['shortUserString'],
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
             'wn6': value.get('wn6', None),
             'xwn6': value.get('xwn6', None),
             'eff': value.get('eff', None),
             'xeff': value.get('xeff', None),
             'wgr': value.get('wgr', None),
             'xwgr': value.get('xwgr', None),
             'xte': value.get('xte', None),
             'r': '{{%s}}' % readRating(),
             'c:r': '{{c:%s}}' % readRating(),
             'c:wn8': readColor('wn8', value.get('wn8', None)),
             'c:xwn8': readColor('x', value.get('xwn8', None)),
             'c:wn6': readColor('wn6', value.get('wn6', None)),
             'c:xwn6': readColor('x', value.get('xwn6', None)),
             'c:eff': readColor('eff', value.get('eff', None)),
             'c:xeff': readColor('x', value.get('xeff', None)),
             'c:wgr': readColor('wgr', value.get('wgr', None)),
             'c:xwgr': readColor('x', value.get('xwgr', None)),
             'c:xte': readColor('x', value.get('xte', None)),
             'fire-duration': value.get('fireDuration', None),
             'diff-masses': value.get('diff-masses', None),
             'nation': value.get('nation', None),
             'my-blownup': 'blownup' if value['blownup'] else None,
             }
    return macro


def shadow_value(section, macroes):
    return {'distance': parser(config.get(section + 'shadow/distance'), macroes),
            'angle': parser(config.get(section + 'shadow/angle'), macroes),
            'alpha': parser(config.get(section + 'shadow/alpha'), macroes),
            'blur': parser(config.get(section + 'shadow/blur'), macroes),
            'strength': parser(config.get(section + 'shadow/strength'), macroes),
            'color': parser(config.get(section + 'shadow/color'), macroes),
            'hideObject': parser(config.get(section + 'shadow/hideObject'), macroes),
            'inner': parser(config.get(section + 'shadow/inner'), macroes),
            'knockout': parser(config.get(section + 'shadow/knockout'), macroes),
            'quality': parser(config.get(section + 'shadow/quality'), macroes)
            }


class _Base(object):
    def __init__(self, section):
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
        self.listLog = []
        self.dataLog = {}
        if config.get(section + 'moveInBattle'):
            _data = userprefs.get('DamageLog/dlog', {'x': config.get(section + 'x'), 'y': config.get(section + 'y')})
            if section == 'damageLog/log/':
                as_callback("dLog_mouseDown", self.mouse_down)
                as_callback("dLog_mouseUp", self.mouse_up)
                as_callback("dLog_mouseMove", self.mouse_move)
        else:
            _data = {'x': config.get(section + 'x'), 'y': config.get(section + 'y')}
        self.x = _data['x']
        self.y = _data['y']
        self.callEvent = True

    def reset(self, section):
        _Base.reset(self)
        self.listLog = []
        self.section = section
        self.dataLog = {}
        self.callEvent = True
        if (None not in [self.x, self.y]) and config.get(section + 'moveInBattle') and section == 'damageLog/log/':
            userprefs.set('DamageLog/dLog', {'x': self.x, 'y': self.y})

    def mouse_move(self, _data):
        self._mouse_move(_data, 'ON_HIT')

    def addLine(self, attackerID, attackReasonID):
        self.dataLog['number'] = len(self.listLog) + 1
        self.dataLog['fireDuration'] = BigWorld.time() - beginFire if attackReasonID == 1 else None
        macroes = getValueMacroes(self.section, self.dataLog)
        self.listLog.insert(0, parser(config.get(self.section + 'formatHistory'), macroes))
        if not config.get(self.section + 'moveInBattle'):
            self.x = parser(config.get(self.section + 'x'), macroes)
            self.y = parser(config.get(self.section + 'y'), macroes)
        self.shadow = shadow_value(self.section, macroes)
        for attacker in self.dictVehicle:
            for attack in self.dictVehicle[attacker]:
                if (attacker != attackerID) and (attack != attackReasonID):
                    self.dictVehicle[attacker][attack]['numberLine'] += 1

    def output(self):
        if (((data.data['attackReasonID'] in [2, 3]) and config.get(self.section + 'groupDamagesFromRamming_WorldCollision'))
                or ((data.data['attackReasonID'] == 1) and config.get(self.section + 'groupDamagesFromFire'))):
            self.dataLog = data.data.copy()
            attackerID = data.data['attackerID']
            attackReasonID = data.data['attackReasonID']
            if attackerID in self.dictVehicle:
                if attackReasonID in self.dictVehicle[attackerID]:
                    key = self.dictVehicle[attackerID][attackReasonID]
                    if ('time' in key) and ('damage' in key) and ((BigWorld.serverTime() - key['time']) < 1):
                        key['time'] = BigWorld.serverTime()
                        key['damage'] += data.data['damage']
                        self.dataLog['damage'] = key['damage']
                        self.dataLog['dmgRatio'] = self.dataLog['damage'] * 100 // data.data['maxHealth']
                        self.dataLog['number'] = len(self.listLog)
                        if (attackReasonID == 1) and (key['beginFire'] is not None):
                            self.dataLog['fireDuration'] = BigWorld.time() - key['beginFire']
                        else:
                            self.dataLog['fireDuration'] = None
                        macroes = getValueMacroes(self.section, self.dataLog)
                        self.listLog[key['numberLine']] = parser(config.get(self.section + 'formatHistory'), macroes)
                        if not config.get(self.section + 'moveInBattle'):
                            self.x = parser(config.get(self.section + 'x'), macroes)
                            self.y = parser(config.get(self.section + 'y'), macroes)
                        self.shadow = shadow_value(self.section, macroes)
                else:
                    self.dictVehicle[attackerID][attackReasonID] = {'time': BigWorld.serverTime(),
                                                                    'damage': data.data['damage'],
                                                                    'numberLine': 0,
                                                                    'beginFire': beginFire if attackReasonID == 1 else None}
                    self.addLine(attackerID, attackReasonID)
            else:
                self.dictVehicle[attackerID] = {}
                self.dictVehicle[attackerID][attackReasonID] = {'time': BigWorld.serverTime(),
                                                                'damage': data.data['damage'],
                                                                'numberLine': 0,
                                                                'beginFire': beginFire if attackReasonID == 1 else None}
                self.addLine(attackerID, attackReasonID)
            if self.callEvent:
                as_event('ON_HIT')
        else:
            if config.get(self.section + 'showHitNoDamage') or data.data['isDamage']:
                self.dataLog = data.data
                self.addLine(None, None)
                if self.callEvent:
                    as_event('ON_HIT')


class LastHit(_Base):
    def __init__(self, section):
        _Base.__init__(self, section)
        self.strLastHit = ''
        if config.get(self.section + 'moveInBattle'):
            _data = userprefs.get('DamageLog/lastHit', {'x': config.get(section + 'x'), 'y': config.get(section + 'y')})
            as_callback("lastHit_mouseDown", self.mouse_down)
            as_callback("lastHit_mouseUp", self.mouse_up)
            as_callback("lastHit_mouseMove", self.mouse_move)
        else:
            _data = {'x': config.get(section + 'x'), 'y': config.get(section + 'y')}
        self.x = _data['x']
        self.y = _data['y']
        self.timerLastHit = None

    def reset(self):
        _Base.reset(self)
        self.strLastHit = ''
        if (self.timerLastHit is not None) and self.timerLastHit.isStarted:
            self.timerLastHit.stop()
        if (None not in [self.x, self.y]) and config.get(self.section + 'moveInBattle'):
            userprefs.set('DamageLog/lastHit', {'x': self.x, 'y': self.y})

    def mouse_move(self, _data):
        self._mouse_move(_data, 'ON_LAST_HIT')

    def hideLastHit(self):
        self.strLastHit = ''
        if (self.timerLastHit is not None) and self.timerLastHit.isStarted:
            self.timerLastHit.stop()
        as_event('ON_LAST_HIT')

    def output(self):
        macroes = None
        if (((data.data['attackReasonID'] in [2, 3]) and config.get(self.section + 'groupDamagesFromRamming_WorldCollision'))
                or ((data.data['attackReasonID'] == 1) and config.get(self.section + 'groupDamagesFromFire'))):
            dataLog = data.data.copy()
            attackerID = data.data['attackerID']
            attackReasonID = data.data['attackReasonID']
            if attackerID in self.dictVehicle:
                if attackReasonID in self.dictVehicle[attackerID]:
                    key = self.dictVehicle[attackerID][attackReasonID]
                    if ('time' in key) and ('damage' in key) and ((BigWorld.serverTime() - key['time']) < 1):
                        key['time'] = BigWorld.serverTime()
                        key['damage'] += data.data['damage']
                        dataLog['damage'] = key['damage']
                        dataLog['dmgRatio'] = dataLog['damage'] * 100 // data.data['maxHealth']
                        if (attackReasonID == 1) and (key['beginFire'] is not None):
                            dataLog['fireDuration'] = BigWorld.time() - key['beginFire']
                        else:
                            dataLog['fireDuration'] = None
                else:
                    self.dictVehicle[attackerID][attackReasonID] = {'time': BigWorld.serverTime(),
                                                                    'damage': data.data['damage'],
                                                                    'beginFire': beginFire if attackReasonID == 1 else None}
                    dataLog['fireDuration'] = BigWorld.time() - beginFire if attackReasonID == 1 else None
            else:
                self.dictVehicle[attackerID] = {}
                self.dictVehicle[attackerID][attackReasonID] = {'time': BigWorld.serverTime(),
                                                                'damage': data.data['damage'],
                                                                'beginFire': beginFire if attackReasonID == 1 else None}
                dataLog['fireDuration'] = BigWorld.time() - beginFire if attackReasonID == 1 else None
            macroes = getValueMacroes(self.section, dataLog)
            self.strLastHit = parser(config.get(self.section + 'formatLastHit'), macroes)
            if not config.get(self.section + 'moveInBattle'):
                self.x = parser(config.get(self.section + 'x'), macroes)
                self.y = parser(config.get(self.section + 'y'), macroes)
        else:
            if config.get(self.section + 'showHitNoDamage') or data.data['isDamage']:
                macroes = getValueMacroes(self.section, data.data)
                self.strLastHit = parser(config.get(self.section + 'formatLastHit'), macroes)
                if not config.get(self.section + 'moveInBattle'):
                    self.x = parser(config.get(self.section + 'x'), macroes)
                    self.y = parser(config.get(self.section + 'y'), macroes)
            else:
                self.strLastHit = ''
        if self.strLastHit:
            if macroes is None:
                macroes = getValueMacroes(self.section, data.data)
            if (self.timerLastHit is not None) and self.timerLastHit.isStarted:
                self.timerLastHit.stop()
            timeDisplayLastHit = float(parser(config.get(self.section + 'timeDisplayLastHit'), macroes))
            self.timerLastHit = TimeInterval(timeDisplayLastHit, self, 'hideLastHit')
            self.timerLastHit.start()
            self.shadow = shadow_value(self.section, macroes)
            as_event('ON_LAST_HIT')


_log = DamageLog(SECTION_LOG)
_logAlt = DamageLog(SECTION_LOG_ALT)
_logBackground = DamageLog(SECTION_LOG_BACKGROUND)
_logAltBackground = DamageLog(SECTION_LOG_ALT_BACKGROUND)
_lastHit = LastHit(SECTION_LASTHIT)


@overrideMethod(DamageLogPanel, '_addToTopLog')
def DamageLogPanel_addToTopLog(base, self, value, actionTypeImg, vehicleTypeImg, vehicleName, shellTypeStr, shellTypeBG):
    if not config.get('damageLog/disabledDetailStats'):
        return base(self, value, actionTypeImg, vehicleTypeImg, vehicleName, shellTypeStr, shellTypeBG)


@overrideMethod(DamageLogPanel, '_addToBottomLog')
def DamageLogPanel_addToBottomLog(base, self, value, actionTypeImg, vehicleTypeImg, vehicleName, shellTypeStr, shellTypeBG):
    if not config.get('damageLog/disabledDetailStats'):
        return base(self, value, actionTypeImg, vehicleTypeImg, vehicleName, shellTypeStr, shellTypeBG)


@overrideMethod(DamageLogPanel, 'as_summaryStatsS')
def as_summaryStatsS(base, self, damage, blocked, assist, stun):
    if not config.get('damageLog/disabledSummaryStats'):
        return base(self, damage, blocked, assist, stun)


@overrideMethod(DamageLogPanel, '_onTotalEfficiencyUpdated')
def _onTotalEfficiencyUpdated(base, self, diff):
    if not config.get('damageLog/disabledSummaryStats'):
        return base(self, diff)


@registerEvent(Vehicle, 'onHealthChanged')
def onHealthChanged(self, newHealth, attackerID, attackReasonID):
    global on_fire
    if self.isPlayerVehicle and data.data['isAlive']:
        data.onHealthChanged(self, newHealth, attackerID, attackReasonID)
        if (newHealth <= 0):
            on_fire = 0
            as_event('ON_FIRE')
    elif hasattr(BigWorld.player().inputHandler.ctrl, 'curVehicleID'):
        vId = BigWorld.player().inputHandler.ctrl.curVehicleID
        v = vId if isinstance(vId, Vehicle) else BigWorld.entity(vId)
        if (v is not None) and ((self.id == v.id) and not v.isAlive()):
            on_fire = 0
            as_event('ON_FIRE')


@registerEvent(Vehicle, 'onEnterWorld')
def onEnterWorld(self, prereqs):
    if self.isPlayerVehicle:
        global on_fire, damageLogConfig, autoReloadConfig
        autoReloadConfig = config.get('autoReloadConfig')
        if not (autoReloadConfig or damageLogConfig):
            for section in SECTIONS:
                damageLogConfig[section] = readyConfig(section)
        on_fire = 0
        data.data['oldHealth'] = self.health
        data.data['maxHealth'] = self.health


@registerEvent(Vehicle, 'showDamageFromShot')
def showDamageFromShot(self, attackerID, points, effectsIndex, damageFactor):
    if self.isPlayerVehicle and data.data['isAlive']:
        data.showDamageFromShot(self, attackerID, points, effectsIndex, damageFactor)


@registerEvent(Vehicle, 'showDamageFromExplosion')
def showDamageFromExplosion(self, attackerID, center, effectsIndex, damageFactor):
    if self.isPlayerVehicle and data.data['isAlive']:
        data.showDamageFromExplosion(self, attackerID, center, effectsIndex, damageFactor)


@registerEvent(DamagePanel, 'as_setFireInVehicleS')
def as_setFireInVehicleS(self, isInFire):
    global on_fire, beginFire
    if isInFire:
        on_fire = 100
        beginFire = BigWorld.time()
    else:
        on_fire = 0
    as_event('ON_FIRE')


@registerEvent(PlayerAvatar, '_PlayerAvatar__destroyGUI')
def destroyGUI(self):
    global on_fire
    on_fire = 0
    data.reset()
    _log.reset(_log.section)
    _logAlt.reset(_logAlt.section)
    _logBackground.reset(_logBackground.section)
    _logAltBackground.reset(_logAltBackground.section)
    _lastHit.reset()


@registerEvent(PlayerAvatar, 'handleKey')
def handleKey(self, isDown, key, mods):
    global isDownAlt
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


def dLogBackground():
    return '\n'.join(_logAltBackground.listLog) if isDownAlt else '\n'.join(_logBackground.listLog)


def dLog_shadow(setting):
    return _logAlt.shadow.get(setting, None) if isDownAlt else _log.shadow.get(setting, None)


def lastHit():
    return _lastHit.strLastHit


def lastHit_shadow(setting):
    return _lastHit.shadow.get(setting, None)


def fire():
    return on_fire

