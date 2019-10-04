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

from xfw.constants import PATH, VERSION
from xfw.wg import getLanguage, getRegion
import xfw.vfs as vfs

class XFWCrashReport(object):
    def __init__(self):
        try:      
            self.native = None
            self.initialized = False
            self.__native_load()

            if self.native is None:
                print "[XFW/Crashreport] Failed to load native module. Crash report were not enabled"   
                return

            self.__native_configure()

        except Exception:
            print "[XFW/Crashreport] Error when loading native library:"
            traceback.print_exc()
            print "======================="


    def __native_load(self):
        if "python27" not in sys.modules:
            print "[XFW/Crashreport] No XFW.Native found. Crash reports were not be enabled."
            return
    
        path_realfs = PATH.XFWLOADER_PACKAGES_REALFS + '/xfw_crashreport/native/xfw_crashreport.pyd'
        path_vfs = PATH.XFWLOADER_PACKAGES_VFS + '/xfw_crashreport/native/'
        package_id = 'com.modxvm.xfw.crashreport'

        if os.path.isfile(path_realfs):
            self.native = imp.load_dynamic('XFW_CrashReport', path_realfs)
        else:
            path_realfs= 'mods\\temp\\%s\\native\\' % package_id
            vfs.directory_copy(path_vfs, path_realfs)
            self.native = imp.load_dynamic('XFW_CrashReport', os.path.join(path_realfs, 'xfw_crashreport.pyd'))


    def __native_configure(self):
        if not self.native.crashrpt_is_supported():
            print "[XFW/Crashreport] Crash reports are not not supported on this platform."
            return

        if not self.native.restore_suef():
            print "[XFW/Crashreport] Crash reports failed to restore SUEF."
            return

        if not self.native.crashrpt_set_language(unicode(getLanguage()), unicode(getRegion())):
            print "[XFW/Crashreport] Crash reports failed to find language files."
            return
        
        if not self.native.crashrpt_install():
            print "[XFW/Crashreport] Crash reports failed to install."
            return
        
        print "[XFW/Crashreport] Crash reports were registered."
        self.initialized = True

    def add_file(self, path, name, description):
        if not self.initialized:
            return

        try:
            self.native.crashrpt_add_file(unicode(path), unicode(name), unicode(description))
        except Exception:
            print "[XFW/Crashreport] [add_file]"
            traceback.print_exc()
            print "======================="


    def add_prop(self, name, value):
        if not self.initialized:
            return

        try:
            self.native.crashrpt_add_prop(unicode(name), unicode(value))
        except Exception:
            print "[XFW/Crashreport] [add_prop]"
            traceback.print_exc()
            print "======================="


g_crashreport = XFWCrashReport()

g_crashreport.add_file("game.log","game.log","BigWorld debug log")
g_crashreport.add_file("python.log","python.log","Python debug log")
g_crashreport.add_file("xvm.log","xvm.log","XVM debug log")

g_crashreport.add_prop("wot_version", VERSION.WOT_VERSION_FULL)
