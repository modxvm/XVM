"""
This file is part of the XVM project.

Copyright (c) 2013-2020 XVM Team.

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

#####################################################################
# imports

import traceback

import base64
from account_helpers.CustomFilesCache import CustomFilesCache

from xfw import *
from xvm_main.python.logger import *

#####################################################################
# handlers

@overrideMethod(CustomFilesCache, '_CustomFilesCache__onReadLocalFile')
def _CustomFilesCache__onReadLocalFile(base, self, url, showImmediately):
    try:
        base(self, url, showImmediately)
    except EOFError:
        err('CustomFilesCache.__onReadLocalFile: url="{0}"'.format(url))
        err(traceback.format_exc())
        try:
            log('Attempt to reload url: {0}'.format(url))
            del(self._CustomFilesCache__db[base64.b32encode(url)])
            base(self, url, showImmediately)
        except Exception:
            err(traceback.format_exc())
