"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2024 XVM Contributors
"""

#
# XFW Mod initialization
#

__xvm_main_loaded = False

def xfw_module_init():
    from init import init
    init()

    global __xvm_main_loaded
    __xvm_main_loaded = True


def xfw_module_fini():
    from init import fini
    fini()

    global __xvm_main_loaded
    __xvm_main_loaded = False


def xfw_is_module_loaded():
    return __xvm_main_loaded
