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

_ping_native = None

def _native_load():
    """
    Loads Ping extension.

    Do not use this function directly.
    """
    try:
        global _ping_native

        if _ping_native is None:

            if "python27" not in sys.modules:
                return False

            path_realfs = PATH.XFWLOADER_PACKAGES_REALFS + '/xfw_ping/native/xfw_ping.pyd'
            path_vfs = PATH.XFWLOADER_PACKAGES_VFS + '/xfw_ping/native/xfw_ping.pyd'

            if os.path.isfile(path_realfs):
                _ping_native = imp.load_dynamic('XFW_Ping', path_realfs)
            else:
                import xfw.vfs as vfs
                _ping_native = vfs.c_extension_load('XFW_Ping', path_vfs, 'com.modxvm.xfw.ping')

        return True
    except Exception:
        print "[XFW/Ping][_native_load] Error when load native library"
        traceback.print_exc()
        print "======================="
        return False

def ping(address, unlock_gil=True):
    """
    Send ping request to host

    usage: ping(<address>, [unlock_gil])
      address: host domain name or IP
      unlock_gil: unlock GIL when perform I/O operations, True/False, True by default.

    returns: ping time in msec

    examples:
      ping("127.0.0.1")
      ping("localhost",True)
    """
    try:
        if not _native_load():
            return None
        return _ping_native.ping(address, unlock_gil)
    except Exception:
        print "[XFW/Ping][ping] Error when pinging host"
        traceback.print_exc()
        print "======================="
