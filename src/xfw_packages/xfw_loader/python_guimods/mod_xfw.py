"""
This file is part of the XVM Framework project.

Copyright (c) 2013-2021 XVM Team.

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

import logging
import os
import sys

def path_to_the_gameroot():
    #Since WoT 1.7.0 python working directory always points to game root
    #Please do not delete this function. It may be helpful in case of further changes in WoT client.
    return './'

def start_xfw():
    try:
        logging.info('[XFW/Entrypoint]')
        logging.info(u'[XFW/Entrypoint] WoT Working Directory: %s' % os.getcwdu())

        path_to_root = None
        try:
            path_to_root = path_to_the_gameroot()
        except Exception:
            logging.warning('[XFW/Entrypoint] Unsupported working directory')
            return
        logging.info(u'[XFW/Entrypoint] Path to root: %s' % path_to_root)

        #Files in VFS
        sys.path.insert(0, 'mods/xfw_packages')
        sys.path.insert(0, 'mods/xfw_libraries')

        #Files in RealFS
        sys.path.insert(0, path_to_root + u'res_mods/mods/xfw_packages')
        sys.path.insert(0, path_to_root + u'res_mods/mods/xfw_libraries')

        import xfw_loader.python as loader
        loader.init(path_to_root)
        loader.mods_load()

    except Exception:
        logging.exception('[XFW/Entrypoint] Error on executing XFW entry point')


start_xfw()
