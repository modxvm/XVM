"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2024 XVM Contributors
"""

#####################################################################
# imports

import traceback
import json

from account_helpers.AccountSettings import AccountSettings, DEFAULT_VALUES, KEY_FILTERS
from account_helpers.AccountSettings import CAROUSEL_FILTER_2, RANKED_CAROUSEL_FILTER_2, EPICBATTLE_CAROUSEL_FILTER_2, MAPBOX_CAROUSEL_FILTER_2, FUN_RANDOM_CAROUSEL_FILTER_2, COMP7_CAROUSEL_FILTER_2
from account_helpers.AccountSettings import CAROUSEL_FILTER_CLIENT_1, RANKED_CAROUSEL_FILTER_CLIENT_1, EPICBATTLE_CAROUSEL_FILTER_CLIENT_1, BATTLEPASS_CAROUSEL_FILTER_CLIENT_1, MAPBOX_CAROUSEL_FILTER_CLIENT_1, FUN_RANDOM_CAROUSEL_FILTER_CLIENT_1, COMP7_CAROUSEL_FILTER_CLIENT_1
from account_helpers.settings_core.ServerSettingsManager import ServerSettingsManager
from gui.shared.gui_items.dossier.achievements import MarkOfMasteryAchievement
from gui.shared.utils.functions import makeTooltip
from gui.shared.utils.requesters.ItemsRequester import REQ_CRITERIA
from gui.Scaleform.daapi.view.common.filter_popover import TankCarouselFilterPopover, FILTER_SECTION
from gui.Scaleform.daapi.view.common.vehicle_carousel.carousel_filter import BasicCriteriesGroup
from helpers import dependency
from skeletons.gui.shared import IItemsCache

from xfw import *

from xvm_main.python.logger import *
from xvm_main.python.xvm import l10n
import xvm_main.python.userprefs as userprefs
import xvm_main.python.vehinfo as vehinfo


#####################################################################
# constants

class PREFS(object):
    # standard
    PREMIUM = 'premium'
    ELITE = 'elite'
    RENTED = 'rented'
    CRYSTALS = 'crystals'
    EVENT = 'event'
    IGR = 'igr'
    # added by XVM
    NORMAL = 'normal'
    SPECIAL = 'special'
    NON_ELITE = 'nonelite'
    FULL_CREW = 'fullCrew'
    TRAINING_CREW = 'trainingCrew'
    NO_MASTER = 'noMaster'
    RESERVE = 'reserve'
    XVM_KEYS = (NORMAL, SPECIAL, NON_ELITE, FULL_CREW, TRAINING_CREW, NO_MASTER, RESERVE)

class USERPREFS(object):
    CAROUSEL_FILTERS = "users/{accountDBID}/tankcarousel/filters"

_SUPPORTED_SECTIONS = (
    CAROUSEL_FILTER_2,
    RANKED_CAROUSEL_FILTER_2,
    EPICBATTLE_CAROUSEL_FILTER_2,
    MAPBOX_CAROUSEL_FILTER_2,
    FUN_RANDOM_CAROUSEL_FILTER_2,
    COMP7_CAROUSEL_FILTER_2,
)

_SUPPORTED_CLIENT_SECTIONS = (
    CAROUSEL_FILTER_CLIENT_1,
    RANKED_CAROUSEL_FILTER_CLIENT_1,
    EPICBATTLE_CAROUSEL_FILTER_CLIENT_1,
    BATTLEPASS_CAROUSEL_FILTER_CLIENT_1,
    MAPBOX_CAROUSEL_FILTER_CLIENT_1,
    FUN_RANDOM_CAROUSEL_FILTER_CLIENT_1,
    COMP7_CAROUSEL_FILTER_CLIENT_1,
)

# Lesta-only filter popover sections
if getRegion() == 'RU':
    from account_helpers.AccountSettings import VERSUS_AI_CAROUSEL_FILTER_2
    from account_helpers.AccountSettings import VERSUS_AI_CAROUSEL_FILTER_CLIENT_1

    _ADDITIONAL_SUPPORTED_SECTIONS = (
        VERSUS_AI_CAROUSEL_FILTER_2,
    )
    _ADDITIONAL_SUPPORTED_CLIENT_SECTIONS = (
        VERSUS_AI_CAROUSEL_FILTER_CLIENT_1,
    )
# WG-only filter popover sections
else:
    _ADDITIONAL_SUPPORTED_SECTIONS = ()
    _ADDITIONAL_SUPPORTED_CLIENT_SECTIONS = ()

_SUPPORTED_SECTIONS += _ADDITIONAL_SUPPORTED_SECTIONS
_SUPPORTED_CLIENT_SECTIONS += _ADDITIONAL_SUPPORTED_CLIENT_SECTIONS

#####################################################################
# initialization/finalization

# Update original settings

for section in _SUPPORTED_SECTIONS:
    DEFAULT_VALUES[KEY_FILTERS][section].update({x: False for x in PREFS.XVM_KEYS})

#####################################################################
# handlers

@overrideMethod(ServerSettingsManager, 'getSection')
def _ServerSettingsManager_getSection(base, self, section, defaults = None):
    res = base(self, section, defaults)
    if section in _SUPPORTED_SECTIONS:
        try:
            filterData = json.loads(userprefs.get(USERPREFS.CAROUSEL_FILTERS, '{}'))
            prefs = filterData.get('prefs', [])
        except Exception as ex:
            err(traceback.format_exc())
            prefs = []
        res.update({x: int(x in prefs) for x in PREFS.XVM_KEYS})
    return res

@overrideMethod(ServerSettingsManager, 'setSections')
def _ServerSettingsManager_setSections(base, self, sections, settings):
    for section in sections:
        if section in _SUPPORTED_SECTIONS:
            try:
                prefs = [key for key, value in settings.iteritems() if key in PREFS.XVM_KEYS and value]
                settings = {key: value for key, value in settings.iteritems() if key not in PREFS.XVM_KEYS}
                userprefs.set(USERPREFS.CAROUSEL_FILTERS, json.dumps({'prefs': prefs}, separators=(',', ':')))
            except Exception as ex:
                err(traceback.format_exc())
    return base(self, sections, settings)

@overrideStaticMethod(AccountSettings, 'setFilter')
def _AccountSettings_setFilter(base, name, value):
    if name in _SUPPORTED_CLIENT_SECTIONS:
        value = {key: value for key, value in value.iteritems() if key not in PREFS.XVM_KEYS}
    base(name, value)

# Filters:
#   Premium       Special       Normal    Elite    NonElite  [igr]
#   CompleteCrew  TrainingCrew  NoMaster  Reserve  Crystals  Rented
@overrideMethod(TankCarouselFilterPopover, '_getInitialVO')
def _TankCarouselFilterPopover_getInitialVO(base, self, filters, xpRateMultiplier):
    data = base(self, filters, xpRateMultiplier)
    if PREFS.NORMAL in filters:
        mapping = self._VehiclesFilterPopover__mapping
        #debug(data['specials'])
        #debug(mapping)
        try:
            premium = data['specials'][mapping[FILTER_SECTION.SPECIALS].index(PREFS.PREMIUM)]
            premium = {'value': '../../../mods/shared_resources/xvm/res/icons/carousel/filter/premium.png', 'tooltip': makeTooltip(l10n('PremiumTooltipHeader'), l10n('PremiumTooltipBody'))}
            special = {'value': '../../../mods/shared_resources/xvm/res/icons/carousel/filter/special.png', 'tooltip': makeTooltip(l10n('SpecialTooltipHeader'), l10n('SpecialTooltipBody')), 'selected': filters[PREFS.SPECIAL]}
            normal = {'value': '../../../mods/shared_resources/xvm/res/icons/carousel/filter/normal.png', 'tooltip': makeTooltip(l10n('NormalTooltipHeader'), l10n('NormalTooltipBody')), 'selected': filters[PREFS.NORMAL]}
            elite = data['specials'][mapping[FILTER_SECTION.SPECIALS].index(PREFS.ELITE)]
            elite['value'] = '../../../mods/shared_resources/xvm/res/icons/carousel/filter/elite.png'
            non_elite = {'value': '../../../mods/shared_resources/xvm/res/icons/carousel/filter/nonelite.png', 'tooltip': makeTooltip(l10n('NonEliteTooltipHeader'), l10n('NonEliteTooltipBody')), 'selected': filters[PREFS.NON_ELITE]}
            full_crew = {'value': '../../../mods/shared_resources/xvm/res/icons/carousel/filter/fullcrew.png', 'tooltip': makeTooltip(l10n('CompleteCrewTooltipHeader'), l10n('CompleteCrewTooltipBody')), 'selected': filters[PREFS.FULL_CREW]}
            training_crew = {'value': '../../../mods/shared_resources/xvm/res/icons/carousel/filter/trainingcrew.png', 'tooltip': makeTooltip(l10n('TrainingCrewTooltipHeader'), l10n('TrainingCrewTooltipBody')), 'selected': filters[PREFS.TRAINING_CREW]}
            no_master = {'value': '../../../mods/shared_resources/xvm/res/icons/carousel/filter/nomaster.png', 'tooltip': makeTooltip(l10n('NoMasterTooltipHeader'), l10n('NoMasterTooltipBody')), 'selected': filters[PREFS.NO_MASTER]}
            reserve = {'value': '../../../mods/shared_resources/xvm/res/icons/carousel/filter/reserve.png', 'tooltip': makeTooltip(l10n('ReserveFilterTooltipHeader'), l10n('ReserveFilterTooltipBody')), 'selected': filters[PREFS.RESERVE]}
            crystals = data['specials'][mapping[FILTER_SECTION.SPECIALS].index(PREFS.CRYSTALS)]
            crystals['value'] = '../../../mods/shared_resources/xvm/res/icons/carousel/filter/crystals.png'
            rented = data['specials'][mapping[FILTER_SECTION.SPECIALS].index(PREFS.RENTED)]
            rented['value'] = '../../../mods/shared_resources/xvm/res/icons/carousel/filter/rented.png'

            is_igr = PREFS.IGR in mapping[FILTER_SECTION.SPECIALS]
            if is_igr:
                igr = data['specials'][-1]
            data['specials'] = [
                premium, special, normal, elite, non_elite,
                full_crew, training_crew, no_master, reserve, crystals,
                rented]
            if is_igr:
                data['specials'].append(igr)
        except Exception as ex:
            err('_TankCarouselFilterPopover_getInitialVO() exception: ' + traceback.format_exc())
    return data

@overrideClassMethod(TankCarouselFilterPopover, '_generateMapping')
def _TankCarouselFilterPopover_generateMapping(base, cls, hasRented, hasEvent, hasRoles, **kwargs):
    mapping = base(hasRented, hasEvent, hasRoles, **kwargs)
    is_igr = PREFS.IGR in mapping[FILTER_SECTION.SPECIALS]
    mapping[FILTER_SECTION.SPECIALS] = [
        PREFS.PREMIUM, PREFS.SPECIAL, PREFS.NORMAL, PREFS.ELITE, PREFS.NON_ELITE,
        PREFS.FULL_CREW, PREFS.TRAINING_CREW, PREFS.NO_MASTER, PREFS.RESERVE, PREFS.CRYSTALS,
        PREFS.RENTED]
    if is_igr:
        mapping[FILTER_SECTION.SPECIALS].append(PREFS.IGR)
    return mapping

# Apply XVM filters
@overrideMethod(BasicCriteriesGroup, 'update')
def _BasicCriteriesGroup_update(base, self, filters):
    if not PREFS.NORMAL in filters:
        return base(self, filters)

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
    special = filters[PREFS.SPECIAL]
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

    # isPremium include 'premium' and 'special' vehicles
    if premium and special and normal:
        pass
    elif premium and special:
        remove |= not item.isPremium
    elif premium and normal:
        remove |= vdata['special']
    elif special and normal:
        remove |= vdata['premium']
    else:
        remove |= premium and not vdata['premium']
        remove |= special and not vdata['special']
        remove |= normal and item.isPremium

    if elite != non_elite:
        remove |= elite and not item.isElite
        remove |= non_elite and item.isElite

    stat = vehicles_stats.get(item.intCD)
    if stat:
        mark_of_mastery = total_stats.getMarkOfMasteryForVehicle(item.intCD)
        remove |= filters[PREFS.NO_MASTER] and mark_of_mastery == MarkOfMasteryAchievement.MARK_OF_MASTERY.MASTER

    remove |= filters[PREFS.FULL_CREW] and not item.isCrewFull

    if filters[PREFS.TRAINING_CREW]:
        isCrewTraining = False
        for slotIdx, crewman in item.crew:
            if crewman is None:
                isCrewTraining = True
                break
            if not crewman.isMaxRoleLevel:
                isCrewTraining = True
                break
        remove |= not isCrewTraining

    remove |= not filters[PREFS.RESERVE] and vdata['isReserved']
    # next line will make xor filter: non_reserve <--> reserve,
    # instead of non_reserve <--> non_reserve + reserve
    remove |= filters[PREFS.RESERVE] and not vdata['isReserved']

    return not remove
