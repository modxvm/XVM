""" xvm (c) sirmax 2013-2014 """

import traceback
import os
import glob

import simplejson as json

import BigWorld
import GUI

from xpm import *

from constants import *
from logger import *
from gameregion import *
from pinger import *
from stats import getBattleStat, getBattleResultsStat, getUserData
from dossier import getDossier
from vehinfo import getVehicleInfoData
from wn8 import getWN8ExpectedData
from token import getXvmStatTokenData
from test import runTest
import utils
from websock import g_websock

NO_LOG_COMMANDS = (
  COMMAND_LOG,
  COMMAND_LOAD_FILE,
  COMMAND_SET_CONFIG,
  COMMAND_GET_CONFIG,
  COMMAND_PING,
  COMMAND_GETMODS,
  COMMAND_GETVEHICLEINFODATA,
  COMMAND_GETWN8EXPECTEDDATA,
  COMMAND_GETXVMSTATTOKENDATA,
  COMMAND_GETSCREENSIZE,
  COMMAND_GETGAMEREGION,
  COMMAND_GETLANGUAGE,
  COMMAND_LOADUSERDATA,
  COMMAND_GETDOSSIER,
  COMMAND_OPEN_URL,
  )

class Xvm(object):
    def __init__(self):
        self.currentPlayerId = None
        self.config_str = None
        self.config = None

    def onXvmCommand(self, proxy, id, cmd, *args):
        try:
            #debug("id=" + str(id) + " cmd=" + str(cmd) + " args=" + json.dumps(args))
            if (cmd not in NO_LOG_COMMANDS):
                debug("cmd=" + str(cmd) + " args=" + json.dumps(args))
            res = None
            if cmd == COMMAND_LOG:
                log(*args)
            elif cmd == COMMAND_LOAD_FILE:
                res = load_file(os.path.join(XVM_DIR, args[0]))
            elif cmd == COMMAND_SET_CONFIG:
                log('setConfig')
                self.config_str = args[0]
                self.config = json.loads(self.config_str)
            elif cmd == COMMAND_GET_CONFIG:
                res = self.config_str
            elif cmd == COMMAND_PING:
                #return
                ping(proxy)
            elif cmd == COMMAND_GETMODS:
                #return
                res = self.getMods()
            elif cmd == COMMAND_GETSCREENSIZE:
                #return
                res = json.dumps(list(GUI.screenResolution()))
            elif cmd == COMMAND_GETGAMEREGION:
                #return
                res = region
            elif cmd == COMMAND_GETLANGUAGE:
                #return
                res = language
            elif cmd == COMMAND_GETVEHICLEINFODATA:
                #return
                res = getVehicleInfoData()
            elif cmd == COMMAND_GETWN8EXPECTEDDATA:
                res = getWN8ExpectedData()
            elif cmd == COMMAND_GETXVMSTATTOKENDATA:
                res = json.dumps(getXvmStatTokenData())
            elif cmd == COMMAND_LOADBATTLESTAT:
                getBattleStat(proxy, args)
            elif cmd == COMMAND_LOADBATTLERESULTSSTAT:
                getBattleResultsStat(proxy, args)
            elif cmd == COMMAND_LOADUSERDATA:
                getUserData(proxy, args)
            elif cmd == COMMAND_GETDOSSIER:
                getDossier(proxy, args)
            elif cmd == COMMAND_OPEN_URL:
                if len(args[0]) and args[0].lower().startswith('http://www.modxvm.com'):
                    utils.openWebBrowser(args[0], False)
            elif cmd == COMMAND_LOAD_SETTINGS:
                pass # TODO
            elif cmd == COMMAND_SAVE_SETTINGS:
                pass # TODO
            elif cmd == COMMAND_TEST:
                runTest(args)
            else:
                err("unknown command: " + str(cmd))
            proxy.movie.invoke(('xvm.respond', [id, res]))
        except Exception, ex:
            err(traceback.format_exc())

    def onKeyDown(self, event):
        # do not handle keys when chat is active
        #from messenger import MessengerEntry
        #if MessengerEntry.g_instance.gui.isFocused():
        #    return False
        #key = event.key
        #if event.isKeyDown() and not event.isRepeatedEvent():
        #    #debug("key=" + str(key))
        #    #return True
        #    pass
        return True

    def getMods(self):
        mods_dir = XVM_MODS_DIR
        if not os.path.isdir(mods_dir):
            return None
        mods = []
        for m in glob.iglob(mods_dir + "/*.swf"):
            m = m.replace('\\', '/')
            if not m.lower().endswith("/xvm.swf"):
                mods.append(m)
        return json.dumps(mods) if mods else None

    def onShowLobby(self, e=None):
        playerId = getCurrentPlayerId()
        if playerId is not None and self.currentPlayerId != playerId:
            self.currentPlayerId = playerId
            g_websock.send('id/%d' % playerId)

    def onShowLogin(self, e=None):
        if self.currentPlayerId is not None:
            self.currentPlayerId = None
            g_websock.send('id')

g_xvm = Xvm()


from . import XPM_MOD_VERSION, XPM_MOD_URL, XPM_GAME_VERSIONS
log("xvm %s (%s) for WoT %s" % (XPM_MOD_VERSION, XPM_MOD_URL, ", ".join(XPM_GAME_VERSIONS)))
try:
    from __version__ import __revision__
    log("Revision: " + __revision__)
except Exception, ex:
    err(traceback.format_exc())
