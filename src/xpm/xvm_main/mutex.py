"""
This file is part of the XVM project.

Copyright (c) 2017 XVM Team

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

import traceback

from gui.shared import g_eventBus

from consts import XVM_EVENT
import config

def onConfigLoaded(self, e=None):
    try:
        if config.get('tweaks/allowMultipleWotInstances'):
            import xfw.mutex as mutex
            mutex.allow_multiple_wot()
    except Exception:
        traceback.print_exc()

g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, onConfigLoaded)
