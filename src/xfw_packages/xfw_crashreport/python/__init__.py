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
import os.path

#xfw.loader
import xfw_loader.python as loader

__xfw_crashreport = None

class XFWCrashReport(object):
    def __init__(self):
        self.__native = None
        self.__initialized = False
        self.package_name = 'com.modxvm.xfw.crashreport'

        try:
            xfwnative = loader.get_mod_module('com.modxvm.xfw.native')
            if not xfwnative:
                logging.error('[XFW/Crashreport] [__init__]  Failed to load native module. XFW Native is not available')
                return

            if not xfwnative.unpack_native(self.package_name):
                logging.error('[XFW/Crashreport] [__init__] Failed to load native module. Failed to unpack native module')
                return

            self.__native = xfwnative.load_native(self.package_name, 'xfw_crashreport.pyd', 'XFW_CrashReport')
            if not self.__native:
                logging.error("[XFW/Crashreport] [__init__] Failed to load native module. Crash report were not enabled")
                return

            self.__native_configure()

        except Exception:
            logging.exception("[XFW/Crashreport] [__init__] Error when loading native library:")


    def __native_configure(self):
        if not self.__native.is_platform_supported():
            logging.warning("[XFW/Crashreport] [__native_configure] Crash reports are not not supported on this platform.")
            return

        if not self.__native.restore_suef():
            logging.error("[XFW/Crashreport] [__native_configure] Crash reports failed to restore SUEF.")
            return

        self.__initialized = True


    def install(self):
        if self.__initialized:
            if not self.__native.initialize():
                logging.error("[XFW/Crashreport] [install] Crash reports failed to install.")
                return
            logging.info("[XFW/Crashreport] [install] Crash reports were registered.")
            self.__installed = True


    def is_initialized(self):
        '''
        has the different meaning from self.__initialized!

        self.__initialized     - .pyd was succesfuly loaded
        self.is_inititalized() - crash handler was initialized
        '''
        if not self.__initialized:
            return False

        return self.__native.is_initialized()


    def add_attachment(self, path, description):
        if not self.__initialized:
            return

        try:
            if not self.__native.add_attachment(unicode(path), description):
                logging.warn("[XFW/Crashreport] [add_attachment] failed to add attachment")
        except Exception:
            logging.exception("[XFW/Crashreport] [add_attachment]")


    def set_dsn(self, dsn):
        if not self.__initialized:
            return

        try:
            if not self.__native.set_dsn(dsn):
                logging.warn("[XFW/Crashreport] [set_dsn] failed to set DSN")
        except Exception:
            logging.exception("[XFW/Crashreport] [set_dsn]")


    def set_environment(self, environment):
        if not self.__initialized:
            return

        try:
            if not self.__native.set_environment(environment):
                logging.warn("[XFW/Crashreport] [set_environment] failed to set environment")
        except Exception:
            logging.exception("[XFW/Crashreport] [set_environment]")


    def set_tag(self, name, value):
        if not self.__initialized:
            return

        try:
            if not self.__native.set_tag(name, value):
                logging.warn("[XFW/Crashreport] [set_tag] failed to set tag")
        except Exception:
            logging.exception("[XFW/Crashreport] [set_tag]")

    def set_release(self, release_ver):
        if not self.__initialized:
            return

        try:
            if not self.__native.set_release(release_ver):
                logging.warn("[XFW/Crashreport] [set_release] failed to set release")
        except Exception:
            logging.exception("[XFW/Crashreport] [set_release]")


def xfw_is_module_loaded():
    if not __xfw_crashreport:
        return False

    return __xfw_crashreport.is_initialized()


def xfw_module_init():
    global __xfw_crashreport
    __xfw_crashreport = XFWCrashReport()

    package_name    = unicode(__xfw_crashreport.package_name)
    package_version = loader.get_mod_ids()[package_name]
    is_development  = loader.get_mod_user_data(package_name, 'build_development') != "False"
    server_dsn      = 'https://3ee6306774f349beb6c658462be0a591@sentry.openwg.net/2'

    #Server DSN
    __xfw_crashreport.set_dsn(server_dsn)

    #additional files
    __xfw_crashreport.add_attachment("game.log","bw_log")
    __xfw_crashreport.add_attachment("python.log","python_log")
    __xfw_crashreport.add_attachment("xvm.log","xvm_log")

    #Release
    __xfw_crashreport.set_release(package_version)

    #Environment
    environment = 'release'
    if is_development:
        environment = 'nightly'
    if os.path.exists('wargaming_qa.conf'):
        environment = 'qa'
    __xfw_crashreport.set_environment(environment)

    #Initialize
    __xfw_crashreport.install()
    
    #Tags
    __xfw_crashreport.set_tag("wot_version", loader.WOT_VERSION_FULL)
