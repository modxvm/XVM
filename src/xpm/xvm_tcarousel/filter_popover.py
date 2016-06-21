""" XVM (c) www.modxvm.com 2013-2016 """

import itertools
import simplejson

from account_helpers.AccountSettings import DEFAULT_VALUES, KEY_FILTERS, CAROUSEL_FILTER_2, FALLOUT_CAROUSEL_FILTER_2
from account_helpers.settings_core.ServerSettingsManager import ServerSettingsManager
from gui.server_events import g_eventsCache
from gui.shared import g_itemsCache
from gui.shared.gui_items.dossier.achievements import MarkOfMasteryAchievement
from gui.shared.utils.functions import makeTooltip
from gui.shared.utils.requesters.ItemsRequester import REQ_CRITERIA
import gui.Scaleform.daapi.view.lobby.hangar.filter_popover as filter_popover
from gui.Scaleform.daapi.view.lobby.hangar.filter_popover import FilterPopover, _SECTIONS, _SECTIONS_MAP
# TODO:0.9.15.1
#from gui.Scaleform.daapi.view.lobby.hangar.tank_carousel_filter import CarouselFilter

from xfw import *

from xvm_main.python.logger import *
from xvm_main.python.xvm import l10n
import xvm_main.python.userprefs as userprefs
import xvm_main.python.vehinfo as vehinfo


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

USERPREFS_CAROUSEL_FILTERS_KEY = "tcarousel.filters"


# Update original settings

DEFAULT_VALUES[KEY_FILTERS][CAROUSEL_FILTER_2].update({x:False for x in PREFS.XVM_KEYS})
DEFAULT_VALUES[KEY_FILTERS][FALLOUT_CAROUSEL_FILTER_2].update({x:False for x in PREFS.XVM_KEYS})


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
#   [event]
@overrideMethod(filter_popover, '_getInitialVO')
def _filter_popover_getInitialVO(base, filters, hasRentedVehicles):
    try:
        data = base(filters, hasRentedVehicles)

        #debug(data)

        premium = data['specialTypeLeft'][0]
        normal = {'label': l10n('Normal'), 'tooltip': makeTooltip(l10n('NormalTooltipHeader'), l10n('NormalTooltipBody')), 'selected': filters[PREFS.NORMAL]}
        elite = data['specialTypeRight'][0]
        non_elite = {'label': l10n('NonElite'), 'tooltip': makeTooltip(l10n('NonEliteTooltipHeader'), l10n('NonEliteTooltipBody')), 'selected': filters[PREFS.NON_ELITE]}
        complete_crew = {'label': l10n('CompleteCrew'), 'tooltip': makeTooltip(l10n('CompleteCrewTooltipHeader'), l10n('CompleteCrewTooltipBody')), 'selected': filters[PREFS.FULL_CREW]}
        no_master = {'label': l10n('NoMaster'), 'tooltip': makeTooltip(l10n('NoMasterTooltipHeader'), l10n('NoMasterTooltipBody')), 'selected': filters[PREFS.NO_MASTER]}
        reserve = {'label': l10n('ReserveFilter'), 'tooltip': makeTooltip(l10n('ReserveFilterTooltipHeader'), l10n('ReserveFilterTooltipBody')), 'selected': filters[PREFS.RESERVE]}

        is_event = PREFS.EVENT in _SECTIONS_MAP[_SECTIONS.SPECIAL_LEFT]
        if is_event:
            event = data['specialTypeLeft'][1]
        
        is_igr = PREFS.IGR in _SECTIONS_MAP[_SECTIONS.SPECIAL_RIGHT]
        if is_igr:
            igr = data['specialTypeRight'][1]

        data['specialTypeLeft'] = [premium, elite, complete_crew, reserve]
        data['specialTypeRight'] = [normal, non_elite, no_master]

        if is_event:
            data['specialTypeLeft'] += [event]

        if is_igr:
            data['specialTypeRight'] += [igr]

        return data
    except Exception as ex:
        err('_filter_popover_getInitialVO() exception: ' + traceback.format_exc())
        return base(filters, hasRentedVehicles)

# Apply XVM filters
# TODO:0.9.15.1
#@overrideMethod(CarouselFilter, 'getCriteria')
def _CarouselFilter_getCriteria(base, self):
    premium = self._filters['premium']
    elite = self._filters['elite']
    self._filters['premium'] = False
    self._filters['elite'] = False
    criteria = base(self)
    self._filters['premium'] = premium
    self._filters['elite'] = elite
    vehicles_stats = g_itemsCache.items.getAccountDossier().getRandomStats().getVehicles()
    criteria |= REQ_CRITERIA.CUSTOM(lambda x: _applyXvmFilter(x, self._filters, vehicles_stats))
    return criteria

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

# View class
class XvmTankCarouselFilterPopover(FilterPopover):
    def __init__(self, ctx = None):
        #log('XvmTankCarouselFilterPopover')
        super(XvmTankCarouselFilterPopover, self).__init__(ctx)

        is_event = PREFS.EVENT in _SECTIONS_MAP[_SECTIONS.SPECIAL_LEFT]
        is_igr = PREFS.IGR in _SECTIONS_MAP[_SECTIONS.SPECIAL_RIGHT]

        _SECTIONS_MAP[_SECTIONS.SPECIAL_LEFT] = (PREFS.PREMIUM, PREFS.ELITE, PREFS.FULL_CREW, PREFS.RESERVE,)
        _SECTIONS_MAP[_SECTIONS.SPECIAL_RIGHT] = (PREFS.NORMAL, PREFS.NON_ELITE, PREFS.NO_MASTER,)
        
        if is_event:
            _SECTIONS_MAP[_SECTIONS.SPECIAL_LEFT] += (PREFS.EVENT,)
        
        if is_igr:
            _SECTIONS_MAP[_SECTIONS.SPECIAL_RIGHT] += (PREFS.IGR,)

        self._FilterPopover__popoverFilers = set(itertools.chain.from_iterable(_SECTIONS_MAP.values()))
        return
