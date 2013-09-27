""" xvm-stat (c) sirmax 2013 """

#############################
# Command

def ping(proxy):
    _ping.ping(proxy)

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

from logger import *
from constants import *

#############################

"""
NOTE: BigWorld.WGPinger can crash client, and it is blocking operation. Don't use it.
NOTE: ICMP requires root privileges. Don't use it.
"""
class _Ping(object):

    def __init__(self):
        self.listeners = []
        self.lock = threading.RLock()
        self.thread = None
        self.resp = None

        self.hosts = list()
        loginSection = ResMgr.openSection('scripts_config.xml')['login']
        if loginSection is not None:
            for (name, subSec) in loginSection.items():
                self.hosts.append({
                    'name':subSec.readStrings('name')[0],
                    'url':subSec.readStrings('url')[0]})

    def ping(self, proxy):
        if proxy not in self.listeners:
            self.listeners.append(proxy)
        with self.lock:
            if self.thread is not None:
                return
        self._ping()

    def _ping(self):
        # create thread
        self.thread = threading.Thread(target=self._pingAsync)
        self.thread.start()
        # timer for result check
        BigWorld.callback(0.05, self._checkResult)

    def _checkResult(self):
        with self.lock:
            #debug("checkResult: " + ("no" if self.resp is None else "yes"))
            if self.resp is None:
                BigWorld.callback(0.05, self._checkResult)
                return
            try:
                self._respond()
            except Exception, ex:
                err('_checkResult() exception: ' + traceback.format_exc(ex))
            finally:
                self.thread = None

    def _respond(self):
        #debug("respond: " + json.dumps(self.resp))
        try:
            strdata = json.dumps(self.resp)
            for proxy in self.listeners:
                if proxy and proxy.component and proxy.movie:
                    proxy.movie.invoke((RESPOND_PINGDATA, [strdata]))
        finally:
            self.listeners = []

    # Threaded

    def _pingAsync(self):
        try:
            if os.path.exists(LINUX_PING_PATH_IN_WINE):
                (pattern, processes) = self._pingAsyncLinux()
            else:
                (pattern, processes) = self._pingAsyncWindows()

            # Parse ping output
            res = dict()
            for x in self.hosts:
                proc = processes[x['name']]

                out, er = proc.communicate()
                errCode = proc.wait()
                if errCode != 0:
                    res[x['name']] = 'Error'
                    continue

                found = re.search(pattern, out)
                if not found:
                    res[x['name']] = '?'
                    err('Ping regexp not found in %s' % out.replace('\n', '\\n'))
                    continue

                res[x['name']] = found.group(1)

            with self.lock:
                self.resp = res

        except Exception, ex:
            err('_pingAsync() exception: ' + traceback.format_exc(ex))
            with self.lock:
                self.resp = {"Error":ex.message}

    def _pingAsyncWindows(self):
        args = 'ping -n 1 -w 1000 '
        si = STARTUPINFO()
        si.dwFlags = STARTF_USESHOWWINDOW
        si.wShowWindow = SW_HIDE

        # Ping all servers in parallel
        processes = dict()
        for x in self.hosts:
            processes[x['name']] = Popen(args + x['url'].split(':')[0], stdout=PIPE, startupinfo=si)

        # Ответ от 178.20.235.151: число байт=32 время=23мс TTL=58
        pattern = '.*=.*=(\d+)[^\s].*=.*'

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
