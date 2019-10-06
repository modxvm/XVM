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

_mutex_native = None

def _native_load():
    """
    Loads mutex C Python extension.

    Do not use this function directly.
    """
    try:
        global _mutex_native
        if _mutex_native is None:
            
            if "python27" not in sys.modules:
                return False

            path_realfs = PATH.XFWLOADER_PACKAGES_REALFS + '/xfw_mutex/native/xfw_mutex.pyd'
            path_vfs = PATH.XFWLOADER_PACKAGES_VFS + '/xfw_mutex/native/xfw_mutex.pyd'

            if os.path.isfile(path_realfs):
                _mutex_native = imp.load_dynamic('XFW_Mutex', path_realfs)
            else:
                import xfw.vfs as vfs
                _mutex_native = vfs.c_extension_load('XFW_Mutex', path_vfs, 'com.modxvm.xfw.mutex')

        return True
    except Exception:
        print "[XFW/Mutex][_native_load] Error when loading native library:"
        traceback.print_exc()
        print "======================="
        return False

def allow_multiple_wot():
    """
    Allows to run another World of Tanks instance

    usage: allow_multiple_wot()
    """
    try:
        if not _native_load():
            return
        return _mutex_native.allow_multiple_wot()
    except Exception:
        print "[XFW/Mutex][allow_multiple_wot] Error when changing mutex state:"
        traceback.print_exc()
        print "======================="

def restart_without_mods():
    """
    Restarts World of Tanks without mods

    usage: restart_without_mods()
    """
    try:
        if not _native_load():
            return
        return _mutex_native.restart_without_mods()
    except Exception:
        print "[XFW/Mutex][restart_without_mods] Error when restarting wot without mods:"
        traceback.print_exc()
        print "======================="
