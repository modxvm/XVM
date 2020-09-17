"""
This file is part of the XVM Framework project.

Copyright (c) 2018-2020 XVM Team.

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

#xfw.loader
import xfw_loader.python as loader

g_crashfix = None

class XFWCrashFix(object):

    def __init__(self):
        self.__native = None
        self.__package_name = 'com.modxvm.xfw.wotfix.crashes'
        self.__initialized = False

        try:
            xfwnative = loader.get_mod_module('com.modxvm.xfw.native')
            if not xfwnative:
                logging.error('[XFW/Crashfix] Failed to load native module. XFW Native is not available')
                return

            if not xfwnative.unpack_native(self.__package_name):
                logging.error('[XFW/Crashfix] Failed to load native module. Failed to unpack native module')
                return

            self.__native = xfwnative.load_native(self.__package_name, 'xfw_crashfix.pyd', 'xfw_crashfix')
            if not self.__native:
                logging.error("[XFW/Crashfix] Failed to load native module. Crash report were not enabled")
                return

            self.__initialized = True
        except Exception:
            logging.exception("[XFW/Crashfix] Error when loading native library:")


    def is_initialized(self):
        return self.__initialized


    def apply_fix(self):
        if self.__native is None:
            logging.warning("[XFW/Crashfix] Crash fixes not applied.")
            return

        logging.info("[XFW/Crashfix] Applying crashfixes:")

        for bf_num in range(1, self.__native.fix_count() + 1):
            err_code = self.__native.fix_apply(bf_num)
            if err_code >= 0:
                logging.info("[XFW/Crashfix]    BugFix %i: OK, %i" % (bf_num, err_code))
            else:
                logging.warning("[XFW/Crashfix]    BugFix %i: FAIL, %i" % (bf_num, err_code))


def xfw_is_module_loaded():
    if not g_crashfix:
        return False

    return g_crashfix.is_initialized()

g_crashfix = XFWCrashFix()
g_crashfix.apply_fix()
