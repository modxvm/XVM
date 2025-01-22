"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

# XFW
from xfw import *

# XVM Battle Minimap
import minimap



#
# XFW API
#

__initialized = False

def xfw_module_init():
    global __initialized
    if not __initialized:
        if getRegion() == 'RU':
            minimap.init()
        __initialized = True


def xfw_module_fini():
    global __initialized
    if __initialized:
        if getRegion() == 'RU':
            minimap.fini()
        __initialized = False


def xfw_is_module_loaded():
    global __initialized
    return __initialized
