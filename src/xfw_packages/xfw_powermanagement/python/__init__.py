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
import traceback
import sys

from xfw.constants import PATH

_native = None

def _native_load():
    """
    Loads Ping extension.

    Do not use this function directly.
    """
    try:
        global _native

        if _native is None:

            if "python27" not in sys.modules:
                return False

            path_realfs = PATH.XFWLOADER_PACKAGES_REALFS + '/xfw_powermanagement/native/xfw_powermanagement.pyd'
            path_vfs = PATH.XFWLOADER_PACKAGES_VFS + '/xfw_powermanagement/native/xfw_powermanagement.pyd'

            if os.path.isfile(path_realfs):
                _native = imp.load_dynamic('XFW_PowerManagement', path_realfs)
            else:
                import xfw.vfs as vfs
                _native = vfs.c_extension_load('XFW_PowerManagement', path_vfs, 'com.modxvm.xfw.powermanagement')

        return True
    except Exception:
        print "[XFW/PowerManagement][_native_load] Error when load native library"
        traceback.print_exc()
        print "======================="
        return False

def battery_info():
    try:
        if not _native_load():
            return None
        return _native.battery_info()
    except Exception:
        print "[XFW/PowerManagement][battery_info] Error"
        traceback.print_exc()
        print "======================="
