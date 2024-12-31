"""
SPDX-License-Identifier: LGPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

import sys

#
# XFW Loader
#

__xfw_libraries_initialized = False

def xfw_is_module_loaded():
    global __xfw_libraries_initialized
    return __xfw_libraries_initialized

def xfw_module_init():
    sys.path.insert(0, 'mods/xfw_libraries')
    sys.path.insert(0, 'res_mods/mods/xfw_libraries')
    
    global __xfw_libraries_initialized
    __xfw_libraries_initialized = True
