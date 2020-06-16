import ResMgr
import nations
from items import _xml
from helpers import dependency
from helpers.i18n import makeString
from constants import ITEM_DEFS_PATH
from skeletons.gui.shared import IItemsCache
from gui.shared.tooltips.shell import CommonStatsBlockConstructor
from gui.shared.tooltips import formatters
from gui.shared.formatters import text_styles
from gui.Scaleform.daapi.view.common.vehicle_carousel.carousel_data_provider import CarouselDataProvider
from gui.Scaleform.daapi.view.lobby.ModuleInfoWindow import ModuleInfoWindow

from xvm_main.python.logger import *
from xfw import *


shells = {}
myVehicles = set()


def getShots():
    xmlPath = '%svehicles/%s/components/guns.xml' % (ITEM_DEFS_PATH, nation)
    section = ResMgr.openSection(xmlPath)
    shared = section['shared']
    result = {}
    for gun, val in shared.items():
        shots = val['shots']
        result.update({shot: (result.get(shot, set()) | {gun}) for shot in shots.keys()})
    return result


def getGuns():
    xmlPath = '%svehicles/%s/list.xml' % (ITEM_DEFS_PATH, nation)
    vehicles = ResMgr.openSection(xmlPath)
    result = {}
    for veh, v_v in vehicles.items():
        if (veh == 'Observer') or (veh == 'xmlns:xmlref'):
            continue
        i18n_veh = v_v['userString'].asString
        xmlPath = '%svehicles/%s/%s.xml' % (ITEM_DEFS_PATH, nation, veh)
        vehicle = ResMgr.openSection(xmlPath)
        turrets0 = vehicle['turrets0']
        result.update({gun: (result.get(gun, set()) | {makeString(i18n_veh)}) for turret in turrets0.values() for gun in turret['guns'].keys()})
    return result


for nation in nations.NAMES:
    shots = getShots()
    guns = getGuns()
    shells[nation] = {}
    for k_s, v_s in shots.iteritems():
        for gun in v_s:
            shells[nation][k_s] = shells[nation].get(k_s, set()) | guns.get(gun, set())


@overrideMethod(CommonStatsBlockConstructor, 'construct')
def CommonStatsBlockConstructor_construct(base, self):
    block = base(self)
    if self.configuration.params:
        topPadding = formatters.packPadding(top=5)
        block.append(formatters.packTitleDescBlock(title=text_styles.middleTitle(makeString('#tooltips:quests/vehicles/header')), padding=formatters.packPadding(top=8)))
        n_shell = shells.get(self.shell.nationName, None)
        select_shell = n_shell.get(self.shell.name, set())
        if myVehicles:
            vehicles = select_shell & myVehicles
            block.append(formatters.packTitleDescBlock(title=text_styles.stats(', '.join(vehicles)), padding=topPadding))
            vehicles = select_shell - vehicles
            block.append(formatters.packTitleDescBlock(title=text_styles.standard(', '.join(vehicles)), padding=topPadding))
        else:
            block.append(formatters.packTitleDescBlock(title=text_styles.standard(', '.join(select_shell)), padding=topPadding))
    return block


def updateMyVehicles():
    global myVehicles
    itemsCache = dependency.instance(IItemsCache)
    vehicles = itemsCache.items.getVehicles()
    myVehicles = {v.userName for v in vehicles.itervalues() if v.invID >= 0}


@registerEvent(CarouselDataProvider, 'buildList')
def buildList(self):
    updateMyVehicles()
