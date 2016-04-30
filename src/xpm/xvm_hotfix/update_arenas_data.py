""" XVM (c) www.modxvm.com 2013-2016 """

import os
import traceback
import shutil

import BigWorld

from xfw import *
from fs.osfs import OSFS
from fs.zipfs import ZipFS

from xvm_main.python.logger import *
import xvm_main.python.userprefs as userprefs

def run():
    cache_dir = os.path.join(
        os.path.dirname(unicode(BigWorld.wg_getPreferencesFilePath(), 'utf-8', errors='ignore')),
        'xvm')
    arenas_data_dir = os.path.join(cache_dir, 'arenas_data')
    if not os.path.isdir(arenas_data_dir):
        return

    log('[xvm_hotfix] arenas_data directory found, repacking to zip')

    fs_zip = None
    fs_os = None
    try:
        arenas_data_zip = os.path.join(cache_dir, 'arenas_data.zip')
        fs_zip = ZipFS(arenas_data_zip, mode='a', compression='stored')
        fs_os = OSFS(arenas_data_dir)

        n = 0
        total = sum(1 for f in fs_os.walkfiles(wildcard='*.dat'))
        log('Total files: {}'.format(total))
        for f in fs_os.walkfiles(wildcard='*.dat'):
            n += 1
            if n % 1000 == 0:
                log('{}/{}'.format(n, total))
            if not fs_zip.exists(f):
                fs_zip.setcontents(f, fs_os.getcontents(f))

        fs_os.close()
        fs_os = None

        log('[xvm_hotfix] remove arenas_data directory')
        shutil.rmtree(arenas_data_dir)

        log('[xvm_hotfix] arenas_data directory repacking done')
    except Exception:
        err(traceback.format_exc())
    finally:
        if fs_zip is not None:
            fs_zip.close()
        if fs_os is not None:
            fs_os.close()
