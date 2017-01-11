""" XVM (c) www.modxvm.com 2013-2017 """

from xfw import *
from xfw import swf
from xfw.constants import PATH

if swf.g_xvmlogger is None:
    swf.g_xvmlogger = Logger(PATH.XVM_LOG_FILE_NAME)

def log(s, prefix=''):
    swf.g_xvmlogger.add('%s%s' % (prefix, str(s)))

def err(s):
    swf.g_xvmlogger.error(s)

def warn(s):
    swf.g_xvmlogger.warning(s)

def debug(s):
    swf.g_xvmlogger.debug(s)

def trace(s):
    if IS_DEVELOPMENT:
        log(s, '[TRACE] >> ')
