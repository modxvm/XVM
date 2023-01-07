"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2016-2022 XVM Contributors
"""

#
# Imports
#

import autologin
import version_label



#
# XFW API
#

__initialized = False

def xfw_module_init():
    global __initialized
    if not __initialized:
        autologin.init()
        version_label.init()
        __initialized = True
    

def xfw_module_fini():
    global __initialized
    if __initialized:
        autologin.fini()
        version_label.fini()
        __initialized = False


def xfw_is_module_loaded():
    global __initialized
    return __initialized
