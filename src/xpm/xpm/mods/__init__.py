""" Mods loader (c) sirmax 2013 """

import gui.mods.xpm

import ResMgr
import glob
import os
from gui import VERSION_FILE_PATH

ver = ResMgr.openSection(VERSION_FILE_PATH).readString('version')
ver = ver[2:-5] # 'v.0.8.7 #512' or 'v.0.8.7 Common Test #499'
wd = 'res_mods/%s/%s' % (ver, os.path.dirname(__file__))
for m in glob.iglob(wd + "/*"):
    if os.path.isdir(m) and os.path.exists(m + "/__init__.pyc"):
        try:
            m = m[m.replace("\\", "/").rfind("/")+1:]
            print("[XPM] Loading mod: " + m),
            mod = __import__("gui.mods." + m, globals(), locals(),
                ['XPM_MOD_VERSION',
                 'XPM_MOD_URL',
                 'XPM_MOD_UPDATE_URL',
                 'XPM_GAME_VERSIONS',
                ])
            print "%s (%s)" % (mod.XPM_MOD_VERSION, mod.XPM_MOD_URL)
            short_ver = ver[:5] # X.Y.Z
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
