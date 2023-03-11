"""
This file is part of the XVM project.

Copyright (c) 2020-2022 XVM Team.

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
# Includes
#

# stdlib
import logging

# BigWorld
from PlayerEvents import g_playerEvents

# XFW.Multilaunch
import xfw_loader.python as loader

# XVM
import config


#
# Functions
#

def kill_mutex(*args, **kwargs):
    try:
        if config.get('tweaks/allowMultipleWotInstances', False):
            if loader.is_mod_loaded('com.modxvm.xfw.multilaunch'):
                import xfw_multilaunch.python as native
                native.kill_mutex()
    except Exception:
        logging.getLogger('XVM/Main').exception('multilaunch/kill_mutex')



#
# Init
#

def init():
    g_playerEvents.onAccountShowGUI += kill_mutex

def fini():
    g_playerEvents.onAccountShowGUI -= kill_mutex
