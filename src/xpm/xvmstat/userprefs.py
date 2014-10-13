""" XVM (c) www.modxvm.com 2013-2014 """

def get(key):
    return _userPrefs.get(key)

# key must be valid file name
def set(key, value):
    _userPrefs.set(key, value)

# PRIVATE

import os
import traceback
import cPickle

import BigWorld

from logger import *

class _UserPrefs():
    def __init__(self):
        try:
            self.cache_dir = os.path.join(
                os.path.dirname(unicode(BigWorld.wg_getPreferencesFilePath(), 'utf-8', errors = 'ignore')),
                'xvm')
            if not os.path.isdir(self.cache_dir):
                os.makedirs(self.cache_dir)
        except:
            err('userPrefs.__init__() exception: ' + traceback.format_exc())

    def get(self, key):
        fd = None
        try:
            fileName = os.path.join(self.cache_dir, '{0}.dat'.format(key))
            if os.path.isfile(fileName):
                fd = open(fileName, 'rb')
                return cPickle.load(fd)
        except:
            err('userPrefs.get() exception: ' + traceback.format_exc())
        finally:
            if fd is not None:
                fd.close()

    def set(self, key, value):
        fd = None
        try:
            fileName = os.path.join(self.cache_dir, '{0}.dat'.format(key))
            fd = open(fileName, 'wb')
            cPickle.dump(value, fd, -1)
            os.fsync(fd)
        except:
            err('userPrefs.set() exception: ' + traceback.format_exc())
        finally:
            if fd is not None:
                fd.close()

_userPrefs = _UserPrefs()
