""" XVM (c) www.modxvm.com 2013-2016 """

def get_url(url, callback):
    _fileCache.get_url(url, callback)


def save(name, bytes):
    _fileCache.save(name, bytes)


def fin():
    _fileCache.fin()


# PRIVATE

import os
import shutil
import traceback

import BigWorld
from account_helpers import CustomFilesCache

from logger import *


class _FileCache():
    def __init__(self):
        try:
            self.cache_dir = 'res_mods/mods/shared_resources/xvm/cache'
            self.clean()
            self.customFilesCache = CustomFilesCache.CustomFilesCache()
        except Exception:
            err(traceback.format_exc())

    def fin(self):
        self.customFilesCache.close()
        self.customFilesCache = None
        self.clean()

    def clean(self):
        if os.path.isdir(self.cache_dir):
            shutil.rmtree(self.cache_dir)

    def get_url(self, url, callback):
        if self.customFilesCache:
            self.customFilesCache.get(url, callback)

    def save(self, name, bytes):
        try:
            path = os.path.join(self.cache_dir, name)
            dirname = os.path.dirname(path)
            if not os.path.isdir(dirname):
                os.makedirs(dirname)
            with open(path, 'wb') as f:
                f.write(bytes)
        except Exception:
            err(traceback.format_exc())

_fileCache = _FileCache()
