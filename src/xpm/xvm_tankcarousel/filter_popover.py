""" XVM (c) https://modxvm.com 2013-2019 """

#####################################################################
# imports

import itertools
import traceback
import simplejson

import constants
from account_helpers.AccountSettings import AccountSettings, DEFAULT_VALUES, KEY_FILTERS
from account_helpers.AccountSettings import CAROUSEL_FILTER_2, RANKED_CAROUSEL_FILTER_2, EPICBATTLE_CAROUSEL_FILTER_2
from account_helpers.AccountSettings import CAROUSEL_FILTER_CLIENT_1, RANKED_CAROUSEL_FILTER_CLIENT_1, EPICBATTLE_CAROUSEL_FILTER_CLIENT_1
from account_helpers.settings_core.ServerSettingsManager import ServerSettingsManager
from gui.shared.gui_items.dossier.achievements import MarkOfMasteryAchievement
from gui.shared.utils.functions import makeTooltip
from gui.shared.utils.requesters.ItemsRequester import REQ_CRITERIA
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.Scaleform.daapi.view.common.filter_popover import TankCarouselFilterPopover, _SECTION
from gui.Scaleform.daapi.view.common.vehicle_carousel.carousel_filter import BasicCriteriesGroup
from helpers import dependency
from skeletons.gui.shared import IItemsCache

from xfw import *

from xvm_main.python.logger import *
from xvm_main.python.xvm import l10n
import xvm_main.python.config as config
import xvm_main.python.userprefs as userprefs
import xvm_main.python.vehinfo as vehinfo


#####################################################################
# constants

class PREFS(object):
    # standard
    PREMIUM = 'premium'
    EVENT = 'event'
    ELITE = 'elite'
    IGR = 'igr'
    # added by XVM
    NORMAL = 'normal'
    NON_ELITE = 'nonelite'
    FULL_CREW = 'fullCrew'
    NO_MASTER = 'noMaster'
    RESERVE = 'reserve'
    XVM_KEYS = (NORMAL, NON_ELITE, FULL_CREW, NO_MASTER, RESERVE)

class USERPREFS(object):
    CAROUSEL_FILTERS = "users/{accountDBID}/tankcarousel/filters"


#####################################################################
# initialization/finalization

# Update original settings

DEFAULT_VALUES[KEY_FILTERS][CAROUSEL_FILTER_2].update({x:False for x in PREFS.XVM_KEYS})
DEFAULT_VALUES[KEY_FILTERS][RANKED_CAROUSEL_FILTER_2].update({x:False for x in PREFS.XVM_KEYS})
DEFAULT_VALUES[KEY_FILTERS][EPICBATTLE_CAROUSEL_FILTER_2].update({x:False for x in PREFS.XVM_KEYS})

#####################################################################
# handlers

@overrideMethod(ServerSettingsManager, 'getSection')
def _ServerSettingsManager_getSection(base, self, section, defaults = None):
    res = base(self, section, defaults)
    if section in (CAROUSEL_FILTER_2, RANKED_CAROUSEL_FILTER_2, EPICBATTLE_CAROUSEL_FILTER_2):
        try:
            filterData = simplejson.loads(userprefs.get(USERPREFS.CAROUSEL_FILTERS, '{}'))
            prefs = filterData.get('prefs', [])
        except Exception as ex:
            err(traceback.format_exc())
            prefs = []
        res.update({x:int(x in prefs) for x in PREFS.XVM_KEYS})
    return res

@overrideMethod(ServerSettingsManager, 'setSections')
def _ServerSettingsManager_setSections(base, self, sections, settings):
    for section in sections:
        if section in (CAROUSEL_FILTER_2, RANKED_CAROUSEL_FILTER_2, EPICBATTLE_CAROUSEL_FILTER_2):
            try:
                prefs = [key for key, value in settings.iteritems() if key in PREFS.XVM_KEYS and value]
                settings = {key: value for key, value in settings.iteritems() if key not in PREFS.XVM_KEYS}
                userprefs.set(USERPREFS.CAROUSEL_FILTERS, simplejson.dumps({'prefs':prefs}, separators=(',',':')))
            except Exception as ex:
                err(traceback.format_exc())
    return base(self, sections, settings)

@overrideStaticMethod(AccountSettings, 'setFilter')
def _AccountSettings_setFilter(base, name, value):
    if name in (CAROUSEL_FILTER_CLIENT_1, RANKED_CAROUSEL_FILTER_CLIENT_1, EPICBATTLE_CAROUSEL_FILTER_CLIENT_1):
        value = {key: value for key, value in value.iteritems() if key not in PREFS.XVM_KEYS}
    base(name, value)

