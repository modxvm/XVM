""" XVM (c) https://modxvm.com 2013-2020 """

# PUBLIC

def getVehicleInfoData(vehCD):
    global _vehicleInfoData
    return _vehicleInfoData.get(vehCD, None) if _vehicleInfoData is not None else None

def getVehicleInfoDataArray():
    global _vehicleInfoData
    return _vehicleInfoData.values() if _vehicleInfoData is not None else None

def resetReserve():
    global _vehicleInfoData
    for v in _vehicleInfoData.itervalues():
        v['isReserved'] = False

def updateReserve(vehCD, isReserved):
    global _vehicleInfoData
    if _vehicleInfoData is not None:
        if vehCD in _vehicleInfoData:
            _vehicleInfoData[vehCD]['isReserved'] = isReserved

def getXvmScaleData(rating):
    return _xvmscale_data.get('x%s' % rating, None) if _xvmscale_data is not None else None

def getXteData(vehCD):
    return _xte_data.get(str(vehCD), None) if _xte_data is not None else None

def getXtdbData(vehCD):
    return _xtdb_data.get(str(vehCD), None) if _xtdb_data is not None else None

# XVM scale for global ratings

def calculateXvmScale(rating, value):
    data = getXvmScaleData(rating)
    if data is None:
        return -1
    # calculate XVM Scale
    return next((i for i,v in enumerate(data) if v > value), 100)

# xte

def calculateXTE(vehCD, dmg_per_battle, frg_per_battle):
    data = getXteData(vehCD)
    if data is None or data['td'] == data['ad'] or data['tf'] == data['af']:
        vdata = getVehicleInfoData(vehCD)
        if vdata is None:
            debug('NOTE: No vehicle info for vehicle id = {}'.format(vehCD))
        else:
            debug('NOTE: No xte data for vehicle [{}] {}'.format(vehCD, vdata['key']))
        return -1

    # constants
    CD = 3.0
    CF = 1.0

    # input
    avgD = float(data['ad'])
    topD = float(data['td'])
    avgF = float(data['af'])
    topF = float(data['tf'])

    # calculation
    dD = dmg_per_battle - avgD
    dF = frg_per_battle - avgF
    minD = avgD * 0.4
    minF = avgF * 0.4
    d = max(0, 1 + dD / (topD - avgD) if dmg_per_battle >= avgD else 1 + dD / (avgD - minD))
    f = max(0, 1 + dF / (topF - avgF) if frg_per_battle >= avgF else 1 + dF / (avgF - minF))

    t = (d * CD + f * CF) / (CD + CF) * 1000.0

    # calculate XVM Scale
    return next((i for i,v in enumerate(data['x']) if v > t), 100)

# xtdb

def calculateXTDB(vehCD, dmg_per_battle):
    data = getXtdbData(vehCD)
    if data is None:
        return -1
    # calculate XVM Scale
    return next((i for i,v in enumerate(data['x']) if v > dmg_per_battle), 100)

def getXtdbDataArray(vehCD):
    data = getXtdbData(vehCD)
    return data['x'] if data is not None else []


# PRIVATE

_XVMSCALE_DATA_URL = 'https://static.modxvm.com/xvmscales.json.gz'
_WN8_DATA_URL = 'https://static.modxvm.com/wn8-data-exp/json/wn8exp.json.gz'
_XTE_DATA_URL = 'https://static.modxvm.com/xte.json.gz'
_XTDB_DATA_URL = 'https://static.modxvm.com/xtdb.json.gz'


from math import sin, radians
import gzip
import StringIO
import traceback

import BigWorld
import ResMgr
import nations
from items import vehicles

import simplejson

from logger import *
import filecache
import reserve
import userprefs
import vehinfo_short
import vehinfo_tiers
from gun_rotation_shared import calcPitchLimitsFromDesc

_vehicleInfoData = None
_xvmscale_data = None
_xte_data = None
_xtdb_data = None

TURRET_TYPE_ONLY_ONE = 0
TURRET_TYPE_TOP_GUN_POSSIBLE = 1
TURRET_TYPE_NO_TOP_GUN = 2

CONST_45_IN_RADIANS = radians(45)

_VEHICLE_TYPE_XML_PATH = 'scripts/item_defs/vehicles/'

