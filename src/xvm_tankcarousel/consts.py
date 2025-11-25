"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

# stdlib
import importlib
import logging

# BigWorld
import gui.Scaleform.daapi.view.lobby.hangar.hangar_cm_handlers as hangar_cm_handlers
from account_helpers.AccountSettings import CAROUSEL_FILTER_2, RANKED_CAROUSEL_FILTER_2, EPICBATTLE_CAROUSEL_FILTER_2, MAPBOX_CAROUSEL_FILTER_2, FUN_RANDOM_CAROUSEL_FILTER_2, COMP7_CAROUSEL_FILTER_2
from account_helpers.AccountSettings import CAROUSEL_FILTER_CLIENT_1, RANKED_CAROUSEL_FILTER_CLIENT_1, EPICBATTLE_CAROUSEL_FILTER_CLIENT_1, BATTLEPASS_CAROUSEL_FILTER_CLIENT_1, MAPBOX_CAROUSEL_FILTER_CLIENT_1, FUN_RANDOM_CAROUSEL_FILTER_CLIENT_1, COMP7_CAROUSEL_FILTER_CLIENT_1

# XFW
from xfw import *



#
# Constants
#

XVM_LOBBY_SWF_FILENAME = 'xvm_lobby_ui.swf'
XVM_FILTER_ICON_MASK = '../../../mods/shared_resources/xvm/res/icons/carousel/filter/%s.png'

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

# WG-only filter popover sections
if IS_WG:
    _ADDITIONAL_SUPPORTED_SECTIONS = ()
    _ADDITIONAL_SUPPORTED_CLIENT_SECTIONS = ()
# Lesta-only filter popover sections
else:
    _ADDITIONAL_SUPPORTED_SECTIONS = (
        'VERSUS_AI_CAROUSEL_FILTER_2',
        'BOB_CAROUSEL_FILTER_2',
    )
    _ADDITIONAL_SUPPORTED_CLIENT_SECTIONS = (
        'VERSUS_AI_CAROUSEL_FILTER_CLIENT_1',
        'BOB_CAROUSEL_FILTER_CLIENT_1',
    )

for section in _ADDITIONAL_SUPPORTED_SECTIONS + _ADDITIONAL_SUPPORTED_CLIENT_SECTIONS:
    try:
        module = importlib.import_module('account_helpers.AccountSettings')
        filter = getattr(module, section, None)
        if filter is None:
            continue
        if section in _ADDITIONAL_SUPPORTED_SECTIONS:
            _SUPPORTED_SECTIONS += (filter, )
        if section in _ADDITIONAL_SUPPORTED_CLIENT_SECTIONS:
            _SUPPORTED_CLIENT_SECTIONS += (filter, )
    except ImportError:
        logging.getLogger('XVM/TankCarousel').exception('Section %s is missing', section)
    except Exception:
        logging.getLogger('XVM/TankCarousel').exception('filterSections')

class PREFS(object):
    # Standard
    BONUS = 'bonus'
    FAVORITE = 'favorite'
    PREMIUM = 'premium'
    ELITE = 'elite'
    RENTED = 'rented'
    CRYSTALS = 'crystals'
    EVENT = 'event'
    IGR = 'igr'
    PARAGONS = 'paragons'
    # Added by XVM
    SPECIAL = 'special'
    NORMAL = 'normal'
    NON_ELITE = 'nonelite'
    FULL_CREW = 'fullCrew'
    TRAINING_CREW = 'trainingCrew'
    NO_MASTER = 'noMaster'
    RESERVE = 'reserve'
    TO_REMOVE = [BONUS, FAVORITE]
    XVM_KEYS = [SPECIAL, NORMAL, NON_ELITE, FULL_CREW, TRAINING_CREW, NO_MASTER, RESERVE]

FILTER_KEYS_VO_OVERRIDES = {
    PREFS.PREMIUM: {'icon': 'premium', 'tooltip': 'PremiumTooltip'},
    PREFS.SPECIAL: {'icon': 'special', 'tooltip': 'SpecialTooltip'},
    PREFS.NORMAL: {'icon': 'normal', 'tooltip': 'NormalTooltip'},
    PREFS.ELITE: {'icon': 'elite'},
    PREFS.NON_ELITE: {'icon': 'nonelite', 'tooltip': 'NonEliteTooltip'},
    PREFS.FULL_CREW: {'icon': 'fullcrew', 'tooltip': 'CompleteCrewTooltip'},
    PREFS.TRAINING_CREW: {'icon': 'trainingcrew', 'tooltip': 'TrainingCrewTooltip'},
    PREFS.NO_MASTER: {'icon': 'nomaster', 'tooltip': 'NoMasterTooltip'},
    PREFS.RESERVE: {'icon': 'reserve', 'tooltip': 'ReserveFilterTooltip'},
    PREFS.CRYSTALS: {'icon': 'crystals'},
    PREFS.RENTED: {'icon': 'rented'}
}

class USERPREFS(object):
    CAROUSEL_FILTERS = "users/{accountDBID}/tankcarousel/filters"


class AS_SYMBOLS(object):
    AS_XVM_TANK_CAROUSEL = 'com.xvm.lobby.ui.tankcarousel::UI_TankCarousel'


class XVM_CAROUSEL_COMMAND(object):
    GET_USED_SLOTS_COUNT = 'xvm_carousel.get_used_slots_count'
    GET_TOTAL_SLOTS_COUNT = 'xvm_carousel.get_total_slots_count'


class VEHICLE(object):
    CHECK_RESERVE = 'confirmReserveVehicle'
    UNCHECK_RESERVE = 'uncheckReserveVehicle'

VEHICLE_FAVOURITE_OPTIONS = (hangar_cm_handlers.VEHICLE.CHECK, hangar_cm_handlers.VEHICLE.UNCHECK, )
