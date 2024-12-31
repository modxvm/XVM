"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

import xfw_loader.python as xfw_loader


#
# Globals
#

__python_macro = None
__python_macro_checked = False


#
# Public
#

def process_python_macro(arg):
    global __python_macro
    global __python_macro_checked

    if not __python_macro_checked and __python_macro is None:
            __python_macro = xfw_loader.get_mod_module('com.modxvm.xvm.pymacro')
            __python_macro_checked = True

    if __python_macro is None:
        return None

    return __python_macro.process(arg)
