""" XVM (c) www.modxvm.com 2013-2015 """

# TODO: not updated for XFW

#############################
# Command

def ping(proxy):
    _ping.ping(proxy)

request_sent = False

#############################
# Private

import traceback

import BigWorld
import ResMgr

import simplejson
from logger import *
# from constants import *

#############################

"""
NOTE: Multiple BigWorld.WGPinger.ping() requests cannot be run simultaneously.
"""
class _Ping(object):

    def __init__(self):
        self.listeners = []
        self.preheat = 3

        self.hosts = list()
        loginSection = ResMgr.openSection('scripts_config.xml')['login']
        if loginSection is not None:
            for (name, subSec) in loginSection.items():
                self.hosts.append({
                    'name': subSec.readStrings('name')[0],
                    'url': subSec.readStrings('url')[0]})

    def ping(self, proxy):
        # debug("ping")
        if proxy not in self.listeners:
            self.listeners.append(proxy)

        self._do_ping()

    def _do_ping(self):
        global request_sent
        if request_sent:
            BigWorld.callback(0, self._do_ping)
            return

        try:
            # debug("ping: start")
            request_sent = True
            peripheries = map((lambda host: host['url']), self.hosts)
            BigWorld.WGPinger.setOnPingCallback(self._onPingPerformed)
            BigWorld.WGPinger.ping(peripheries)
        except:
            err('_do_ping() exception: ' + traceback.format_exc())

    def _onPingPerformed(self, result):
        # log("_onPingPerformed")
        try:
            # debug("ping: end")
            try:
                BigWorld.WGPinger.clearOnPingCallback()
            except:
                err('BigWorld.WGPinger.clearOnPingCallback() exception: ' + traceback.format_exc())

            global request_sent
            request_sent = False

            res = dict()
            for url, value in result:
                name = next(x['name'] for x in self.hosts if x['url'] == url)
                res[name] = value if name is not None else '?'

            if self.preheat > 0:
                self.preheat -= 1
                BigWorld.callback(0, self._do_ping)
            else:
                self._respond(res)
                self.listeners = []

        except Exception, ex:
            err('_onPingPerformed() exception: ' + traceback.format_exc())
            self._respond({"Error": ex})
            self.listeners = []

    def _respond(self, res):
        try:
            strdata = simplejson.dumps(res)
            for proxy in self.listeners:
                if proxy and hasattr(proxy, 'component') and hasattr(proxy, 'movie') and proxy.movie:
                    proxy.movie.invoke((AS2RESPOND.PINGDATA, [strdata]))
        except:
            err('_respond() exception: ' + traceback.format_exc())

_ping = _Ping()
