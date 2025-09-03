"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

import battle
import battleloading
import fragCorrelationPanel



#
# OpenWG API
#

__initialized = False

def owg_module_init():
    global __initialized
    if not __initialized:
        battle.init()
        battleloading.init()
        fragCorrelationPanel.init()
        __initialized = True


def owg_module_fini():
    global __initialized
    if __initialized:
        battle.fini()
        battleloading.fini()
        fragCorrelationPanel.fini()
        __initialized = False


def owg_module_loaded():
    global __initialized
    return __initialized


def owg_module_event(eventName, *args, **kwargs):
    pass
