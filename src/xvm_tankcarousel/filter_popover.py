"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

# stdlib
import json
import logging

# BigWorld
from account_helpers.AccountSettings import AccountSettings, DEFAULT_VALUES, KEY_FILTERS
from account_helpers.settings_core.ServerSettingsManager import ServerSettingsManager
from gui.shared.gui_items.dossier.achievements import MarkOfMasteryAchievement
from gui.shared.utils.functions import makeTooltip
from gui.shared.utils.requesters.ItemsRequester import REQ_CRITERIA
from gui.Scaleform.daapi.view.common.filter_popover import TankCarouselFilterPopover
from helpers import dependency
from skeletons.gui.shared import IItemsCache

# XFW
from xfw import *

# XVM Main
from xvm_main.utils import l10n
import xvm_main.userprefs as userprefs
import xvm_main.vehinfo as vehinfo

# XVM TankCarousel
from .consts import XVM_FILTER_ICON_MASK, PREFS, FILTER_KEYS_VO_OVERRIDES, USERPREFS, \
    _SUPPORTED_SECTIONS, _SUPPORTED_CLIENT_SECTIONS

# Per-realm
if IS_WG:
    # WG, since 1.27.0.0
    from gui.Scaleform.daapi.view.common.common_constants import FILTER_POPOVER_SECTION
else:
    # Lesta
    from gui.Scaleform.daapi.view.common.filter_popover import FILTER_SECTION as FILTER_POPOVER_SECTION



#
# Handlers
#

def _ServerSettingsManager_getSection(base, self, section, defaults = None):
    result = base(self, section, defaults)
    if section in _SUPPORTED_SECTIONS:
        try:
            filterData = json.loads(userprefs.get(USERPREFS.CAROUSEL_FILTERS, '{}'))
            prefs = filterData.get('prefs', [])
        except Exception:
            logging.getLogger('XVM/TankCarousel/FilterPopover').exception('_ServerSettingsManager_getSection')
            prefs = []
        result.update({x: int(x in prefs) for x in PREFS.XVM_KEYS})
    return result


def _ServerSettingsManager_setSections(base, self, sections, settings):
    for section in sections:
        if section in _SUPPORTED_SECTIONS:
            try:
                prefs = [key for key, value in settings.iteritems() if key in PREFS.XVM_KEYS and value]
                settings = {key: value for key, value in settings.iteritems() if key not in PREFS.XVM_KEYS}
                userprefs.set(USERPREFS.CAROUSEL_FILTERS, json.dumps({'prefs': prefs}, separators=(',', ':')))
            except Exception:
                logging.getLogger('XVM/TankCarousel/FilterPopover').exception('_ServerSettingsManager_setSections')
    return base(self, sections, settings)


def _AccountSettings_setFilter(base, name, value):
    if name in _SUPPORTED_CLIENT_SECTIONS:
        value = {key: value for key, value in value.iteritems() if key not in PREFS.XVM_KEYS}
    base(name, value)


def _TankCarouselFilterPopover_generateMapping(base, cls, hasRented, hasEvent, hasRoles, *args, **kwargs):
    mapping = base(hasRented, hasEvent, hasRoles, *args, **kwargs)
    specials = mapping[FILTER_POPOVER_SECTION.SPECIALS]

    # These options available in tank carousel itself so we remove them from popover
    specials = [key for key in specials if key not in PREFS.TO_REMOVE]

    # After that we need to insert special and normal vehicles entry after premium or at the start
    premiumIndex = specials.index(PREFS.PREMIUM) + 1 if PREFS.PREMIUM in specials else 0
    specials[premiumIndex:premiumIndex] = PREFS.XVM_KEYS[:2]

    # Other options should be inserted after elite vehicles entry
    eliteIndex = specials.index(PREFS.ELITE) + 1 if PREFS.ELITE in specials else specials.index(PREFS.NORMAL) + 1
    specials[eliteIndex:eliteIndex] = PREFS.XVM_KEYS[2:]

    mapping[FILTER_POPOVER_SECTION.SPECIALS] = specials
    return mapping


