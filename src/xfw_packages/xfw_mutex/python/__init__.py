"""
This file is part of the XVM Framework project.

Copyright (c) 2018-2021 XVM Team.

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

#xfw.loader
import xfw_loader.python as loader

__native = None


def allow_multiple_wot():
    """
    Allows to run another World of Tanks instance

    usage: allow_multiple_wot()
    """
    try:
        if not __native:
            return None
        return __native.allow_multiple_wot()
    except Exception:
        logging.exception("[XFW/Mutex][allow_multiple_wot] Error when changing mutex state:")


def restart_without_mods():
    """
    Restarts World of Tanks without mods

    usage: restart_without_mods()
    """
    try:
        if not __native:
            return None
        return __native.restart_without_mods()
    except Exception:
        logging.exception("[XFW/Mutex][restart_without_mods] Error when restarting wot without mods:")


def xfw_is_module_loaded():
    return __native is not None

def __init():
    global __native
    package_name = 'com.modxvm.xfw.mutex'

    try:
        xfwnative = loader.get_mod_module('com.modxvm.xfw.native')
        if not xfwnative:
            logging.error('[XFW/Mutex] Failed to load native module. XFW Native is not available')
            return

        if not xfwnative.unpack_native(package_name):
            logging.error('[XFW/Mutex] Failed to load native module. Failed to unpack native module')
            return

        __native = xfwnative.load_native(package_name, 'xfw_mutex.pyd', 'XFW_Mutex')
        if not __native:
            logging.error("[XFW/Mutex] Failed to load native module. Crash report were not enabled")
            return

    except Exception:
        logging.exception("[XFW/Mutex] Error when loading native library:")

__init()
