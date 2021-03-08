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

#cpython
import logging

#xfw.loader
import xfw_loader.python as loader

#xvm.main
import xvm_main.python.config as config

if loader.is_mod_loaded('com.modxvm.xfw.wwise'):
    if config.get('sounds/remote_communication', False):
        try:
            wwise_module = loader.get_mod_module('com.modxvm.xfw.wwise')
            if not wwise_module:
                logging.error("[XVM/Sounds] [remote_communication] XFW.WWISE is failed to load")

            wwise_module.wwise_communication_init()
            logging.info("[XVM/Sounds] [remote_communication] communication with WWISE Authoring Tools is enabled")

        except Exception:
            logging.exception("[XVM/Sounds] [remote_communication]:")

else:
    logging.warning('[XVM/Sounds] [remote_communication] failed to load sound banks because XFW.WWISE is not loaded')
