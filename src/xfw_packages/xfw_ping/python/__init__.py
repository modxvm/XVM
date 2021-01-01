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

g_xfwping = None

def ping(address, unlock_gil=True):
    if not g_xfwping:
        return None
    return g_xfwping.ping(address, unlock_gil)

class XFWPing(object):

    def __init__(self):
        self.__native = None
        self.__package_name = 'com.modxvm.xfw.ping'
        self.__initialized = False

        try:
            xfwnative = loader.get_mod_module('com.modxvm.xfw.native')
            if not xfwnative:
                logging.error('[XFW/Ping] Failed to load native module. XFW Native is not available')
                return

            if not xfwnative.unpack_native(self.__package_name):
                logging.error('[XFW/Ping] Failed to load native module. Failed to unpack native module')
                return

            self.__native = xfwnative.load_native(self.__package_name, 'xfw_ping.pyd', 'XFW_Ping')
            if not self.__native:
                logging.error("[XFW/Ping] Failed to load native module. Crash report were not enabled")
                return

            self.__initialized = True
        except Exception:
            logging.exception("[XFW/Ping] Error when loading native library:")


    def is_initialized(self):
        return self.__initialized


    def ping(self, address, unlock_gil=True):
        """
        Send ping request to host

        usage: ping(<address>, [unlock_gil])
        address: host domain name or IP
        unlock_gil: unlock GIL when perform I/O operations, True/False, True by default.

        returns: ping time in msec

        examples:
        ping("127.0.0.1")
        ping("localhost",True)
        """
        try:
            if not self.__native:
                return None
            return self.__native.ping(address, unlock_gil)
        except Exception:
            logging.exception("[XFW/Ping][ping]")


def xfw_is_module_loaded():
    if not g_xfwping:
        return False

    return g_xfwping.is_initialized()

g_xfwping = XFWPing()
