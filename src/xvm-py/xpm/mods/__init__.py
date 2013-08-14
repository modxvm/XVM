""" Mods loader (c) sirmax 2013 """

#IS_DEVELOPMENT = False
IS_DEVELOPMENT = True

#####################################################################

import ResMgr
import glob
import os
from gui import VERSION_FILE_PATH
ver = ResMgr.openSection(VERSION_FILE_PATH).readString('version')
pattern = 'res_mods/' + ver[2:7] + '/' + os.path.dirname(__file__) + '/*.pyc'
__all__ = [ os.path.basename(f)[:-4] for f in glob.iglob(pattern) ]

#####################################################################

import BigWorld

def _autoFlushPythonLog():
    BigWorld.flushPythonLog()
    BigWorld.callback(0.1, _autoFlushPythonLog)

if IS_DEVELOPMENT:
    _autoFlushPythonLog()
