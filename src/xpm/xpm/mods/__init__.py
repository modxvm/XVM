""" XPM mods loader (c) www.modxvm.com 2013-2014 """

import glob
import os
import ResMgr
from gui import VERSION_FILE_PATH

# get version
ver = ResMgr.openSection(VERSION_FILE_PATH).readString('version')
ver = ver[2:-5] # 'v.0.8.7 #512' or 'v.0.8.7 Common Test #499'

# determine work dir
try:
    wd = None
    sec = ResMgr.openSection('../paths.xml')
    subsec = sec['Paths']
    vals = subsec.values()
    for val in vals:
        path = val.asString + '/scripts/client/gui/mods'
        if os.path.isdir(path) and os.path.isfile(path + '/lib/xpm.pyc'):
            wd = path
            break
    if not wd:
        raise Exception("xpm.pyc is not found in the paths")
except Exception, err:
    print ("[XPM] Error locating working directory: ", err)
    wd = 'res_mods/%s/%s' % (ver, os.path.dirname(__file__))
    print ("[XPM]   fallback to the default path: %s" % wd)

print "[XPM] Working dir: " + wd

# add libs to path
import sys
sys.path.insert(0, '%s/lib' % wd)

import xpm

# load mods
for m in glob.iglob('%s/*' % wd):
    if os.path.isdir(m) and os.path.exists('%s/__init__.pyc' % m):
        try:
            m = m[m.replace("\\", "/").rfind("/")+1:]
            print("[XPM] Loading mod: " + m),
            mod = __import__("gui.mods.%s" % m, globals(), locals(),
                ['XPM_MOD_VERSION',
                 'XPM_MOD_URL',
                 'XPM_MOD_UPDATE_URL',
                 'XPM_GAME_VERSIONS',
                ])
            print "%s (%s)" % (mod.XPM_MOD_VERSION, mod.XPM_MOD_URL)
            short_ver = ver[:5] if len(ver) < 6 or ver[5] == ' ' else ver[:6] # X.Y.Z or X.Y.ZZ
            if not short_ver in mod.XPM_GAME_VERSIONS:
                print "[XPM] WARNING: Mod is not tested for compatibility with the current version of the game"
                print "[XPM]          Game version:  " + short_ver
                print "[XPM]          Compatible:    " + ", ".join(mod.XPM_GAME_VERSIONS)
                if mod.XPM_MOD_UPDATE_URL:
                    print "[XPM]          Please look for updates on the mod's website:"
                    print "[XPM]            " + mod.XPM_MOD_UPDATE_URL
        except:
            print
            print "============================="
            print("[XPM] Error loading mod '" + m + "':")
            import traceback
            traceback.print_exc()
            print "============================="
