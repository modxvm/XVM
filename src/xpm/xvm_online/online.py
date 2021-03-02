""" XVM (c) https://modxvm.com 2013-2021 """

#############################
# Command

def online():
    _get_online.get_online()

def update_config(*args, **kwargs):
    _get_online.update_config()

#############################
# imports

import traceback
import threading

import BigWorld
import ResMgr
from helpers import dependency
from skeletons.gui.shared.utils import IHangarSpace

from xfw import *
from xfw.constants import URLS
from xfw_actionscript.python import *

from xvm_main.python.logger import *
from xvm_main.python.xvm import l10n
import xvm_main.python.config as config
import xvm_main.python.xvmapi as xvmapi


#############################

class _Get_online(object):
    hangarSpace = dependency.descriptor(IHangarSpace)

    def __init__(self):
        self.loginSection = None
        if getRegion() not in URLS.WG_API_SERVERS:
            warn('xvm_online: no API available for this server')
            return
        self.lock = threading.RLock()
        self.thread = None
        self.resp = None
        self.done_config = False
        self.loginSection = ResMgr.openSection('scripts_config.xml')['login']
        self.region = getRegion().upper()
        if 'CT' in URLS.WG_API_SERVERS and self.region == 'CT': # CT is uncommented in xfw.constants to check on test server
            self.region = 'RU'

    def update_config(self):
        self.loginErrorString = l10n(config.get('login/onlineServers/errorString', '--k'))
        self.hangarErrorString = l10n(config.get('hangar/onlineServers/errorString', '--k'))
        self.loginShowTitle = config.get('login/onlineServers/showTitle', True)
        self.hangarShowTitle = config.get('hangar/onlineServers/showTitle', True)
        ignoredServersLogin = config.get('login/onlineServers/ignoredServers', [])
        ignoredServersHangar = config.get('hangar/onlineServers/ignoredServers', [])

        self.loginHosts = []
        self.hangarHosts = []
        self.peripheryIdMap = {}
        if self.loginSection is not None:
            for (name, subSec) in self.loginSection.items():
                host_name = subSec.readStrings('short_name')
                if len(host_name) > 0:
                    host_name = host_name[0]
                    if host_name not in ignoredServersLogin:
                        self.loginHosts.append(host_name)
                    if host_name not in ignoredServersHangar:
                        self.hangarHosts.append(host_name)
                    self.peripheryIdMap[subSec.readStrings('periphery_id')[0]] = host_name

            alphanumeric_sort(self.loginHosts)
            alphanumeric_sort(self.hangarHosts)
            self.done_config = True

    def get_online(self):
        if not self.done_config:
            return
        with self.lock:
            if self.thread is not None:
                return
        self.resp = None
        # create thread
        self.thread = threading.Thread(target=self._getOnlineAsync)
        self.thread.daemon = False
        self.thread.start()
        # timer for result check
        BigWorld.callback(1, self._checkResult)

    def _checkResult(self):
        with self.lock:
            # debug("checkResult: " + ("no" if self.resp is None else "yes"))
            if self.resp is None:
                BigWorld.callback(1, self._checkResult)
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
            data = xvmapi.getOnlineUsersCount()
            if not data:
                return
            # typical response:
            #{
            #    "EU":  [{"players_online":4297,"server":"EU2"},{"players_online":8331,"server":"EU1"}],
            #    "NA":  [{"players_online":22740,"server":"303"}],
            #    "ASIA":[{"players_online":6603,"server":"503"},{"players_online":6101,"server":"502"}],
            #    "RU":  [{"players_online":14845,"server":"RU8"},{"players_online":8597,"server":"RU2"},{"players_online":9847,"server":"RU1"},{"players_online":3422,"server":"RU3"},{"players_online":11508,"server":"RU6"},{"players_online":6795,"server":"RU5"},{"players_online":3354,"server":"RU4"}]
            #}
            data_dict = {}
            data_region = data.get(self.region, None)
            if not data_region:
                return
            for data_host in data_region:
                server = data_host['server']
                server = self.peripheryIdMap.get(server, server)
                data_dict[server] = data_host['players_online']

            res = []
            best_online = 0
            for host in (self.hangarHosts if self.hangarSpace.inited else self.loginHosts):
                best_online = max(best_online, int(data_dict.get(host, 0)))
                res.append({'cluster': host, 'people_online': data_dict.get(host, self.hangarErrorString if self.hangarSpace.inited else self.loginErrorString)})
            if (self.hangarSpace.inited and self.hangarShowTitle) or (not self.hangarSpace.inited and self.loginShowTitle):
                res.insert(0, {'cluster': '###best_online###', 'people_online': best_online})  # will appear first, key is replaced by localized "Online"
        except Exception, ex:
            err('_getOnlineAsync() exception: ' + traceback.format_exc())
        with self.lock:
            self.resp = res

_get_online = _Get_online()
