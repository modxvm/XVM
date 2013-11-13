""" xvm (c) sirmax 2013 """

import datetime

from gui.mods.xpm import *
from constants import XVM_LOG_FILE_NAME

#############################
# Command

def log(s, prefix=""):
    _logger.add(prefix + str(s))

def err(s):
    log(s, '[ERROR] ')

def debug(s):
    if IS_DEVELOPMENT:
        log(s, '[DEBUG] ')

def trace(*args):
    if IS_DEVELOPMENT:
        log(s, '[TRACE] ')

#############################
# Private

class _Logger(object):
    def __init__(self):
        self.logfile = open(XVM_LOG_FILE_NAME, "w", 2 if IS_DEVELOPMENT else 8192)

    def __del__(self):
        self.logfile.close()

    def add(self, s):
        try:
            self.logfile.write("%s: %s\n" %
                (datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'), s))
        except:
            logtrace(__file__)

_logger = _Logger()
