"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Constants
#

class CREW(object):
    DROP_ALL_CREW = 'DropAllCrew'
    PUT_OWN_CREW = 'PutOwnCrew'
    PUT_BEST_CREW = 'PutBestCrew'
    PUT_CLASS_CREW = 'PutClassCrew'
    PUT_PREVIOUS_CREW = 'PutPreviousCrew'

class COMMANDS(object):
    PUT_PREVIOUS_CREW = 'xvm_crew.put_previous_crew'
    AS_VEHICLE_CHANGED = 'xvm_crew.as_vehicle_changed'
    AS_PUT_OWN_CREW = 'xvm_crew.as_put_own_crew'
    AS_PUT_BEST_CREW = 'xvm_crew.as_put_best_crew'
    AS_PUT_CLASS_CREW = 'xvm_crew.as_put_class_crew'

class USERPREFS(object):
    AUTO_PREV_CREW = "users/{accountDBID}/crew/auto_prev_crew/"
