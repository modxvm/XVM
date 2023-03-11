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

def get_url(url, callback):
    _fileCache.get_url(url, callback)


def save(name, bytes):
    _fileCache.save(name, bytes)


# PRIVATE

import os
import shutil
import traceback

import game
from account_helpers import CustomFilesCache

from xfw.events import registerEvent

from consts import *
from logger import *


class _FileCache():
    def __init__(self):
        try:
            self.cache_dir = XVM.SHARED_RESOURCES_DIR + '/cache'
            self.clean()
            self.customFilesCache = CustomFilesCache.CustomFilesCache('xvm/custom_data')
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
        try:
            if self.customFilesCache:
                self.customFilesCache.get(url, callback)
        except Exception:
            err('filecache.get_url: ' + str(url))
            err(traceback.format_exc())

    def save(self, name, bytes):
        try:
            path = os.path.join(self.cache_dir, name)
            dirname = os.path.dirname(path)
            if not os.path.isdir(dirname):
                os.makedirs(dirname)
            with open(path, 'wb') as f:
                f.write(bytes)
        except Exception:
            err('filecache.save: ' + str(name))
            err(traceback.format_exc())

_fileCache = _FileCache()

@registerEvent(game, 'fini')
def fini():
    _fileCache.fin()
