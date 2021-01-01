"""
This file is part of the XVM project.

Copyright (c) 2020-2021 XVM Team.

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

from gui.Scaleform.daapi.view.login.LoginView import LoginView

from xfw import *

import config

#WGC resets WoT mutex so we should perform mutex kill after wgc_api.dll code execution
@registerEvent(LoginView, 'onLogin')
def kill_wotclient_mutex(self, *args):
    try:
        if config.get('tweaks/allowMultipleWotInstances', False):
            import xfw_mutex.python as mutex
            mutex.allow_multiple_wot()
    except Exception:
        traceback.print_exc()

