"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

# stdlib
import logging
import threading

# BigWorld
import BigWorld
import ResMgr
from skeletons.gui.shared.utils import IHangarSpace
from helpers import dependency

# OpenWG
import openwg_network

# XFW
from xfw import *

# XFW ActionScript
from xvm_actionscript import *

# XVM Main
import xvm_main.config as config
from xvm_main.utils import l10n



#
# Public
#

def ping():
    _ping.ping()


def update_config(*args, **kwargs):
    _ping.update_config()



#
# Classes
#

class _Ping(object):
    hangarSpace = dependency.descriptor(IHangarSpace)

    def __init__(self):
        self.thread = None
        self.lock = threading.RLock()
        self.response = None
        self.done_config = False
        self.loginSection = ResMgr.openSection('scripts_config.xml')['login']

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
        self.response = None
        # create thread
        self.thread = threading.Thread(target=self._pingAsync)
        self.thread.daemon = False
        self.thread.start()
        # timer for result check
        BigWorld.callback(0.05, self._checkResult)

    def _checkResult(self):
        with self.lock:
            # debug("checkResult: " + ("no" if self.resp is None else "yes"))
            if self.response is None:
                BigWorld.callback(0.05, self._checkResult)
                return
            try:
                self._respond()
            except Exception:
                logging.getLogger('XVM/Ping').exception('_checkResult')
            finally:
                self.thread = None

    def _respond(self):
        # debug("respond: " + json.dumps(self.resp))
        from . import XVM_PING_COMMAND
        as_xfw_cmd(XVM_PING_COMMAND.AS_PINGDATA, self.response)

    # Threaded
    def _pingAsync(self):
        try:
            if IS_WG and not dependency.isConfigured():
                logging.getLogger('XVM/Ping').error('dependency manager is not configured')
                return
            res = []

            # Parse ping output
            best_ping = 999
            for host in (self.hangarHosts if self.hangarSpace.inited else self.loginHosts):
                hostping = openwg_network.ping(self.hosts_urls[host].split(':')[0])

                if hostping < 0:
                    res.append({'cluster': host, 'time': (self.hangarErrorString if self.hangarSpace.inited else self.loginErrorString)})
                    # TODO: fixup DEBUG loglevel for stdlib logging
                    logging.getLogger('XVM/Ping').info('Ping has returned non-zero status: %s' % hostping)
                    continue

                res.append({'cluster': host, 'time': hostping})
                best_ping = min(best_ping, hostping)

            if (self.hangarSpace.inited and self.hangarShowTitle) or (not self.hangarSpace.inited and self.loginShowTitle):
                res.insert(0, {'cluster': '###best_ping###', 'time': best_ping}) # will appear first, key is replaced by localized "Ping"

        except Exception:
            logging.getLogger('XVM/Ping').exception('_pingAsync')

        with self.lock:
            self.response = res

_ping = _Ping()
