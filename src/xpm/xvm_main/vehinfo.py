""" XVM (c) www.modxvm.com 2013-2017 """

# PUBLIC

def getVehicleInfoData(vehCD):
    global _vehicleInfoData
    return _vehicleInfoData.get(vehCD, None) if _vehicleInfoData is not None else None

def getVehicleInfoDataArray():
    global _vehicleInfoData
    return _vehicleInfoData.values() if _vehicleInfoData is not None else None

def updateReserve(vehCD, isReserved):
    global _vehicleInfoData
    if _vehicleInfoData is not None:
        _vehicleInfoData[vehCD]['isReserved'] = isReserved


# PRIVATE

_WN8_DATA_URL = 'http://stat.modxvm.com/wn8.json.gz'
_XTE_DATA_URL = 'http://stat.modxvm.com/xte.json.gz'
_XTDB_DATA_URL = 'http://stat.modxvm.com/xtdb.json.gz'


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
import vehinfo_short
from vehinfo_tiers import getTiers
from gun_rotation_shared import calcPitchLimitsFromDesc

_vehicleInfoData = None

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
    'premium':False,
    'hpStock':0,
    'hpTop':0,
    'turret': TURRET_TYPE_ONLY_ONE,
    'visRadius': 0,
    'firingRadius': 0,
    'artyRadius': 0,
    'tierLo': 0,
    'tierHi': 0,
    'shortName': 'unknown',
    'isReserved': False,
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
                #log('%i	%i	%s	%s' % (descr.level, descr.compactDescr, descr.name, descr.shortUserString))

                data = dict()
                data['vehCD'] = descr.compactDescr
                data['key'] = descr.name
                data['nation'] = nation
                data['level'] = descr.level
                data['vclass'] = tuple(vehicles.VEHICLE_CLASS_TAGS & descr.tags)[0]
                data['localizedName'] = descr.shortUserString
                data['localizedShortName'] = descr.shortUserString
                data['localizedFullName'] = descr.userString
                data['premium'] = 'premium' in descr.tags

                stockTurret = item.turrets[0][0]
                topTurret = item.turrets[0][-1]
                topGun = topTurret.guns[-1]

                if len(item.hulls) != 1:
                    log('WARNING: TODO: len(hulls) != 1 for vehicle ' + descr.name)
                data['hpStock'] = item.hulls[0].maxHealth + stockTurret.maxHealth
                data['hpTop'] = item.hulls[0].maxHealth + topTurret.maxHealth
                data['turret'] = _getTurretType(item, nation)
                (data['visRadius'], data['firingRadius'], data['artyRadius']) = \
                    _getRanges(topTurret, topGun, nation, data['vclass'])

                (data['tierLo'], data['tierHi']) = getTiers(data['level'], data['vclass'], data['key'])

                data['shortName'] = vehinfo_short.getShortName(data['key'], data['level'], data['vclass'])

                # is reserved?
                import xvm_tankcarousel.python.reserve as reserve
                data['isReserved'] = reserve.is_reserved(data['vehCD'])

                #log(data)

                res.append(data)

            ResMgr.purge(_VEHICLE_TYPE_XML_PATH + nation + '/components/guns.xml', True)

        vehinfo_short.checkNames(res)

        global _vehicleInfoData
        _vehicleInfoData = {x['vehCD']:x for x in res}

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
                pitchLimit_rad = min(CONST_45_IN_RADIANS, -calcPitchLimitsFromDesc(0, gun.pitchLimits))
            except Exception: # old way
                gunsInfoPath = _VEHICLE_TYPE_XML_PATH + nation + '/components/guns.xml/shared/'
                pitchLimit = ResMgr.openSection(gunsInfoPath + gun.name).readInt('pitchLimits')
                pitchLimit = min(45, -pitchLimit)  # -35..-65
                pitchLimit_rad = radians(pitchLimit)

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

def _load_wn8_data_callback(url, bytes):
    try:
        if bytes:
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
            data = simplejson.loads(gzip.GzipFile(fileobj=StringIO.StringIO(bytes)).read())
            for k, v in data.iteritems():
                vinfo = getVehicleInfoData(int(k))
                if vinfo is not None:
                    vinfo['avgdmg'] = float(v['ad'])
                    vinfo['topdmg'] = float(v['td'])
                    vinfo['avgfrg'] = float(v['af'])
                    vinfo['topfrg'] = float(v['tf'])
            # TODO
    except Exception, ex:
        err(traceback.format_exc())

def _load_xtdb_data_callback(url, bytes):
    try:
        if bytes:
            data = simplejson.loads(gzip.GzipFile(fileobj=StringIO.StringIO(bytes)).read())
            # TODO
    except Exception, ex:
        err(traceback.format_exc())
