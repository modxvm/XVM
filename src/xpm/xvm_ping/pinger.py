""" XVM (c) www.modxvm.com 2013-2017 """

#############################
# Command

def ping():
    _ping.ping()

def update_config(*args, **kwargs):
    _ping.update_config()

#############################
# Private

import traceback
import threading
import os
import re

import BigWorld
import ResMgr
from gui.shared.utils.HangarSpace import g_hangarSpace

from xfw import *
from xvm_main.python.logger import *
import xvm_main.python.config as config
from xvm_main.python.xvm import l10n

#Native module
import imp
XVMNativePing = imp.load_dynamic('XVMNativePing', './res_mods/mods/packages/xvm_ping/native/XVMNativePing.pyd')

#############################

"""
NOTE: ICMP requires root privileges. Don't use it.
"""
class _Ping(object):

    def __init__(self):
        self.lock = threading.RLock()
        self.thread = None
        self.resp = None
        self.done_config = False
        self.loginSection = ResMgr.openSection('scripts_config.xml')['login']

    def update_config(self):
        self.loginErrorString = l10n(config.get('login/pingServers/errorString', '--'))
        self.hangarErrorString = l10n(config.get('hangar/pingServers/errorString', '--'))
        self.loginShowTitle = config.get('login/pingServers/showTitle', True)
        self.hangarShowTitle = config.get('hangar/pingServers/showTitle', True)
        ignoredServers = config.get('hangar/pingServers/ignoredServers', [])

        self.hosts_urls = {}
        self.loginHosts = []
        self.hangarHosts = []
        if self.loginSection is not None:
            for (name, subSec) in self.loginSection.items():
                host_name = subSec.readStrings('name')[0]
                if 'Supertest' not in host_name:
                    if len(host_name) >= 13:
                        host_name = subSec.readStrings('short_name')[0]
                    elif host_name.startswith('WOT '):
                        host_name = host_name[4:]
                self.hosts_urls[host_name] = subSec.readStrings('url')[0]
                self.loginHosts.append(host_name)
                if host_name not in ignoredServers:
                    self.hangarHosts.append(host_name)
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
            except Exception, ex:
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
            for host in (self.hangarHosts if g_hangarSpace.inited else self.loginHosts):
                hostping = XVMNativePing.ping(self.hosts_urls[host].split(':')[0])

                if hostping<0:
                    res.append({'cluster': host, 'time': (self.hangarErrorString if g_hangarSpace.inited else self.loginErrorString)})
                    debug('Ping has returned non-zero status: %d' % hostping)
                    continue
                
                res.append({'cluster': host, 'time': hostping})
                best_ping = min(best_ping, hostping)
            if (g_hangarSpace.inited and self.hangarShowTitle) or (not g_hangarSpace.inited and self.loginShowTitle):
                res.insert(0, {'cluster': '###best_ping###', 'time': best_ping}) # will appear first, key is replaced by localized "Ping"

        except Exception, ex:
            err('_pingAsync() exception: ' + traceback.format_exc())
        
        with self.lock:
            self.resp = res

_ping = _Ping()
