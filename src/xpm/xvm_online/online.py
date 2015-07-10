""" XVM (c) www.modxvm.com 2013-2015 """

#############################
# Command

def online():
    _get_online.get_online()

import traceback
import threading

import BigWorld
import ResMgr

from xfw import *
import xfw.constants as xfw_constants
from xvm_main.python.logger import *
from xvm_main.python.loadurl import loadUrl
import xvm_main.python.config as config

#############################

"""
NOTE: ICMP requires root privileges. Don't use it.
"""
class _Get_online(object):

    def __init__(self):
        self.lock = threading.RLock()
        self.thread = None
        self.resp = None
        if GAME_REGION not in xfw_constants.URLS.WG_API_SERVERS:
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
            (response, delay, error) = loadUrl(xfw_constants.URLS.WG_API_SERVERS[GAME_REGION] + '/wgn/servers/info/', body='application_id=demo&game=wot', showLog=False)
            response_data = eval(response).get('data', {}).get('wot', {})
            res = {}
            best_online = 0
            if error or type(response_data) is not list:
                for host in self.hosts:
                    res[host] = 'Error'
            else:
                for host in response_data:
                    res[host['server']] = host['players_online']
                    best_online = max(best_online, int(host['players_online']))
                from ConnectionManager import connectionManager
                if (connectionManager.isConnected() and config.get('hangar/onlineServers/showTitle')) or (not connectionManager.isConnected() and config.get('login/onlineServers/showTitle')):
                    res['###best_online###'] = str(best_online)  # will be first in sorting, key is replaced by localized "Online"
            with self.lock:
                self.resp = res

        except Exception, ex:
            err('_pingAsync() exception: ' + traceback.format_exc())
            with self.lock:
                self.resp = {"Error": ex}

_get_online = _Get_online()
