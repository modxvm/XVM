"""
This file is part of the XVM Framework project.

Copyright (c) 2013-2019 XVM Team.

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

import os
import sys
import traceback

import ResMgr

if os.path.isfile(ResMgr.resolveToAbsolutePath('scripts/client/gui/mods/mod_xfw.pyc')):
    XFW_IN_PACKAGE = False
    XFW_ROOT_DIR = '../res_mods/mods/xfw'
    XFW_LIB_DIR  = '../res_mods/mods/xfw_libraries'
else:
    XFW_IN_PACKAGE = True
    XFW_ROOT_DIR = '../mods/xfw'
    XFW_LIB_DIR  = '../mods/xfw_libraries'

try:
    # native libraries loading
    try:
        import mod_xfw_native
        XFW_NATIVE_AVAILABLE = True
    except Exception:
        print "[XFW/Entrypoint] Native modules loading error. Some features will be unavailable."
        XFW_NATIVE_AVAILABLE = False

    sys.path.insert(0, '%s/python'     % XFW_ROOT_DIR)
    sys.path.insert(0, XFW_LIB_DIR)

    import xfw
    import xfw.vfs as vfs

    xfw.constants.PATH.XFW_ROOT_DIR = XFW_ROOT_DIR
    xfw.constants.FLAGS.XFW_IN_PACKAGE = XFW_IN_PACKAGE
    xfw.constants.FLAGS.XFW_NATIVE_AVAILABLE = XFW_NATIVE_AVAILABLE

    import xfw_loader

except Exception:
    print "[XFW/Entrypoint] Error:"
    traceback.print_exc()
