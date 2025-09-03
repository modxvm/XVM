"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# OpenWG API
#

__xvm_main_loaded = False

def owg_module_loaded():
    global __xvm_main_loaded
    return __xvm_main_loaded


def owg_module_init():
    from init import init
    init()

    global __xvm_main_loaded
    __xvm_main_loaded = True
    return __xvm_main_loaded

def owg_module_event(eventName, *args, **kwargs):
    pass

def owg_module_fini():
    from init import fini
    fini()

    global __xvm_main_loaded
    __xvm_main_loaded = False
