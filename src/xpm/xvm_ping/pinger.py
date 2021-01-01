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

#############################
# Public

def ping():
    _ping.ping()

def update_config(*args, **kwargs):
    _ping.update_config()

#############################
# Private

#cpython
import logging
import traceback
import threading

#BigWorld
import BigWorld
import ResMgr
from helpers import dependency
from skeletons.gui.shared.utils import IHangarSpace

#xfw.loader
import xfw_loader.python as loader

#xfw.libraries
from xfw import *

#xfw.actionscript
from xfw_actionscript.python import *

#xvm.main
from xvm_main.python.logger import *
import xvm_main.python.config as config
from xvm_main.python.xvm import l10n


class _Ping(object):
    hangarSpace = dependency.descriptor(IHangarSpace)

    def __init__(self):
        self.xfwping = None
        self.lock = threading.RLock()
        self.thread = None
        self.resp = None
        self.done_config = False
        self.loginSection = ResMgr.openSection('scripts_config.xml')['login']

        #import XFW.Ping
        self.xfwping = loader.get_mod_module('com.modxvm.xfw.ping')
        if not self.xfwping:
            logging.warning("[XVM/Ping] [pinger/init]: failed to import XFW.Ping. Ping results will be unavailable.")

    def update_config(self):
        self.loginErrorString = l10n(config.get('login/pingServers/errorString', '--'))
        self.hangarErrorString = l10n(config.get('hangar/pingServers/errorString', '--'))
        self.loginShowTitle = config.get('login/pingServers/showTitle', True)
        self.hangarShowTitle = config.get('hangar/pingServers/showTitle', True)
        ignoredServersLogin = config.get('login/pingServers/ignoredServers', [])
        ignoredServersHangar = config.get('hangar/pingServers/ignoredServers', [])

        self.hosts_urls = {}
        self.loginHosts = []
        self.hangarHosts = []
        if self.loginSection is not None:
            for (name, subSec) in self.loginSection.items():
                host_name = subSec.readStrings('short_name')
                if len(host_name) > 0:
                    host_name = host_name[0]
                    if host_name not in ignoredServersLogin:
                        self.loginHosts.append(host_name)
                    if host_name not in ignoredServersHangar:
                        self.hangarHosts.append(host_name)

                self.hosts_urls[host_name] = subSec.readStrings('url')[0]

            alphanumeric_sort(self.loginHosts)
            alphanumeric_sort(self.hangarHosts)
            self.done_config = True

    def ping(self):
        if not self.done_config:
            return
        with self.lock:
            if self.thread is not None:
                return
        self.resp = None
        # create thread
        self.thread = threading.Thread(target=self._pingAsync)
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
            except Exception:
                err('_checkResult() exception: ' + traceback.format_exc())
            finally:
                self.thread = None

    def _respond(self):
        # debug("respond: " + simplejson.dumps(self.resp))
        from . import XVM_PING_COMMAND
        as_xfw_cmd(XVM_PING_COMMAND.AS_PINGDATA, self.resp)

    # Threaded

    def _pingAsync(self):
        try:
            res = []

            # Parse ping output
            best_ping = 999
            for host in (self.hangarHosts if self.hangarSpace.inited else self.loginHosts):
                if self.xfwping is not None:
                    hostping = self.xfwping.ping(self.hosts_urls[host].split(':')[0])
                else:
                    hostping = 0

                if hostping < 0:
                    res.append({'cluster': host, 'time': (self.hangarErrorString if self.hangarSpace.inited else self.loginErrorString)})
                    debug('Ping has returned non-zero status: %d' % hostping)
                    continue

                res.append({'cluster': host, 'time': hostping})
                best_ping = min(best_ping, hostping)

            if (self.hangarSpace.inited and self.hangarShowTitle) or (not self.hangarSpace.inited and self.loginShowTitle):
                res.insert(0, {'cluster': '###best_ping###', 'time': best_ping}) # will appear first, key is replaced by localized "Ping"

        except Exception:
            err('_pingAsync() exception: ' + traceback.format_exc())

        with self.lock:
            self.resp = res

_ping = _Ping()
