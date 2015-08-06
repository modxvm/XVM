""" XVM (c) www.modxvm.com 2013-2015 """

#############################
# Command

def ping():
    _ping.ping()

#############################
# Private

LINUX_PING_PATH_IN_WINE = "C:\\ping.exe"

import traceback
import threading
import os
import re
from subprocess import Popen, PIPE, STARTUPINFO, STARTF_USESHOWWINDOW, SW_HIDE

import BigWorld
import ResMgr

# import simplejson

from xfw import *
from xvm_main.python.logger import *
import xvm_main.python.config as config

#############################

"""
NOTE: ICMP requires root privileges. Don't use it.
"""
class _Ping(object):

    def __init__(self):
        self.lock = threading.RLock()
        self.thread = None
        self.resp = None

        self.hosts = list()
        loginSection = ResMgr.openSection('scripts_config.xml')['login']
        if loginSection is not None:
            for (name, subSec) in loginSection.items():
                self.hosts.append({
                    'name': subSec.readStrings('name')[0],
                    'url': subSec.readStrings('url')[0]})

    def ping(self):
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
            from gui.shared.utils.HangarSpace import g_hangarSpace
            res = dict()
            for host in self.hosts:
                res[host['name']] = config.get('hangar/pingServers/errorString', '--') if g_hangarSpace.inited else config.get('login/pingServers/errorString', '--')
            if os.path.exists(LINUX_PING_PATH_IN_WINE):
                (pattern, processes) = self._pingAsyncLinux()
            else:
                (pattern, processes) = self._pingAsyncWindows()

            # Parse ping output
            best_ping = 999
            for x in self.hosts:
                proc = processes[x['name']]

                out, er = proc.communicate()
                errCode = proc.wait()
                if errCode != 0:
                    continue

                found = re.search(pattern, out)
                if not found:
                    res[x['name']] = '?'
                    debug('Ping regexp not found in %s' % out.replace('\n', '\\n'))
                    continue

                res[x['name']] = found.group(1)
                best_ping = min(best_ping, int(found.group(1)))
            if (g_hangarSpace.inited and config.get('hangar/pingServers/showTitle')) or (not g_hangarSpace.inited and config.get('login/pingServers/showTitle')):
                res['###best_ping###'] = best_ping # will be first in sorting by server, key is replaced by localized "Ping"

        except Exception, ex:
            err('_pingAsync() exception: ' + traceback.format_exc())
        with self.lock:
            self.resp = res

    def _pingAsyncWindows(self):
        args = 'ping -n 1 -w 1000 '
        si = STARTUPINFO()
        si.dwFlags = STARTF_USESHOWWINDOW
        si.wShowWindow = SW_HIDE

        # Ping all servers in parallel
        processes = dict()
        for x in self.hosts:
            processes[x['name']] = Popen(args + x['url'].split(':')[0], stdout=PIPE, startupinfo=si)

        # pattern = '.*=.*=(\d+)[^\s].*=.*'   # original pattern, working with russian, not with others
        pattern = '.*=.*=(\d+).*[^\s].*=.*'  # fixed pattern, need testing but should work with every language

        return (pattern, processes)

    def _pingAsyncLinux(self):
        args = LINUX_PING_PATH_IN_WINE + ' -c 1 -n -q -W 1 '
        env = dict(LANG='C')

        # Ping all servers in parallel
        processes = dict()
        for x in self.hosts:
            processes[x['name']] = Popen(args + x['url'].split(':')[0], stdout=PIPE, env=env, shell=True)

        # rtt min/avg/max/mdev = 20.457/20.457/20.457/0.000 ms
        pattern = '(\d+)[\d\.]*/[\d\.]+/'

        return (pattern, processes)

_ping = _Ping()
