""" XVM (c) www.modxvm.com 2013-2016 """

# PUBLIC

def getVehicleInfoData(vehCD):
    global _vehicleInfoData
    if _vehicleInfoData is None:
        _init()
    return _vehicleInfoData.get(vehCD, None)


def getVehicleInfoDataArray():
    global _vehicleInfoData
    if _vehicleInfoData is None:
        _init()
    return _vehicleInfoData.values()


def updateReserve(vehCD, isReserved):
    global _vehicleInfoData
    if _vehicleInfoData is None:
        _init()
    else:
        _vehicleInfoData[vehCD]['isReserved'] = isReserved


# PRIVATE

from pprint import pprint
from math import sin, radians
import traceback

import ResMgr
import nations
from items import vehicles

from logger import *
import vehinfo_short
from vehinfo_tiers import getTiers
from gun_rotation_shared import calcPitchLimitsFromDesc
import vehinfo_wn8


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
                if descr['name'].endswith('training'):
                    continue

                item = vehicles.g_cache.vehicle(nationID, id)
                # pprint(vars(item))
                # log('%i	%i	%s' % (descr['level'], descr['compactDescr'], descr['name']))

                data = dict()
                data['vehCD'] = descr['compactDescr']
                data['key'] = descr['name']
                data['nation'] = nation
                data['level'] = descr['level']
                data['vclass'] = tuple(vehicles.VEHICLE_CLASS_TAGS & descr['tags'])[0]
                data['localizedName'] = descr['shortUserString']
                data['localizedShortName'] = descr['shortUserString']
                data['localizedFullName'] = descr['userString']
                data['premium'] = 'premium' in descr['tags']

                stockTurret = item.turrets[0][0]
                topTurret = item.turrets[0][-1]
                topGun = topTurret['guns'][-1]

                if len(item.hulls) != 1:
                    log('WARNING: TODO: len(hulls) != 1 for vehicle ' + descr['name'])
                data['hpStock'] = item.hulls[0]['maxHealth'] + stockTurret['maxHealth']
                data['hpTop'] = item.hulls[0]['maxHealth'] + topTurret['maxHealth']
                data['turret'] = _getTurretType(item, nation)
                (data['visRadius'], data['firingRadius'], data['artyRadius']) = \
                    _getRanges(topTurret, topGun, data['nation'], data['vclass'])

                (data['tierLo'], data['tierHi']) = getTiers(data['level'], data['vclass'], data['key'])

                data['shortName'] = vehinfo_short.getShortName(data['key'], data['level'], data['vclass'])

                wn8data = vehinfo_wn8.getWN8ExpectedData(data['vehCD'])
                if wn8data is not None:
                    data['wn8expDamage'] = float(wn8data['expDamage'])
                    data['wn8expSpot'] = float(wn8data['expSpot'])
                    data['wn8expWinRate'] = float(wn8data['expWinRate'])
                    data['wn8expDef'] = float(wn8data['expDef'])
                    data['wn8expFrag'] = float(wn8data['expFrag'])

                # is reserved?
                import xvm_tankcarousel.python.reserve as reserve
                data['isReserved'] = reserve.is_reserved(data['vehCD'])
                #log(data)

                res.append(data)

            ResMgr.purge(_VEHICLE_TYPE_XML_PATH + nation + '/components/guns.xml', True)

        vehinfo_short.checkNames(res)

    except Exception, ex:
        err(traceback.format_exc())

    # pprint(res[0])
    # pprint(res)
    global _vehicleInfoData
    _vehicleInfoData = {x['vehCD']:x for x in res}


def _getRanges(turret, gun, nation, vclass):
    visionRadius = firingRadius = artyRadius = 0
    gunsInfoPath = _VEHICLE_TYPE_XML_PATH + nation + '/components/guns.xml/shared/'

    # Turret-dependent
    visionRadius = int(turret['circularVisionRadius'])  # 240..420

    # Gun-dependent
    shots = gun['shots']
    for shot in shots:
        radius = int(shot['maxDistance'])
        if firingRadius < radius:
            firingRadius = radius  # 10000, 720, 395, 360, 350

        if vclass == 'SPG' and shot['shell']['kind'] == 'HIGH_EXPLOSIVE':
            try:    # faster way
                pitchLimit_rad = min(CONST_45_IN_RADIANS, -calcPitchLimitsFromDesc(0, gun['pitchLimits']))
            except Exception: # old way
                gunsInfoPath = _VEHICLE_TYPE_XML_PATH + nation + '/components/guns.xml/shared/'
                pitchLimit = ResMgr.openSection(gunsInfoPath + gun['name']).readInt('pitchLimits')
                pitchLimit = min(45, -pitchLimit)  # -35..-65
                pitchLimit_rad = radians(pitchLimit)

            radius = int(pow(shot['speed'], 2) * sin(2 * pitchLimit_rad) / shot['gravity'])
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
    if stock['maxHealth'] == top['maxHealth']:
        return TURRET_TYPE_ONLY_ONE

    if not top['unlocks']:
        return TURRET_TYPE_TOP_GUN_POSSIBLE

    stockMaxPrice = _getMaxGunPrice(nation, stock['guns'])
    topMaxPrice = _getMaxGunPrice(nation, top['guns'])

    if stockMaxPrice >= topMaxPrice:
        return TURRET_TYPE_TOP_GUN_POSSIBLE

    return TURRET_TYPE_NO_TOP_GUN


def _getMaxGunPrice(nation, guns):
    maxPrice = 0
    for gun in guns:
        price = _getGunPrice(nation, gun['name'])
        if maxPrice < price:
            maxPrice = price
    return maxPrice


def _getGunPrice(nation, gunName):
    xmlPath = _VEHICLE_TYPE_XML_PATH + nation + '/components/guns.xml'
    return ResMgr.openSection(xmlPath + '/shared/' + gunName).readInt('price')
