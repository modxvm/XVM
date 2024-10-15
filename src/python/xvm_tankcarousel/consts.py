"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2024 XVM Contributors
"""

#
# Imports
#

# stdlib
import logging

# BigWorld
from account_helpers.AccountSettings import CAROUSEL_FILTER_2, RANKED_CAROUSEL_FILTER_2, EPICBATTLE_CAROUSEL_FILTER_2, MAPBOX_CAROUSEL_FILTER_2, FUN_RANDOM_CAROUSEL_FILTER_2, COMP7_CAROUSEL_FILTER_2
from account_helpers.AccountSettings import CAROUSEL_FILTER_CLIENT_1, RANKED_CAROUSEL_FILTER_CLIENT_1, EPICBATTLE_CAROUSEL_FILTER_CLIENT_1, BATTLEPASS_CAROUSEL_FILTER_CLIENT_1, MAPBOX_CAROUSEL_FILTER_CLIENT_1, FUN_RANDOM_CAROUSEL_FILTER_CLIENT_1, COMP7_CAROUSEL_FILTER_CLIENT_1



#
# Constants
#

XVM_LOBBY_SWF_FILENAME = 'xvm_lobby_ui.swf'

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
if getRegion() != 'RU':
    try:
        _ADDITIONAL_SUPPORTED_SECTIONS = ()
        _ADDITIONAL_SUPPORTED_CLIENT_SECTIONS = ()
    except Exception:
        logging.getLogger('XVM/TankCarousel').exception('filterSections/Wargaming')
# Lesta-only filter popover sections
else:
    try:
        from account_helpers.AccountSettings import VERSUS_AI_CAROUSEL_FILTER_2
        from account_helpers.AccountSettings import VERSUS_AI_CAROUSEL_FILTER_CLIENT_1

        _ADDITIONAL_SUPPORTED_SECTIONS = (
            VERSUS_AI_CAROUSEL_FILTER_2,
        )
        _ADDITIONAL_SUPPORTED_CLIENT_SECTIONS = (
            VERSUS_AI_CAROUSEL_FILTER_CLIENT_1,
        )
    except Exception:
        logging.getLogger('XVM/TankCarousel').exception('filterSections/Lesta')

_SUPPORTED_SECTIONS += _ADDITIONAL_SUPPORTED_SECTIONS
_SUPPORTED_CLIENT_SECTIONS += _ADDITIONAL_SUPPORTED_CLIENT_SECTIONS

class PREFS(object):
    # Standard
    PREMIUM = 'premium'
    ELITE = 'elite'
    RENTED = 'rented'
    CRYSTALS = 'crystals'
    EVENT = 'event'
    IGR = 'igr'
    # Added by XVM
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


class AS_SYMBOLS(object):
    AS_XVM_TANK_CAROUSEL = 'com.xvm.lobby.ui.tankcarousel::UI_TankCarousel'


class XVM_CAROUSEL_COMMAND(object):
    GET_USED_SLOTS_COUNT = 'xvm_carousel.get_used_slots_count'
    GET_TOTAL_SLOTS_COUNT = 'xvm_carousel.get_total_slots_count'


class VEHICLE(object):
    CHECK_RESERVE = 'confirmReserveVehicle'
    UNCHECK_RESERVE = 'uncheckReserveVehicle'
