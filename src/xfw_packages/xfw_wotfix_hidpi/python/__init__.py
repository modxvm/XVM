"""
This file is part of the XVM Framework project.

Copyright (c) 2018-2021 XVM Team.

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

#cpython
import logging
import platform

#xfw.loader
import xfw_loader.python as loader

g_xfwdpi = None

class XFWDPIFix(object):
    def __init__(self):
        self.__native = None
        self.__initialized = False
        self.__package_name = 'com.modxvm.xfw.wotfix.hidpi'

        try:
            xfwnative = loader.get_mod_module('com.modxvm.xfw.native')
            if not xfwnative:
                logging.error('[XFW/HiDPI] Failed to load native module. XFW Native is not available')
                return

            if not xfwnative.unpack_native(self.__package_name):
                logging.error('[XFW/HiDPI] Failed to load native module. Failed to unpack native module')
                return

            self.__native = xfwnative.load_native(self.__package_name, 'xfw_hidpi.pyd', 'XFW_HiDPI')
            if not self.__native:
                logging.error("[XFW/HiDPI] Failed to load native module. Crash report were not enabled")
                return

            self.__initialized = True

        except Exception:
            logging.exception("[XFW/HiDPI] Error when loading native library:")

    def is_initialized(self):
        return self.__initialized

    def fix_dpi(self):
        try:
            if not platform.version().startswith('5.'):
                if self.__native.fix_dpi():
                    logging.info("[XFW/HiDPI] HiDPI fix applied")

        except Exception:
            logging.info("[XFW/HiDPI] [fix_dpi]:")

def xfw_is_module_loaded():
    if not g_xfwdpi:
        return False

    return g_xfwdpi.is_initialized()

g_xfwdpi = XFWDPIFix()
g_xfwdpi.fix_dpi()
