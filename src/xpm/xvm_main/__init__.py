"""
This file is part of the XVM project.

Copyright (c) 2013-2021 XVM Team.

XVM is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as
published by the Free Software Foundation, version 3.

XVM is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
"""

#
# Imports
#

from datetime import datetime
from glob import glob
import os
import platform


#
# XFW Mod initialization
#

__xvm_main_loaded = False


def log_version():
    from logger import log, warn

    log("XVM: eXtended Visualization Mod ( https://modxvm.com/ )")

    from __version__ import __branch__, __revision__, __node__
    from xfw_loader.python import WOT_VERSION_FULL
    from consts import XVM

    log("    XVM Version     : %s" % XVM.XVM_VERSION)
    log("    XVM Revision    : %s" % __revision__)
    log("    XVM Branch      : %s" % __branch__)
    log("    XVM Hash        : %s" % __node__)
    log("    WoT Version     : %s" % WOT_VERSION_FULL)
    log("    WoT Architecture: %s" % platform.architecture()[0])
    log("    Current Time    : %s %+05d" % (datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
        round((round((datetime.now() - datetime.utcnow()).total_seconds()) / 1800) / 2) * 100))

    log("---------------------------")

    xvm_fonts_arr = glob(os.environ['WINDIR'] + '/Fonts/*xvm*')
    if len(xvm_fonts_arr):
        warn('Following XVM fonts installed: %s' % xvm_fonts_arr)

    log("---------------------------")


def xfw_module_init():
    from logger import trace

    trace('xvm_main.python::xfw_module_init()')

    import BigWorld
    from gui.shared import events

    import config
    from consts import XVM, XVM_EVENT
    
    from init import subscribe, start

    log_version()

    subscribe()
    BigWorld.callback(0, start)

    # load config
    trace('xvm_main.python::xfw_module_init() --> config load')
    config.load(events.HasCtxEvent(XVM_EVENT.RELOAD_CONFIG, {'filename': XVM.CONFIG_FILE}))

    global __xvm_main_loaded
    __xvm_main_loaded = True


def xfw_is_module_loaded():
    return __xvm_main_loaded
