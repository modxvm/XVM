"""
This file is part of the XVM Framework project.

Copyright (c) 2018-2019 XVM Team.

XVM Framework is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as
published by the Free Software Foundation, version 3.

XVM Framework is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
"""

import imp
import os
import platform
import traceback
import sys

from xfw.constants import PATH

_native = None

def _native_load():
    """
    Loads WoTFix C Python extension.

    Do not use this function directly.
    """
    try:
        global _native

        if _native is None:

            if "python27" not in sys.modules:
                return False

            path_realfs = PATH.XFWLOADER_PACKAGES_REALFS + '/xfw_wotfix_hidpi/native/xfw_hidpi.pyd'
            path_vfs = PATH.XFWLOADER_PACKAGES_VFS + '/xfw_wotfix_hidpi/native/xfw_hidpi.pyd'

            if os.path.isfile(path_realfs):
                _native = imp.load_dynamic('XFW_HiDPI', path_realfs)
            else:
                import xfw.vfs as vfs
                _native = vfs.c_extension_load('XFW_HiDPI', path_vfs, 'com.modxvm.xfw.wotfix.hidpi')

        return True
    except Exception:
        print "[XFW/HiDPI][_native_load] Error when loading native library:"
        traceback.print_exc()
        print "======================="
        return False

def fix_dpi():
    try:
        if not platform.version().startswith('5.'):
            if not _native_load():
                return
            if _native.fix_dpi():
                print "[XFW/HiDPI] HiDPI fix applied"

    except Exception:
        print "[XFW/HiDPI][fix_dpi] Error:"
        traceback.print_exc()
        print "======================="

fix_dpi()
