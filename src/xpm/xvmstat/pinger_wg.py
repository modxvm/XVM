""" XVM (c) www.modxvm.com 2013-2014 """

#############################
# Command

def ping(proxy):
    _ping.ping(proxy)

#############################
# Private

import traceback
import threading
import os
import re

import simplejson

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
        self.preheat = 3
        self.preheatlisteners = []

        self.hosts = list()
        loginSection = ResMgr.openSection('scripts_config.xml')['login']
        if loginSection is not None:
            for (name, subSec) in loginSection.items():
                self.hosts.append({
                    'name':subSec.readStrings('name')[0],
                    'url':subSec.readStrings('url')[0]})
        BigWorld.WGPinger.setOnPingCallback(self.__onPingPerformed)

    def ping(self, proxy):
        #debug("ping")
        if proxy not in self.listeners:
            self.listeners.append(proxy)
        with self.lock:
            if self.thread is not None:
                return
        self._ping()

    def _ping(self):
        #debug("_ping")
        # create thread
        self.thread = threading.Thread(target=self._pingAsync)
        self.thread.daemon = False
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
                err('_checkResult() exception: ' + traceback.format_exc())
            finally:
                self.thread = None
            # first results is too big
            if self.preheat > 0:
                self.preheat -= 1
                BigWorld.callback(1, self._preheat)

    def _preheat(self):
        for proxy in self.preheatlisteners:
            self.ping(proxy)

    def _respond(self):
        #debug("respond: " + simplejson.dumps(self.resp))
        try:
            strdata = simplejson.dumps(self.resp)
            for proxy in self.listeners:
                if proxy and hasattr(proxy, 'component') and hasattr(proxy, 'movie') and proxy.movie:
                    proxy.movie.invoke((RESPOND_PINGDATA, [strdata]))
        finally:
            if self.preheat > 0:
                self.preheatlisteners = self.listeners
            self.listeners = []

    # Threaded

    def __onPingPerformed(self, result):
        try:
            #log("__onPingPerformed")
            res = dict()
            for url, value in result:
                name = next(x['name'] for x in self.hosts if x['url'] == url)
                res[name] = value if name is not None else '?'
            with self.lock:
                self.resp = res
        except Exception, ex:
            err('_pingAsync() exception: ' + traceback.format_exc())
            with self.lock:
                self.resp = {"Error":ex}

    def _pingAsync(self):
        peripheries = map((lambda host: host['url']), self.hosts)
        BigWorld.WGPinger.ping(peripheries)

_ping = _Ping()
