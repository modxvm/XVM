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


import pprint

from xfw import Logger, IS_DEVELOPMENT
from xfw_actionscript.python import swf
from xfw.constants import PATH

if swf.g_xvmlogger is None:
    swf.g_xvmlogger = Logger(PATH.XVM_LOG_FILE_NAME)

def log(s, prefix='', *args, **kwargs):
    if not isinstance(s, basestring):
        s = pprint.pformat(s, *args, **kwargs)
    swf.g_xvmlogger.add('%s%s' % (prefix, s))
    if IS_DEVELOPMENT:
        print('%s%s' % (prefix, s))

def err(s, *args, **kwargs):
    if not isinstance(s, basestring):
        s = pprint.pformat(s, *args, **kwargs)
    swf.g_xvmlogger.error(s)

def warn(s, *args, **kwargs):
    if not isinstance(s, basestring):
        s = pprint.pformat(s, *args, **kwargs)
    swf.g_xvmlogger.warning(s)

def debug(s, *args, **kwargs):
    if not isinstance(s, basestring):
        s = pprint.pformat(s, *args, **kwargs)
    swf.g_xvmlogger.debug(s)

def trace(s, *args, **kwargs):
    if IS_DEVELOPMENT:
        log(s, '[TRACE] >> ', *args, **kwargs)