_UNKNOWN_VEHICLE_DATA = {
    'vehCD': 0,
    'key': 'unknown',
    'nation': '',
    'level': 0,
    'vclass': '',
    'localizedName': 'unknown',
    'localizedShortName': 'unknown',
    'localizedFullName': 'unknown',
    'premium': False,
    'special': False,
    'hpStock': 0,
    'hpTop': 0,
    'turret': TURRET_TYPE_ONLY_ONE,
    'visRadius': 0,
    'firingRadius': 0,
    'artyRadius': 0,
    'tierLo': 0,
    'tierHi': 0,
    'shortName': 'unknown',
    'isReserved': False,
    'topTurretCD': 0
}

def _init():
    res = [_UNKNOWN_VEHICLE_DATA]
    try:
        for nation in nations.NAMES:
            nationID = nations.INDICES[nation]
            for (id, descr) in vehicles.g_list.getList(nationID).iteritems():
                if descr.name.endswith('training'):
                    continue

                item = vehicles.g_cache.vehicle(nationID, id)
                #log('%i    %i  %s  %s' % (descr.level, descr.compactDescr, descr.name, descr.shortUserString))

                data = dict()
                data['vehCD'] = descr.compactDescr
                data['key'] = descr.name
                data['nation'] = nation
                data['level'] = descr.level
                data['vclass'] = tuple(vehicles.VEHICLE_CLASS_TAGS & descr.tags)[0]
                data['localizedName'] = descr.shortUserString
                data['localizedShortName'] = descr.shortUserString
                data['localizedFullName'] = descr.userString
                data['premium'] = 'premium' in descr.tags and 'special' not in descr.tags
                data['special'] = 'special' in descr.tags

                stockTurret = item.turrets[0][0]
                topTurret = item.turrets[0][-1]
                topGun = topTurret.guns[-1]

                #if len(item.hulls) != 1:
                #    log('WARNING: TODO: len(hulls) != 1 for vehicle ' + descr.name)
                data['hpStock'] = item.hulls[0].maxHealth + stockTurret.maxHealth
                data['hpTop'] = item.hulls[0].maxHealth + topTurret.maxHealth
                data['turret'] = _getTurretType(item, nation)
                data['topTurretCD'] = topTurret.compactDescr
                (data['visRadius'], data['firingRadius'], data['artyRadius']) = \
                    _getRanges(topTurret, topGun, nation, data['vclass'])

                (data['tierLo'], data['tierHi']) = vehinfo_tiers.getTiers(data['level'], data['vclass'], data['key'])

                data['shortName'] = vehinfo_short.getShortName(data['key'], data['level'], data['vclass'])

                data['isReserved'] = False

                #log(data)

                res.append(data)

            ResMgr.purge(_VEHICLE_TYPE_XML_PATH + nation + '/components/guns.xml', True)

        vehinfo_short.checkNames(res)

        global _vehicleInfoData
        _vehicleInfoData = {x['vehCD']:x for x in res}

        # load cached values
        _load_xvmscale_data_callback(None, userprefs.get('cache/xvmscales.json.gz'))
        _load_wn8_data_callback(None, userprefs.get('cache/wn8exp.json.gz'))
        _load_xte_data_callback(None, userprefs.get('cache/xte.json.gz'))
        _load_xtdb_data_callback(None, userprefs.get('cache/xtdb.json.gz'))

        # request latest values
        filecache.get_url(_XVMSCALE_DATA_URL, _load_xvmscale_data_callback)
        filecache.get_url(_WN8_DATA_URL, _load_wn8_data_callback)
        filecache.get_url(_XTE_DATA_URL, _load_xte_data_callback)
        filecache.get_url(_XTDB_DATA_URL, _load_xtdb_data_callback)

    except Exception, ex:
        err(traceback.format_exc())

BigWorld.callback(0, _init)

def _getRanges(turret, gun, nation, vclass):
    visionRadius = firingRadius = artyRadius = 0
    gunsInfoPath = _VEHICLE_TYPE_XML_PATH + nation + '/components/guns.xml/shared/'

    # Turret-dependent
    visionRadius = int(turret.circularVisionRadius)  # 240..420

    # Gun-dependent
    shots = gun.shots
    for shot in shots:
        radius = int(shot.maxDistance)
        if firingRadius < radius:
            firingRadius = radius  # 10000, 720, 395, 360, 350

        if vclass == 'SPG' and shot.shell.kind == 'HIGH_EXPLOSIVE':
            try:    # faster way
                pitchLimit_rad = min(CONST_45_IN_RADIANS, -calcPitchLimitsFromDesc(0, gun.pitchLimits)[0])
            except Exception: # old way
                minPitch = radians(-45)
                for _gun in turret.guns:
                    if _gun.name == gun.name:
                        minPitch = _gun.pitchLimits['minPitch'][0][1]
                        break
                pitchLimit_rad = min(CONST_45_IN_RADIANS, -minPitch)  # -35..-65
            radius = int(pow(shot.speed, 2) * sin(2 * pitchLimit_rad) / shot.gravity)
            if artyRadius < radius:
                artyRadius = radius  # 485..1469

    return (visionRadius, firingRadius, artyRadius)

