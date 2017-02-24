""" XVM (c) www.modxvm.com 2013-2017 """

import pprint

from xfw import *
from xfw import swf
from xfw.constants import PATH

if swf.g_xvmlogger is None:
    swf.g_xvmlogger = Logger(PATH.XVM_LOG_FILE_NAME)

def log(s, prefix='', *args, **kwargs):
    if not isinstance(s, basestring):
        s = pprint.pformat(s, *args, **kwargs)
    swf.g_xvmlogger.add('%s%s' % (prefix, s))

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
