"""
This file is part of the XVM project.

Copyright (c) 2013-2021 XVM Team.

XVM is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as
published by the Free Software Foundation, version 3.

XVM is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
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