def _getTurretType(item, nation):
    stock = item.turrets[0][0]
    top = item.turrets[0][-1]
    if stock == top:
        return TURRET_TYPE_ONLY_ONE

    # Some britain SPGs has absolutely two equal turrets but one of them is not used
    # by WG interface. WG screwed up again. Ignore this turret.
    #
    # As for 10 aug 2013 the screwed SPGs are:
    # gb27_sexton, amx_ob_am105, gb77_fv304, su14_1, gb29_crusader_5inch
    if stock.maxHealth == top.maxHealth:
        return TURRET_TYPE_ONLY_ONE

    if not top.unlocks:
        return TURRET_TYPE_TOP_GUN_POSSIBLE

    stockMaxPrice = _getMaxGunPrice(nation, stock.guns)
    topMaxPrice = _getMaxGunPrice(nation, top.guns)

    if stockMaxPrice >= topMaxPrice:
        return TURRET_TYPE_TOP_GUN_POSSIBLE

    return TURRET_TYPE_NO_TOP_GUN

def _getMaxGunPrice(nation, guns):
    maxPrice = 0
    for gun in guns:
        price = _getGunPrice(nation, gun.name)
        if maxPrice < price:
            maxPrice = price
    return maxPrice

def _getGunPrice(nation, gunName):
    xmlPath = _VEHICLE_TYPE_XML_PATH + nation + '/components/guns.xml'
    return ResMgr.openSection(xmlPath + '/shared/' + gunName).readInt('price')

def _load_xvmscale_data_callback(url, bytes):
    try:
        if bytes:
            if url is not None:
                userprefs.set('cache/xvmscales.json.gz', bytes)
            global _xvmscale_data
            _xvmscale_data = simplejson.loads(gzip.GzipFile(fileobj=StringIO.StringIO(bytes)).read())
    except Exception, ex:
        err(traceback.format_exc())

def _load_wn8_data_callback(url, bytes):
    try:
        if bytes:
            if url is not None:
                userprefs.set('cache/wn8exp.json.gz', bytes)
            data = simplejson.loads(gzip.GzipFile(fileobj=StringIO.StringIO(bytes)).read())
            for x in data['data']:
                vinfo = getVehicleInfoData(int(x['IDNum']))
                if vinfo is not None:
                    vinfo['wn8expDamage'] = float(x['expDamage'])
                    vinfo['wn8expSpot'] = float(x['expSpot'])
                    vinfo['wn8expWinRate'] = float(x['expWinRate'])
                    vinfo['wn8expDef'] = float(x['expDef'])
                    vinfo['wn8expFrag'] = float(x['expFrag'])
    except Exception, ex:
        err(traceback.format_exc())

def _load_xte_data_callback(url, bytes):
    try:
        if bytes:
            if url is not None:
                userprefs.set('cache/xte.json.gz', bytes)
            global _xte_data
            _xte_data = simplejson.loads(gzip.GzipFile(fileobj=StringIO.StringIO(bytes)).read())
            for k, v in _xte_data.iteritems():
                vinfo = getVehicleInfoData(int(k))
                if vinfo is not None:
                    vinfo['avgdmg'] = float(v['ad'])
                    vinfo['topdmg'] = float(v['td'])
                    vinfo['avgfrg'] = float(v['af'])
                    vinfo['topfrg'] = float(v['tf'])
    except Exception, ex:
        err(traceback.format_exc())

def _load_xtdb_data_callback(url, bytes):
    try:
        if bytes:
            if url is not None:
                userprefs.set('cache/xtdb.json.gz', bytes)
            global _xtdb_data
            _xtdb_data = simplejson.loads(gzip.GzipFile(fileobj=StringIO.StringIO(bytes)).read())
    except Exception, ex:
        err(traceback.format_exc())
