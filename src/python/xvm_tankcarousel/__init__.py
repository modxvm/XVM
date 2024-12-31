"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

# XVM Main
import xvm_main.python.config as config

# XVM TankCarousel
import tankcarousel
import filter_popover



#
# XFW API
#

__initialized = False

def xfw_module_init():
    global __initialized
    if not __initialized:
        if config.get('hangar/carousel/enabled'):
            tankcarousel.init()
            filter_popover.init()

        __initialized = True


def xfw_module_fini():
    global __initialized
    if __initialized:
        if config.get('hangar/carousel/enabled'):
            tankcarousel.fini()
            filter_popover.fini()

        __initialized = False


def xfw_is_module_loaded():
    global __initialized
    return __initialized
