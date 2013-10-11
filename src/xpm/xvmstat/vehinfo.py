""" xvm-stat (c) sirmax 2013 """

# PUBLIC

def getVehicleInfoData():
    global _vehicleInfoData
    if _vehicleInfoData is None:
        _vehicleInfoData = _init()
    return _vehicleInfoData

# PRIVATE

from pprint import pprint

import json
import traceback
import ResMgr
import nations
from items import vehicles

from vehinfo_tiers import getTiers

_vehicleInfoData = None

TURRET_TYPE_ONLY_ONE = 0
TURRET_TYPE_TOP_GUN_POSSIBLE = 1
TURRET_TYPE_NO_TOP_GUN = 2

_VEHICLE_TYPE_XML_PATH = 'scripts/item_defs/vehicles/'

def _init():
    res = []
    try:
        for nation in nations.NAMES:
            nationID = nations.INDICES[nation]
            for (id, descr) in vehicles.g_list.getList(nationID).iteritems():
                item = vehicles.g_cache.vehicle(nationID, id)

                data = dict()
                data['vid'] = descr['compactDescr']
                data['key'] = descr['name']
                data['nation'] = nation
                data['id'] = id
                data['level'] = descr['level']
                data['class'] = tuple(vehicles.VEHICLE_CLASS_TAGS & descr['tags'])[0]
                data['localizedName'] = descr['shortUserString']
                data['localizedFullName'] = descr['userString']
                data['premium'] = 'premium' in descr['tags']

                stockTurret = item.turrets[0][0]
                topTurret = item.turrets[0][-1]
                data['hpStock'] = item.hull['maxHealth'] + stockTurret['maxHealth']
                data['hpTop'] = item.hull['maxHealth'] + topTurret['maxHealth']
                data['turret'] = _getTurretType(item, nation)

                (data['tiersLo'], data['tiersHi']) = getTiers(data['level'], data['class'], data['key'])

    #            self.preferredName = ''
    #            self.shortName = ''

    #            self.avg = _StatValues()
    #            self.top = _StatValues()

                res.append(data)

            ResMgr.purge(_VEHICLE_TYPE_XML_PATH + nation + '/components/guns.xml', True)

    except Exception, ex:
        print traceback.format_exc(ex)

    #pprint(res[0])
    #pprint(res)
    return json.dumps(res)


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

    if stockMaxPrice <= topMaxPrice:
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
