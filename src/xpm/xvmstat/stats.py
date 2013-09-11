""" xvm-stat (c) sirmax 2013 """

#############################
# Command

def getBattleStat(proxy, args):
    _stat.queue.put({
        'func':_stat.getBattleStat,
        'proxy':proxy,
        'method':RESPOND_STATDATA,
        'args':args})
    _stat.processQueue()

def getUserData(proxy, args):
    _stat.queue.put({
        'func':_stat.getUserStat,
        'proxy':proxy,
        'method':RESPOND_USERDATA,
        'args':args})
    _stat.processQueue()


#############################
# Private

from pprint import pprint
import datetime
import json
import traceback
from random import randint
from urllib2 import urlopen
import threading
import time
from Queue import Queue

import BigWorld
from items.vehicles import VEHICLE_CLASS_TAGS

from gui.mods.xpm import *
from constants import *
from logger import *
from gameregion import region

#############################

_PUBLIC_TOKEN = 'xpm'

class _Stat(object):

    def __init__(self):
        player = BigWorld.player()
        self.queue = Queue()
        self.lock = threading.RLock()
        self.thread = None
        self.req = None
        self.resp = None
        self.arenaId = None
        self.team = None
        self.players = None
        self.playersSkip = None
        self.cache = {}
        self.cacheUser = {}
        self.info = None
        self.servers = [ "http://proxy2.bulychev.net/%1" ] # TODO
        self.timeout = 30000

    def __del__(self):
        pass


    def processQueue(self):
        with self.lock:
            if self.thread is not None:
                return
        if self.queue.empty():
            return
        self.req = self.queue.get()
        self.resp = None
        self.thread = threading.Thread(target=self.req['func'])
        self.thread.daemon = True
        self.thread.start()
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
                self.processQueue()

    def _respond(self):
        #debug("respond: " + self.req['method'])
        if self.req['proxy'] and self.req['proxy'].component and self.req['proxy'].movie:
            strdata = json.dumps(self.resp)
            self.req['proxy'].movie.invoke((self.req['method'], [strdata]))

    # Threaded

    def getBattleStat(self):
        player = BigWorld.player()
        if player.arena is None:
            with self.lock:
                self.resp = {}
            return
        self._get_battle()


    def getUserData(self):
        self._get_user()


    def _get_battle(self):
        player = BigWorld.player()
        if player.arenaUniqueID != self.arenaId:
            self.arenaId = player.arenaUniqueID
            self.team = player.team
            self.players = {}
            self.playersSkip = {}

        self._update_players()

        self._load_stat()

        players = {}
        for vehId in self.players:
            pl = self.players[vehId]
            cacheKey = "%d=%s" % (pl.playerId, pl.vn)
            if cacheKey not in self.cache:
                cacheKey = "%d" % (pl.playerId)
                if cacheKey not in self.cache:
                    self.playersSkip[str(pl.playerId)] = True
                    players[pl.name] = self._get_battle_stub(pl)
                    continue
            players[pl.name] = self.cache[cacheKey]
        #pprint(players)

        with self.lock:
            self.resp = {'players': players, 'info': self.info}


    def _update_players(self):
        vehicles = BigWorld.player().arena.vehicles
        for (vId, vData) in vehicles.items():
            if vId not in self.players:
                self.players[vId] = _Player(vId, vData)
            self.players[vId].update(vData)


    def _load_stat(self):
        player = BigWorld.player()
        requestList = []

        for vehId in self.players:
            pl = self.players[vehId]
            cacheKey = "%d=%s" % (pl.playerId, pl.vn)

            if cacheKey in self.cache:
                continue
            if str(pl.playerId) in self.playersSkip:
                continue

            if pl.vn in [None, '', 'UNKNOWN']:
                requestList.append(str(pl.playerId))
            else:
                requestList.append("%d=%s%s" % (pl.playerId, pl.vn,
                        '=1' if pl.vehId == player.playerVehicleID else ''))

        if not requestList:
            return
        updateRequest = ','.join(requestList)

        if self.servers is None or len(self.servers) <= 0:
            err('Cannot read statistics: no suitable server was found.')
            return

        try:
            if self.req['args'][0] == True: # allowNetwork
                updateRequest = updateRequest.replace('?', '%3F') # for Chinese server
                server = self.servers[randint(0, len(self.servers) - 1)]
                responseFromServer, duration = self.loadUrl(server, updateRequest)

                if len(responseFromServer) <= 0:
                    err('Empty response or parsing error')
                    return

                data = json.loads(responseFromServer)
            else:
                players = []
                for vehId in self.players:
                    players.append(self._get_battle_stub(self.players[vehId]))
                data = {'players':players}

            if 'info' in data and region in data['info']:
                self.info = data['info'][region]

            if 'players' not in data:
                err('Stat request failed: ' + str(responseFromServer))
                return

            for stat in data['players']:
                #debug(json.dumps(stat))
                self._fix(stat)
                #pprint(stat)
                if 'nm' not in stat or not stat['nm']:
                    continue
                cacheKey = "%d%s" % (stat['_id'], "=" + stat['vn'] if stat['vn'] else '')
                self.cache[cacheKey] = stat

        except Exception, ex:
            err('_load_stat() exception: ' + traceback.format_exc(ex))


    def _get_user(self):
        (value, isId) = self.req['args']
        if isId:
            value = str(int(value))
        cacheKey = "%s,%d" % (value, isId)
        data = None
        if cacheKey not in self.cacheUser:
            try:
                req = "INFO/%s/%s" % ("ID" if isId else region, value)
                server = self.servers[randint(0, len(self.servers) - 1)]
                responseFromServer, duration = self.loadUrl(server, req)

                if not responseFromServer:
                    err('Empty response or parsing error')
                else:
                    data = json.loads(responseFromServer)[0]
                    if data is not None and 'nm' in data and '_id' in data:
                        self.cacheUser[data['nm'] + ",0"] = data
                        self.cacheUser[str(data['_id']) + ",1"] = data

            except Exception, ex:
                err('_get_user() exception: ' + traceback.format_exc(ex))

        with self.lock:
            self.resp = self.cacheUser[cacheKey] if cacheKey in self.cacheUser else None


    def _get_battle_stub(self, pl):
        return {
            '_id': pl.playerId,
            'nm': pl.name,
            'vn': pl.vn,
        }

    def loadUrl(self, url, members, test=False):
        if not test:
            log('  HTTP: ' + str(members), '[INFO]  ')

        url = url.replace('%1', members).replace('%2', _PUBLIC_TOKEN)
        #debug('loadUrl: ' + url )
        #time.sleep(10)

        duration = None
        responseFromServer = ''
        startTime = datetime.datetime.now()
        response = None

        try:
            response = urlopen(url=url, timeout=self.timeout / 1000)
            code = response.getcode()

            if code in [200, 202]:
                # 200 OK, 202 Accepted
                responseFromServer = response.read()

        except Exception, ex:
            err('loadUrl failed: ' + str(ex))
        finally:
            if response is not None:
                response.close()

        elapsed = datetime.datetime.now() - startTime
        msec = elapsed.seconds * 1000 + elapsed.microseconds / 1000
        log("  Time: %d ms, Size: %d bytes" % (msec, len(responseFromServer)), '[INFO]  ')
        #debug('responseFromServer: ' + responseFromServer)

        if not responseFromServer.lower().startswith('onexception'):
            duration = msec

        return responseFromServer, duration

    def _fix(self, stat):
        if 'twr' in stat:
            del stat['twr']
        self._r(stat, 'id', '_id')
        self._r(stat, 'name', 'nm')
        self._r(stat, 'date', 'dt')
        self._r(stat, 'status', 'st')
        self._r(stat, 'battles', 'b')
        self._r(stat, 'wins', 'w')
        self._r(stat, 'eff', 'e')
        self._r(stat, 'vname', 'vn')
        self._d(stat, 'lvl', '0')

        # TODO: optimize
        for vehId in self.players:
            pl = self.players[vehId]
            if pl.playerId == stat['_id']:
                stat['clan'] = pl.clan
                stat['name'] = pl.name
                stat['team'] = TEAM_ALLY if self.team == pl.team else TEAM_ENEMY
                stat['alive'] = pl.alive
                stat['ready'] = pl.ready
                if pl.vn == stat['vn'].upper():
                    stat['vname'] = pl.vName
                    stat['icon'] = pl.vIcon
                    stat['maxHealth'] = pl.maxHealth
                    stat['vtype'] = pl.vType
                    stat['level'] = pl.vLevel
                    pass
                break;

        return stat

    def _r(self, r, a, b):
        if a in r:
            if not b in r:
                r[b] = r[a]
            del r[a]

    def _d(self, r, a, d):
        if a not in r:
            r[a] = d


class _Player(object):

    def __init__(self, vehId, vData):
        self.vehId = vehId
        self.playerId = vData['accountDBID']
        self.name = vData['name']
        self.clan = vData['clanAbbrev']
        self.vName = vData['vehicleType'].type.shortUserString


    def update(self, vData):
        self.vName = vData['vehicleType'].type.shortUserString
        vId = vData['vehicleType'].type.id
        self.vId = (vId[0] << 4) | (vId[1] << 8)
        self.vLevel = vData['vehicleType'].type.level
        self.maxHealth = vData['vehicleType'].maxHealth
        self.vIcon = vData['vehicleType'].type.name.replace(':', '-')
        self.vn = vData['vehicleType'].type.name
        self.vn = self.vn[self.vn.find(':')+1:].upper()
        self.vType = set(VEHICLE_CLASS_TAGS.intersection(vData['vehicleType'].type.tags)).pop()
        self.team = vData['team']
        self.alive = vData['isAlive']
        self.ready = vData['isAvatarReady']


_stat = _Stat()
