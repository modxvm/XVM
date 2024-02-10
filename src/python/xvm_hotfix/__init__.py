"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2024 XVM Contributors
"""

#####################################################################
# imports

import traceback

import base64
import debug_utils
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

# uncomment on Common Test
"""
@overrideMethod(debug_utils, '_doLog')
def _doLog(base, category, msg, *args, **kwargs):
    if category == 'DEBUG':
        if msg == '_updateToLatestVersion':
            return
    base(category, msg, args, kwargs)
"""
