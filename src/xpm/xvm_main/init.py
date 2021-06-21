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

import BigWorld
import game
from gui.shared import g_eventBus, events
from helpers import dependency
from skeletons.gui.app_loader import IAppLoader

from xfw.constants import XFW_COMMAND, XFW_EVENT
from xfw.events import registerEvent
from xfw_loader.python import WOT_VERSION_FULL

import config
from consts import XVM, XVM_EVENT
from logger import log, warn, trace
import handlers
from xvm import g_xvm

from __version__ import __branch__, __revision__, __node__

    
#
# Info
#

def log_version():
    log("XVM: eXtended Visualization Mod ( https://modxvm.com/ )")

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

#
# Init/deinit
#

def config_load():
    trace('xvm_main.python.init::config_load()')
    config.load(events.HasCtxEvent(XVM_EVENT.RELOAD_CONFIG, {'filename': XVM.CONFIG_FILE}), True)


def subscribe():
    trace('xvm_main.python.init::subscribe()')

    dependency.instance(IAppLoader).onGUISpaceEntered += g_xvm.onGUISpaceEntered

    g_eventBus.addListener(XFW_COMMAND.XFW_CMD, g_xvm.onXfwCommand)
    g_eventBus.addListener(XFW_EVENT.APP_INITIALIZED, g_xvm.onAppInitialized)
    g_eventBus.addListener(XFW_EVENT.APP_DESTROYED, g_xvm.onAppDestroyed)
    g_eventBus.addListener(XVM_EVENT.RELOAD_CONFIG, config.load)
    g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, g_xvm.onConfigLoaded)
    g_eventBus.addListener(XVM_EVENT.SYSTEM_MESSAGE, g_xvm.onSystemMessage)
    g_eventBus.addListener(XVM_EVENT.CHECK_ACTIVATION, g_xvm.onCheckActivation)


def init():
    trace('xvm_main.python.init::init()')

    log_version()
    subscribe()
    config_load()

    g_xvm.initialize()


@registerEvent(game, 'fini')
def fini():
    trace('xvm_main.python.init::fini()')

    try:
        dependency.instance(IAppLoader).onGUISpaceEntered -= g_xvm.onGUISpaceEntered
    except(dependency.DependencyError):
        pass

    g_eventBus.removeListener(XFW_COMMAND.XFW_CMD, g_xvm.onXfwCommand)
    g_eventBus.removeListener(XFW_EVENT.APP_INITIALIZED, g_xvm.onAppInitialized)
    g_eventBus.removeListener(XFW_EVENT.APP_DESTROYED, g_xvm.onAppDestroyed)
    g_eventBus.removeListener(XVM_EVENT.RELOAD_CONFIG, config.load)
    g_eventBus.removeListener(XVM_EVENT.CONFIG_LOADED, g_xvm.onConfigLoaded)
    g_eventBus.removeListener(XVM_EVENT.SYSTEM_MESSAGE, g_xvm.onSystemMessage)
    g_eventBus.removeListener(XVM_EVENT.CHECK_ACTIVATION, g_xvm.onCheckActivation)
