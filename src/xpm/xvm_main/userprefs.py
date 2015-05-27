""" XVM (c) www.modxvm.com 2013-2015 """

def get(key, default=None):
    return _userPrefs.get(key, default)

# key must be valid file name
def set(key, value):
    _userPrefs.set(key, value)

# PRIVATE

import os
import cPickle
import traceback

import BigWorld

from logger import *

class _UserPrefs():
    def __init__(self):
        try:
            self.cache_dir = os.path.join(
                os.path.dirname(unicode(BigWorld.wg_getPreferencesFilePath(), 'utf-8', errors='ignore')),
                'xvm')
            if not os.path.isdir(self.cache_dir):
                os.makedirs(self.cache_dir)
        except Exception:
            err(traceback.format_exc())

    def get(self, key, default):
        fd = None
        try:
            fileName = os.path.join(self.cache_dir, '{0}.dat'.format(key))
            if os.path.isfile(fileName):
                fd = open(fileName, 'rb')
                try:
                    return cPickle.load(fd)
                except Exception:
                    os.remove(fileName)
                    log('[WARNING] Broken file was removed: %s' % fileName)
                    raise
            return default
        except Exception:
            err(traceback.format_exc())
            return default
        finally:
            if fd is not None:
                fd.close()

    def set(self, key, value):
        fd = None
        try:
            fileName = os.path.join(self.cache_dir, '{0}.dat'.format(key))
            dirName = os.path.dirname(fileName)
            if not os.path.exists(dirName):
                os.makedirs(dirName)
            fd = open(fileName, 'wb')
            cPickle.dump(value, fd, -1)
            os.fsync(fd)
        except Exception:
            err(traceback.format_exc())
        finally:
            if fd is not None:
                fd.close()

_userPrefs = _UserPrefs()
