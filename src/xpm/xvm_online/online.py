""" XVM (c) www.modxvm.com 2013-2015 """

#############################
# Command

def online():
    _get_online.get_online()

import traceback
import threading
from random import randint

import BigWorld
import ResMgr

from xfw import *
from xfw.constants import URLS
from xvm_main.python.logger import *
from xvm_main.python.constants import XVM
from xvm_main.python.loadurl import loadUrl
import xvm_main.python.config as config

#############################

class _Get_online(object):

    def __init__(self):
        self.lock = threading.RLock()
        self.thread = None
        self.resp = None
        if GAME_REGION not in URLS.WG_API_SERVERS:
            warn('xvm_online: no API available for this server')
            return
        self.hosts = []
        loginSection = ResMgr.openSection('scripts_config.xml')['login']
        if loginSection is not None:
            for (name, subSec) in loginSection.items():
                self.hosts.append(subSec.readStrings('name')[0])


    def get_online(self):
        with self.lock:
            if self.thread is not None:
                return
        self.resp = None
        # create thread
        self.thread = threading.Thread(target=self._getOnlineAsync)
        self.thread.daemon = False
        self.thread.start()
        # timer for result check
        BigWorld.callback(0.05, self._checkResult)

    def _checkResult(self):
        with self.lock:
            # debug("checkResult: " + ("no" if self.resp is None else "yes"))
            if self.resp is None:
                BigWorld.callback(0.05, self._checkResult)
                return
            try:
                self._respond()
            except Exception, ex:
                err('_checkResult() exception: ' + traceback.format_exc())
            finally:
                self.thread = None

    def _respond(self):
        from . import XVM_ONLINE_COMMAND
        as_xfw_cmd(XVM_ONLINE_COMMAND.AS_ONLINEDATA, self.resp)

    # Threaded
    def _getOnlineAsync(self):
        try:
            req = "onlineUsersCount/0"
            server = XVM.SERVERS[randint(0, len(XVM.SERVERS) - 1)]
            (response, delay, error) = loadUrl(server, req, showLog=False)
            region = GAME_REGION.lower()
            if 'CT' in URLS.WG_API_SERVERS: # CT is uncommented in xfw.constants to check on test server
                region = 'ru'
            response_data = eval(response).get(region, [])
            res = {}
            best_online = 0
            if error or type(response_data) is not list:
                for host in self.hosts:
                    res[host] = 'Error'
            else:
                for host in response_data:
                    if host['server'].find('US') == 0: # API return "US west" instead of "NA west" => can't determine current server
                        host['server'] = host['server'].replace('US ', 'NA ')
                    res[host['server']] = host['players_online']
                    best_online = max(best_online, int(host['players_online']))
                from gui.shared.utils.HangarSpace import g_hangarSpace
                if (g_hangarSpace.spaceInited and config.get('hangar/onlineServers/showTitle')) or (not g_hangarSpace.spaceInited and config.get('login/onlineServers/showTitle')):
                    res['###best_online###'] = str(best_online)  # will be first in sorting, key is replaced by localized "Online"
            with self.lock:
                self.resp = res

        except Exception, ex:
            err('_getOnlineAsync() exception: ' + traceback.format_exc())
            with self.lock:
                self.resp = {"Error": ex}

_get_online = _Get_online()
