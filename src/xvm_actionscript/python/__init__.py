"""
SPDX-License-Identifier: LGPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

import xfwview

from swf import *
from swfloadedinfo import *

__all__ = [
    # swf
    'as_xfw_cmd',
    'as_event',
    'as_callback',

    #swfloadedinfo
    'swf_loaded_info',
]



#
# OpenWG API
#

__initialized = False

def owg_module_loaded():
    global __initialized
    return __initialized


def owg_module_init():
    global __initialized
    __initialized = True
    return __initialized


def owg_module_event(eventName, *args, **kwargs):
    pass


def owg_module_fini():
    pass
