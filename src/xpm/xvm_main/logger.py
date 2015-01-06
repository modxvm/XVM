""" XVM (c) www.modxvm.com 2013-2014 """

from constants import XVM_LOG_FILE_NAME
from xfw import Logger

def log(s, prefix=""):
    _logger.add(prefix + str(s))

def err(s):
    _logger.error(s)

def debug(s):
    _logger.debug(s)

_logger = Logger(XVM_LOG_FILE_NAME)