# Filters:
#   Premium   Normal   Elite    NonElite    CompleteCrew
#   NoMaster  Reserve  [igr]
@overrideMethod(TankCarouselFilterPopover, '_getInitialVO')
def _TankCarouselFilterPopover_getInitialVO(base, self, filters, xpRateMultiplier):
    data = base(self, filters, xpRateMultiplier)
    mapping = self._VehiclesFilterPopover__mapping
    #debug(data['specials'])
    #debug(mapping)
    try:
        premium = data['specials'][mapping[_SECTION.SPECIALS].index(PREFS.PREMIUM)]
        premium['value'] = '../../../mods/shared_resources/xvm/res/icons/carousel/filter/premium.png'
        normal = {'value': '../../../mods/shared_resources/xvm/res/icons/carousel/filter/normal.png', 'tooltip': makeTooltip(l10n('NormalTooltipHeader'), l10n('NormalTooltipBody')), 'selected': filters[PREFS.NORMAL]}
        elite = data['specials'][mapping[_SECTION.SPECIALS].index(PREFS.ELITE)]
        elite['value'] = '../../../mods/shared_resources/xvm/res/icons/carousel/filter/elite.png'
        non_elite = {'value': '../../../mods/shared_resources/xvm/res/icons/carousel/filter/nonelite.png', 'tooltip': makeTooltip(l10n('NonEliteTooltipHeader'), l10n('NonEliteTooltipBody')), 'selected': filters[PREFS.NON_ELITE]}
        complete_crew = {'value': '../../../mods/shared_resources/xvm/res/icons/carousel/filter/fullcrew.png', 'tooltip': makeTooltip(l10n('CompleteCrewTooltipHeader'), l10n('CompleteCrewTooltipBody')), 'selected': filters[PREFS.FULL_CREW]}
        no_master = {'value': '../../../mods/shared_resources/xvm/res/icons/carousel/filter/nomaster.png', 'tooltip': makeTooltip(l10n('NoMasterTooltipHeader'), l10n('NoMasterTooltipBody')), 'selected': filters[PREFS.NO_MASTER]}
        reserve = {'value': '../../../mods/shared_resources/xvm/res/icons/carousel/filter/reserve.png', 'tooltip': makeTooltip(l10n('ReserveFilterTooltipHeader'), l10n('ReserveFilterTooltipBody')), 'selected': filters[PREFS.RESERVE]}

        is_igr = PREFS.IGR in mapping[_SECTION.SPECIALS]
        if is_igr:
            igr = data['specials'][-1]
        data['specials'] = [
            premium, normal, elite, non_elite, complete_crew,
            no_master, reserve]
        if is_igr:
            data['specials'].append(igr)
    except Exception as ex:
        err('_TankCarouselFilterPopover_getInitialVO() exception: ' + traceback.format_exc())
    return data

@overrideClassMethod(TankCarouselFilterPopover, '_generateMapping')
def _TankCarouselFilterPopover_generateMapping(base, cls, hasRented, hasEvent, isBattleRoyaleEnabled=False):
    mapping = base(hasRented, hasEvent, isBattleRoyaleEnabled=False)

    is_igr = PREFS.IGR in mapping[_SECTION.SPECIALS]
    mapping[_SECTION.SPECIALS] = [
        PREFS.PREMIUM,   PREFS.NORMAL, PREFS.ELITE, PREFS.NON_ELITE, PREFS.FULL_CREW,
        PREFS.NO_MASTER, PREFS.RESERVE]
    if is_igr:
        mapping[_SECTION.SPECIALS].append(PREFS.IGR)
    return mapping

# Apply XVM filters
@overrideMethod(BasicCriteriesGroup, 'update')
def _BasicCriteriesGroup_update(base, self, filters):
    (premium, elite) = (filters[PREFS.PREMIUM], filters[PREFS.ELITE])
    (filters[PREFS.PREMIUM], filters[PREFS.ELITE]) = (False, False)
    base(self, filters)
    (filters[PREFS.PREMIUM], filters[PREFS.ELITE]) = (premium, elite)
    itemsCache = dependency.instance(IItemsCache)
    total_stats = itemsCache.items.getAccountDossier().getTotalStats()
    vehicles_stats = total_stats.getVehicles()
    self._criteria |= REQ_CRITERIA.CUSTOM(lambda x: _applyXvmFilter(x, filters, total_stats, vehicles_stats))

def _applyXvmFilter(item, filters, total_stats, vehicles_stats):
    premium = filters[PREFS.PREMIUM]
    normal = filters[PREFS.NORMAL]
    elite = filters[PREFS.ELITE]
    non_elite = filters[PREFS.NON_ELITE]

    if elite and not premium:
        normal = True

    vdata = vehinfo.getVehicleInfoData(item.intCD)
    if vdata is None:
        warn('Cannot find VehicleInfoData for vehCD={}'.format(item.intCD))
        return True

    remove = False

    if premium != normal:
        remove |= premium and not item.isPremium
        remove |= normal and item.isPremium

    if elite != non_elite:
        remove |= elite and not item.isElite
        remove |= non_elite and item.isElite

    stat = vehicles_stats.get(item.intCD)
    if stat:
        mark_of_mastery = total_stats.getMarkOfMasteryForVehicle(item.intCD)
        remove |= filters[PREFS.NO_MASTER] and mark_of_mastery == MarkOfMasteryAchievement.MARK_OF_MASTERY.MASTER

    remove |= filters[PREFS.FULL_CREW] and not item.isCrewFull

    remove |= not filters[PREFS.RESERVE] and vdata['isReserved']
    # next line will make xor filter: non_reserve <--> reserve,
    # instead of non_reserve <--> non_reserve + reserve
    remove |= filters[PREFS.RESERVE] and not vdata['isReserved']

    return not remove
