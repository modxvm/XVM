""" XVM (c) www.modxvm.com 2013-2016 """

#####################################################################
# imports

import itertools
import simplejson

import constants
from account_helpers.AccountSettings import DEFAULT_VALUES, KEY_FILTERS, CAROUSEL_FILTER_2, FALLOUT_CAROUSEL_FILTER_2
from account_helpers.settings_core.ServerSettingsManager import ServerSettingsManager
from gui.shared import g_itemsCache
from gui.shared.gui_items.dossier.achievements import MarkOfMasteryAchievement
from gui.shared.utils.functions import makeTooltip
from gui.shared.utils.requesters.ItemsRequester import REQ_CRITERIA
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.Scaleform.daapi.view.lobby.hangar import filter_popover
from gui.Scaleform.daapi.view.lobby.hangar.filter_popover import FilterPopover, _SECTION
from gui.Scaleform.daapi.view.lobby.hangar.carousels.basic.carousel_filter import BasicCriteriesGroup

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
    FULL_CREW = 'fullCrew'
    RESERVE = 'reserve'
    NORMAL = 'normal'
    NON_ELITE = 'nonelite'
    NO_MASTER = 'noMaster'
    XVM_KEYS = (FULL_CREW, RESERVE, NORMAL, NON_ELITE, NO_MASTER)

USERPREFS_CAROUSEL_FILTERS_KEY = "tankcarousel/filters"


#####################################################################
# initialization/finalization

# Update original settings

DEFAULT_VALUES[KEY_FILTERS][CAROUSEL_FILTER_2].update({x:False for x in PREFS.XVM_KEYS})
DEFAULT_VALUES[KEY_FILTERS][FALLOUT_CAROUSEL_FILTER_2].update({x:False for x in PREFS.XVM_KEYS})


#####################################################################
# handlers

@overrideMethod(ServerSettingsManager, 'getSection')
def _ServerSettingsManager_getSection(base, self, section, defaults = None):
    res = base(self, section, defaults)
    if section in (CAROUSEL_FILTER_2, FALLOUT_CAROUSEL_FILTER_2):
        try:
            filterData = simplejson.loads(userprefs.get(USERPREFS_CAROUSEL_FILTERS_KEY, '{}'))
            prefs = filterData.get('prefs', [])
        except Exception as ex:
            prefs = []
        res.update({x:int(x in prefs) for x in PREFS.XVM_KEYS})
    return res

@overrideMethod(ServerSettingsManager, 'setSections')
def _ServerSettingsManager_setSections(base, self, sections, settings):
    for section in sections:
        if section in (CAROUSEL_FILTER_2, FALLOUT_CAROUSEL_FILTER_2):
            prefs = [key for key, value in settings.iteritems() if key in PREFS.XVM_KEYS and value]
            settings = {key: value for key, value in settings.iteritems() if key not in PREFS.XVM_KEYS}
            userprefs.set(USERPREFS_CAROUSEL_FILTERS_KEY, simplejson.dumps({'prefs':prefs}))
    return base(self, sections, settings)

# Filters:
#   Premium		Normal
#   Elite		NonElite
#   CompleteCrew	NoMaster
#   Reserve		[igr]
@overrideMethod(filter_popover, '_getInitialVO')
def _filter_popover_getInitialVO(base, filters, mapping, xpRateMultiplier):
    data = base(filters, mapping, xpRateMultiplier)
    #debug(data['specials'])
    #debug(mapping)
    try:
        premium = data['specials'][mapping[_SECTION.SPECIALS].index(PREFS.PREMIUM)]
        normal = {'label': l10n('Normal'), 'tooltip': makeTooltip(l10n('NormalTooltipHeader'), l10n('NormalTooltipBody')), 'selected': filters[PREFS.NORMAL]}
        elite = data['specials'][mapping[_SECTION.SPECIALS].index(PREFS.ELITE)]
        non_elite = {'label': l10n('NonElite'), 'tooltip': makeTooltip(l10n('NonEliteTooltipHeader'), l10n('NonEliteTooltipBody')), 'selected': filters[PREFS.NON_ELITE]}
        complete_crew = {'label': l10n('CompleteCrew'), 'tooltip': makeTooltip(l10n('CompleteCrewTooltipHeader'), l10n('CompleteCrewTooltipBody')), 'selected': filters[PREFS.FULL_CREW]}
        no_master = {'label': l10n('NoMaster'), 'tooltip': makeTooltip(l10n('NoMasterTooltipHeader'), l10n('NoMasterTooltipBody')), 'selected': filters[PREFS.NO_MASTER]}
        reserve = {'label': l10n('ReserveFilter'), 'tooltip': makeTooltip(l10n('ReserveFilterTooltipHeader'), l10n('ReserveFilterTooltipBody')), 'selected': filters[PREFS.RESERVE]}

        is_igr = PREFS.IGR in mapping[_SECTION.SPECIALS]
        if is_igr:
            igr = data['specials'][-1]

        data['specials'] = [
            premium,       normal, 
            elite,         non_elite, 
            complete_crew, no_master,
            reserve]

        if is_igr:
            data['specials'].append(igr)
    except Exception as ex:
        err('_filter_popover_getInitialVO() exception: ' + traceback.format_exc())
    return data

@overrideMethod(FilterPopover, '_FilterPopover__generateMapping')
def _FilterPopover__generateMapping(base, self, hasRented, hasEvent):
    base(self, hasRented, hasEvent)

    is_igr = PREFS.IGR in self._FilterPopover__mapping[_SECTION.SPECIALS]
    self._FilterPopover__mapping[_SECTION.SPECIALS] = [
        PREFS.PREMIUM,     PREFS.NORMAL, 
        PREFS.ELITE,       PREFS.NON_ELITE, 
        PREFS.FULL_CREW,   PREFS.NO_MASTER,
        PREFS.RESERVE]
    if is_igr:
        self._FilterPopover__mapping[_SECTION.SPECIALS].append(PREFS.IGR)
    self._FilterPopover__usedFilters = list(itertools.chain.from_iterable(self._FilterPopover__mapping.itervalues()))

# Apply XVM filters
@overrideMethod(BasicCriteriesGroup, 'update')
def _BasicCriteriesGroup_update(base, self, filters):
    (premium, elite) = (filters[PREFS.PREMIUM], filters[PREFS.ELITE])
    (filters[PREFS.PREMIUM], filters[PREFS.ELITE]) = (False, False)
    base(self, filters)
    (filters[PREFS.PREMIUM], filters[PREFS.ELITE]) = (premium, elite)
    vehicles_stats = g_itemsCache.items.getAccountDossier().getRandomStats().getVehicles()
    self._criteria |= REQ_CRITERIA.CUSTOM(lambda x: _applyXvmFilter(x, filters, vehicles_stats))

def _applyXvmFilter(item, filters, vehicles_stats):
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
        remove |= filters[PREFS.NO_MASTER] and stat.markOfMastery == MarkOfMasteryAchievement.MARK_OF_MASTERY.MASTER

    remove |= filters[PREFS.FULL_CREW] and not item.isCrewFull

    remove |= not filters[PREFS.RESERVE] and vdata['isReserved']
    # next line will make xor filter: non_reserve <--> reserve,
    # instead of non_reserve <--> non_reserve + reserve
    remove |= filters[PREFS.RESERVE] and not vdata['isReserved']

    return not remove
