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

#bigworld/wot
from gui.shared.utils import getPlayerDatabaseID
from helpers import dependency
from skeletons.gui.app_loader import IAppLoader, GuiGlobalSpaceID

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
        if not self.__initialized:
            return False

        if not self.__native.opt_databasepath_set(u'%s/%s/db' % (unicode(loader.XFWLOADER_TEMPDIR), unicode(self.package_name))):
            logging.error("[XFW/Crashreport] [install] Crash reports failed to install. (failed to set database path)")
            return False
        if not self.__native.initialize():
            logging.error("[XFW/Crashreport] [install] Crash reports failed to install. (failed to initialize sentry)")
            return False
        if not self.set_user("0"):
            logging.error("[XFW/Crashreport] [install] Crash reports failed to install. (failed to set userid)")
            return False

        dependency.instance(IAppLoader).onGUISpaceEntered += self.__on_gui_space_entered
        self.__installed = True
        return True

    def is_initialized(self):
        '''
        has the different meaning from self.__initialized!

        self.__initialized     - .pyd was succesfuly loaded
        self.is_inititalized() - crash handler was initialized
        '''
        if not self.__initialized:
            return False

        return self.__native.is_initialized()


    def add_attachment(self, filepath, filename):
        if not self.__initialized:
            return

        try:
            if not self.__native.add_attachment(unicode(filepath), filename):
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

    def set_user(self, user_id):
        if not self.__initialized:
            return False

        try:
            if not self.__native.set_user(user_id):
                logging.warn("[XFW/Crashreport] [set_user] failed to set release")
                return False
            return True
        except Exception:
            logging.exception("[XFW/Crashreport] [set_user]")

    def consent_get(self):
        if not self.__initialized:
            return

        try:
            return self.__native.consent_get()
        except Exception:
            logging.exception("[XFW/Crashreport] [consent_get]")
        return False

    def consent_set(self, consent_given):
        if not self.__initialized:
            return

        try:
            return self.__native.consent_get(consent_given)
        except Exception:
            logging.exception("[XFW/Crashreport] [consent_set]")
        return False


    def consent_require(self, consent_required):
        if not self.__initialized:
            return

        try:
            return self.__native.consent_require(consent_required)
        except Exception:
            logging.exception("[XFW/Crashreport] [consent_require]")
        return False

    def simulate_crash(self):
        if not self.__initialized:
            return

        self.__native.simulate_crash()

    def __on_gui_space_entered(self, spaceID):
        print "on acc show gui"
        if not self.__installed:
            return

        if spaceID == GuiGlobalSpaceID.LOGIN:
            self.set_user("0")
        elif spaceID == GuiGlobalSpaceID.LOBBY:
            self.set_user(str(getPlayerDatabaseID()))


def xfw_is_module_loaded():
    if not __xfw_crashreport:
        return False

    if __xfw_crashreport.is_initialized():
        logging.info("[XFW/Crashreport] [xfw_is_module_loaded] bugreporting was initialized successfuly. Please read our privacy policy:")
        logging.info("[XFW/Crashreport] [xfw_is_module_loaded] https://sentry.openwg.net/privacy")
        return True

    return False

def xfw_module_init():

    global __xfw_crashreport
    __xfw_crashreport = XFWCrashReport()

    package_name = unicode(__xfw_crashreport.package_name)

    #options/attachments
    if os.path.exists('game.log'):
        __xfw_crashreport.add_attachment("game.log", "game.log")
    __xfw_crashreport.add_attachment("python.log", "python.log")
    __xfw_crashreport.add_attachment("xvm.log", "xvm.log")

    #options/consent
    if loader.get_client_realm() != 'RU':
        logging.info("[XFW/Crashreport] [xfw_module_init] bugreporting requires user consent. Please add empty 'XFW_BUGREPORT_OPTIN.txt file to game root to enable it")
        __xfw_crashreport.consent_require(True)

    #options/dsn
    __xfw_crashreport.set_dsn('https://2f01e1ac193f4e369c105392e2b4b6fe@sentry.openwg.net/2')

    #options/environment
    environment = 'release'
    is_development  = loader.get_mod_user_data(package_name, 'build_development') != "False"
    if is_development:
        environment = 'nightly'
    if os.path.exists('wargaming_qa.conf'):
        environment = 'qa'
    __xfw_crashreport.set_environment(environment)

    #options/release
    __xfw_crashreport.set_release(loader.get_mod_ids()[package_name])

    #initialize
    __xfw_crashreport.install()

    #tags
    __xfw_crashreport.set_tag("wot_version", loader.WOT_VERSION_FULL)

    #consent
    if os.path.exists('XFW_BUGREPORT_OPTOUT.txt'):
        __xfw_crashreport.consent_set(False)
        logging.info("[XFW/Crashreport] [xfw_module_init] bugreporting disabled because of user opt-out")
    elif os.path.exists('XFW_BUGREPORT_OPTIN.txt'):
        __xfw_crashreport.consent_set(False)
        logging.info("[XFW/Crashreport] [xfw_module_init] bugreporting enabled because of user opt-in")
    elif os.path.exists('wargaming_qa.conf'):
        logging.info("[XFW/Crashreport] [xfw_module_init] bugreporting enabled because of QA")
