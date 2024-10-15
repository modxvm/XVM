"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2024 XVM Contributors
"""

#
# Includes
#

# stdlib
import logging

# BigWorld
from PlayerEvents import g_playerEvents

# XFW Loader
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
