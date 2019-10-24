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

#cpython
import logging

#xfw.loader
import xfw_loader.python as loader

#xfw.libraries
from xfw.constants import PATH, VERSION
from xfw.wg import getLanguage, getRegion


g_crashreport = None

class XFWCrashReport(object):
    def __init__(self):
        self.__native = None
        self.__initialized = False
        self.__package_name = 'com.modxvm.xfw.crashreport'

        try:
            xfwnative = loader.get_mod_module('com.modxvm.xfw.native')
            if not xfwnative:
                logging.error('[XFW/Crashreport] Failed to load native module. XFW Native is not available')
                return

            if not xfwnative.unpack_native(self.__package_name):
                logging.error('[XFW/Crashreport] Failed to load native module. Failed to unpack native module')
                return

            self.__native = xfwnative.load_native(self.__package_name, 'xfw_crashreport.pyd', 'XFW_CrashReport')
            if not self.__native:
                logging.error("[XFW/Crashreport] Failed to load native module. Crash report were not enabled")
                return

            self.__native_configure()

        except Exception:
            logging.exception("[XFW/Crashreport] Error when loading native library:")


    def __native_configure(self):
        if not self.__native.crashrpt_is_supported():
            logging.warning("[XFW/Crashreport] Crash reports are not not supported on this platform.")
            return

        if not self.__native.restore_suef():
            logging.error("[XFW/Crashreport] Crash reports failed to restore SUEF.")
            return

        if not self.__native.crashrpt_set_language(unicode(getLanguage()), unicode(getRegion())):
            logging.error("[XFW/Crashreport] Crash reports failed to find language files.")
            return

        if not self.__native.crashrpt_install():
            logging.error("[XFW/Crashreport] Crash reports failed to install.")
            return

        logging.info("[XFW/Crashreport] Crash reports were registered.")
        self.__initialized = True


    def is_initialized(self):
        return self.__initialized

    def add_file(self, path, name, description):
        if not self.__initialized:
            return

        try:
            self.__native.crashrpt_add_file(unicode(path), unicode(name), unicode(description))
        except Exception:
            logging.exception("[XFW/Crashreport] [add_file]")


    def add_prop(self, name, value):
        if not self.__initialized:
            return

        try:
            self.__native.crashrpt_add_prop(unicode(name), unicode(value))
        except Exception:
            logging.exception("[XFW/Crashreport] [add_prop]")


def xfw_is_module_loaded():
    if not g_crashreport:
        return False

    return g_crashreport.is_initialized()

g_crashreport = XFWCrashReport()

g_crashreport.add_file("game.log","game.log","BigWorld debug log")
g_crashreport.add_file("python.log","python.log","Python debug log")
g_crashreport.add_file("xvm.log","xvm.log","XVM debug log")

g_crashreport.add_prop("wot_version", loader.WOT_VERSION_FULL)
