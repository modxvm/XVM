"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2024 XVM Contributors
"""

#python
import os
import cPickle
import traceback

#bigworld
import BigWorld
from external_strings_utils import unicode_from_utf8

from fs.osfs import OSFS
from fs.zipfs import ZipFS

#xvm.main
from logger import *
import utils

def get(key, default=None):
    return _userPrefs.get(key, default)

# key must be valid file name
def set(key, value):
    _userPrefs.set(key, value)


# PRIVATE

class _UserPrefs():
    def __init__(self):
        try:
            self.cache_dir = os.path.join(os.path.dirname(unicode_from_utf8(BigWorld.wg_getPreferencesFilePath())[1]), u'xvm')
            if not os.path.isdir(self.cache_dir):
                os.makedirs(self.cache_dir)
        except Exception:
            err(traceback.format_exc())

    def get(self, key, default):
        fs = None
        try:
            if not key:
                return default
            if '{accountDBID}' in key:
                key = key.format(accountDBID=utils.getAccountDBID())
            fullFileName = os.path.join(self.cache_dir, '{0}.dat'.format(key))
            dirName = os.path.dirname(fullFileName)
            pkg = os.path.basename(dirName)
            fileName = os.path.basename(fullFileName)
            isZip = pkg.lower().endswith('.zip')
            if os.path.exists(dirName):
                if isZip:
                    fs = ZipFS(dirName, mode='r', compression='stored')
                else:
                    fs = OSFS(dirName, create=True)
                if fs.exists(fileName):
                    try:
                        #log(fileName)
                        #log(cPickle.loads(fs.getcontents(fileName)))
                        return cPickle.loads(fs.getcontents(fileName))
                    except Exception:
                        if isZip:
                            log('[WARNING] Broken file: %s' % fullFileName)
                        else:
                            log('[WARNING] Remove broken file: %s' % fullFileName)
                            fs.remove(fileName)
                        raise
            return default
        except Exception:
            err(traceback.format_exc())
            return default
        finally:
            if fs is not None:
                fs.close()

    def set(self, key, value):
        fs = None
        try:
            if not key:
                return
            key = key.format(accountDBID=utils.getAccountDBID())
            fullFileName = os.path.join(self.cache_dir, '{0}.dat'.format(key))
            dirName = os.path.dirname(fullFileName)
            pkg = os.path.basename(dirName)
            fileName = os.path.basename(fullFileName)
            isZip = pkg.lower().endswith('.zip')
            save = True
            if isZip:
                fs = ZipFS(dirName, mode='a', compression='stored')
                if fs.exists(fileName):
                    log('[WARNING] archive "{}" already contains file "{}". Do not save the new data.'.format(pkg, fileName))
                    save = False
            else:
                fs = OSFS(dirName, create=True)
            if save:
                fs.setcontents(fileName, cPickle.dumps(value))
        except Exception:
            err(traceback.format_exc())
        finally:
            if fs is not None:
                fs.close()

_userPrefs = _UserPrefs()