# Filters:
#   Premium          Special       Normal    Elite    NonElite  [igr]
#   CompleteCrew     TrainingCrew  NoMaster  Reserve  Crystals  Rented
#   Paragons (Lesta)
def _TankCarouselFilterPopover_getInitialVO(base, self, filters, xpRateMultiplier):
    dataVO = base(self, filters, xpRateMultiplier)
    if PREFS.NORMAL in filters:
        mapping = self._mapping if IS_WG else self._VehiclesFilterPopover__mapping
        try:
            specialsVO = dataVO['specials']
            specialsSection = mapping[FILTER_POPOVER_SECTION.SPECIALS]

            for key, override in FILTER_KEYS_VO_OVERRIDES.iteritems():
                if key in specialsSection:
                    entryVO = specialsVO[specialsSection.index(key)]

                    icon = override.get('icon')
                    if icon is not None:
                        entryVO['value'] = XVM_FILTER_ICON_MASK % icon

                    tooltip = override.get('tooltip')
                    if tooltip is not None:
                        entryVO['tooltip'] = makeTooltip(l10n('%sHeader' % tooltip), l10n('%sBody' % tooltip))
        except Exception:
            logging.getLogger('XVM/TankCarousel/FilterPopover').exception('_TankCarouselFilterPopover_getInitialVO')
    return dataVO


# Apply XVM filters
def _BasicCriteriesGroup_update(base, self, filters):
    if not PREFS.NORMAL in filters:
        return base(self, filters)

    (premium, elite) = (filters[PREFS.PREMIUM], filters[PREFS.ELITE])
    (filters[PREFS.PREMIUM], filters[PREFS.ELITE]) = (False, False)
    base(self, filters)
    (filters[PREFS.PREMIUM], filters[PREFS.ELITE]) = (premium, elite)
    itemsCache = dependency.instance(IItemsCache)
    totalStats = itemsCache.items.getAccountDossier().getTotalStats()
    vehiclesStats = totalStats.getVehicles()
    self._criteria |= REQ_CRITERIA.CUSTOM(lambda x: _applyXvmFilter(x, filters, totalStats, vehiclesStats))



#
# Handlers/Internal
#

def _applyXvmFilter(item, filters, total_stats, vehiclesStats):
    premium = filters[PREFS.PREMIUM]
    special = filters[PREFS.SPECIAL]
    normal = filters[PREFS.NORMAL]
    elite = filters[PREFS.ELITE]
    nonElite = filters[PREFS.NON_ELITE]

    if elite and not premium:
        normal = True

    vdata = vehinfo.getVehicleInfoData(item.intCD)
    if vdata is None:
        logging.getLogger('XVM/TankCarousel/FilterPopover').warning('Cannot find VehicleInfoData for vehCD={}!'.format(item.intCD))
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

    if elite != nonElite:
        remove |= elite and not item.isElite
        remove |= nonElite and item.isElite

    stat = vehiclesStats.get(item.intCD)
    if stat:
        markOfMastery = total_stats.getMarkOfMasteryForVehicle(item.intCD)
        remove |= filters[PREFS.NO_MASTER] and markOfMastery == MarkOfMasteryAchievement.MARK_OF_MASTERY.MASTER

    remove |= filters[PREFS.FULL_CREW] and not item.isCrewFull

    if filters[PREFS.TRAINING_CREW]:
        isCrewTraining = False
        for _, tankman in item.crew:
            if tankman is None:
                isCrewTraining = True
                break
            if not tankman.isMaxRoleLevel:
                isCrewTraining = True
                break
        remove |= not isCrewTraining

    remove |= not filters[PREFS.RESERVE] and vdata['isReserved']
    # Next line will make xor filter: non_reserve <--> reserve
    # instead of non_reserve <--> non_reserve + reserve
    remove |= filters[PREFS.RESERVE] and not vdata['isReserved']

    return not remove


def init():
    for section in _SUPPORTED_SECTIONS:
        DEFAULT_VALUES[KEY_FILTERS][section].update({x: False for x in PREFS.XVM_KEYS})

    overrideMethod(ServerSettingsManager, 'getSection')(_ServerSettingsManager_getSection)
    overrideMethod(ServerSettingsManager, 'setSections')(_ServerSettingsManager_setSections)
    overrideStaticMethod(AccountSettings, 'setFilter')(_AccountSettings_setFilter)
    overrideMethod(TankCarouselFilterPopover, '_getInitialVO')(_TankCarouselFilterPopover_getInitialVO)
    overrideClassMethod(TankCarouselFilterPopover, '_generateMapping')(_TankCarouselFilterPopover_generateMapping)

    if IS_LESTA:
        from gui.Scaleform.daapi.view.common.vehicle_carousel.carousel_filter import BasicCriteriesGroup

        overrideMethod(BasicCriteriesGroup, 'update')(_BasicCriteriesGroup_update)


def fini():
    pass
