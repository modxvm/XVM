"""
SPDX-License-Identifier: LGPL-3.0-or-later
Copyright (c) 2013-2024 XVM Contributors
"""

import os

#####################################################################
# Check for token masking

XFW_NO_TOKEN_MASKING = os.environ.get('XFW_NO_TOKEN_MASKING') is not None

#####################################################################
# Check for development mode

IS_DEVELOPMENT = os.environ.get('XFW_DEVELOPMENT') is not None
if IS_DEVELOPMENT:
    print '[XFW] Development mode'
    # Setup development environment
    import BigWorld
    def _autoFlushPythonLog():
        BigWorld.flushPythonLog()
        BigWorld.callback(0.1, _autoFlushPythonLog)
    _autoFlushPythonLog()

#####################################################################
# imports

from constants import *
from events import *
from logger import *
from singleton import *
from utils import *
from wg import *

__all__ = [
    'IS_DEVELOPMENT',
    'XFW_NO_TOKEN_MASKING',
    # constants
    'XFW_COMMAND',
    'XFW_EVENT',
    'XFW_COLORS',
    # events
    'EventHook',
    'registerEvent',
    'overrideMethod',
    'overrideStaticMethod',
    'overrideClassMethod',
    # logger
    'log',
    'err',
    'debug',
    'logtrace',
    'Logger',
    # singleton
    'Singleton',
    # utils
    'load_file',
    'load_config',
    'urlSafeBase64Encode',
    'strip_html_tags',
    'unicode_to_ascii',
    'alphanumeric_sort',
    # wg
    'getLobbyApp',
    'getBattleApp',
    'getCurrentAccountDBID',
    'isReplay',
    'getArenaPeriod',
    'getCurrentBattleInfo',
    'getVehCD',
    'getRegion',
    'getLanguage',
]
