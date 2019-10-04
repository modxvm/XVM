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

class XFWCrashFix(object):

    def __init__(self):
        try:
            if "python27" in sys.modules:
                path_realfs = PATH.XFWLOADER_PACKAGES_REALFS + '/xfw_wotfix_crashes/native/xfw_crashfix.pyd'
                path_vfs = PATH.XFWLOADER_PACKAGES_VFS + '/xfw_wotfix_crashes/native/xfw_crashfix.pyd'

                is_in_realfs = os.path.isfile(path_realfs)
                if is_in_realfs:
                    self.native = imp.load_dynamic('xfw_crashfix', path_realfs)
                else:
                    import xfw.vfs as vfs
                    self.native = vfs.c_extension_load('xfw_crashfix', path_vfs, 'com.modxvm.xfw.wotfix.crashes')
            else:
                print "[XFW/Crashfix] was not loaded because of python27 error"
        except Exception:
            print "[XFW/Crashfix] Error on loading native components"
            traceback.print_exc()

    def apply_fix(self):
        if self.native is None:
            print "[XFW/Crashfix] Crash fixes not applied."
            return
        else:
            print "[XFW/Crashfix] Applying crashfixes:"

        for bf_num in range(1, self.native.fix_count()+1):
            err_code = self.native.fix_apply(bf_num)
            result = "OK" if err_code >= 0 else "FAIL"
            print "[XFW/Crashfix]    BugFix %i: %s, %i" % (bf_num, result, err_code)

g_crashfix = XFWCrashFix()
g_crashfix.apply_fix()
