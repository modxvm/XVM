""" xvm (c) sirmax 2013 """

#############################
# Command

def getBattleStat(proxy, args):
    _stat.queue.put({
        'func':_stat.getBattleStat,
        'proxy':proxy,
        'method':RESPOND_BATTLEDATA,
        'args':args})
    _stat.processQueue()

def getBattleResultsStat(proxy, args):
    _stat.queue.put({
        'func':_stat.getBattleResultsStat,
        'proxy':proxy,
        'method':RESPOND_BATTLERESULTSDATA,
        'args':args})
    _stat.processQueue()

def getUserData(proxy, args):
    _stat.queue.put({
        'func':_stat.getUserData,
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
import time
import StringIO
import gzip
from random import randint
from urlparse import urlparse
import httplib
from threading import Thread, RLock
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
        self.lock = RLock()
        self.thread = None
        self.req = None
        self.resp = None
        self.arenaId = None
        self.players = None
        self.playersSkip = None
        self.cache = {}
        self.cacheUser = {}
        self.info = None

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
        self.thread = Thread(target=self.req['func'])
        self.thread.start()
        self._checkResult()

    def _checkResult(self):
        with self.lock:
            #debug("checkResult: " + ("no" if self.resp is None else "yes"))
            self.thread.join(0.01) # 10 ms
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
        if player.__class__.__name__ == 'PlayerAvatar' and player.arena is not None:
            self._get_battle()
            return
        with self.lock:
            self.resp = {}


    def getBattleResultsStat(self):
        player = BigWorld.player()
        if player.__class__.__name__ == 'PlayerAccount':
            self._get_battleresults()
            return
        with self.lock:
            self.resp = {}


    def getUserData(self):
        self._get_user()


    def _get_battle(self):
        player = BigWorld.player()
        if player.arenaUniqueID is None or self.arenaId != player.arenaUniqueID:
            self.arenaId = player.arenaUniqueID
            self.players = {}
            self.playersSkip = {}

        # update players
        vehicles = BigWorld.player().arena.vehicles
        for (vehId, vData) in vehicles.items():
            if vehId not in self.players:
                self.players[vehId] = _Player(vehId, vData)
            self.players[vehId].update(vData)

        allowNetwork = self.req['args'][0]
        plVehId = player.playerVehicleID if hasattr(player, 'playerVehicleID') else 0
        self._load_stat(plVehId, allowNetwork)

        players = {}
        for vehId in self.players:
            pl = self.players[vehId]
            cacheKey = "%d=%d" % (pl.playerId, pl.vId)
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



    def _get_battleresults(self):
        (arenaUniqueId,) = self.req['args']
        player = BigWorld.player()
        player.battleResultsCache.get(int(arenaUniqueId), self._battleResultsCallback)

    def _battleResultsCallback(self, responseCode, value = None, revision = 0):
        try:
            if responseCode < 0:
                with self.lock:
                    self.resp = {}
                return

            #pprint(value)

            self.players = {}
            self.playersSkip = {}

            # update players
            for vehId in value['vehicles']:
                accountDBID = value['vehicles'][vehId]['accountDBID']
                vData = {
                  'accountDBID': accountDBID,
                  'name': value['players'][accountDBID]['name'],
                  'clanAbbrev': value['players'][accountDBID]['clanAbbrev'],
                  'typeCompDescr': value['vehicles'][vehId]['typeCompDescr'],
                  'team': value['vehicles'][vehId]['team']}
                self.players[vehId] = _Player(vehId, vData)

            self._load_stat(0)

            players = {}
            for vehId in self.players:
                pl = self.players[vehId]
                cacheKey = "%d=%d" % (pl.playerId, pl.vId)
                if cacheKey not in self.cache:
                    cacheKey = "%d" % (pl.playerId)
                    if cacheKey not in self.cache:
                        self.playersSkip[str(pl.playerId)] = True
                        players[pl.name] = self._get_battle_stub(pl)
                        continue
                players[pl.name] = self.cache[cacheKey]
            #pprint(players)

            with self.lock:
                self.resp = {'arenaUniqueId': value['arenaUniqueID'], 'players': players, 'info': self.info}

        except Exception, ex:
            err('_battleResultsCallback() exception: ' + traceback.format_exc(ex))
            print('=================================')
            print('_battleResultsCallback() exception: ' + traceback.format_exc(ex))
            pprint(value)
            print('=================================')
            with self.lock:
                self.resp = {}


    def _get_user(self):
        (value, isId) = self.req['args']
        orig_value = value
        reg = region
        if isId:
            value = str(int(value))
        else:
            if reg == "CT":
                suf = value[-3:]
                if suf in ('_RU', '_EU', '_NA', '_SG'):
                    reg = value[-2:]
                    value = value[:-3]
                else:
                    reg = "RU"
        cacheKey = "%s/%s" % ("ID" if isId else reg, value)
        data = None
        if cacheKey not in self.cacheUser:
            try:
                req = "INFO/" + cacheKey
                server = XVM_STAT_SERVERS[randint(0, len(XVM_STAT_SERVERS) - 1)]
                (response, duration) = self.loadUrl(server, req)

                if not response:
                    err('Empty response or parsing error')
                else:
                    try:
                        data = None if response in ('', '[]') else json.loads(response)[0]
                    except Exception, ex:
                        err('  Bad answer: ' + response)

                    if data is not None:
                        self._fix(data, None if isId else orig_value)
                        if 'nm' in data and '_id' in data:
                            self.cacheUser[reg + "/" + data['nm']] = data
                            self.cacheUser["ID/" + str(data['_id'])] = data
                    elif response == '[]':
                        self.cacheUser[cacheKey] = {}

            except Exception, ex:
                err('_get_user() exception: ' + traceback.format_exc(ex))

        with self.lock:
            self.resp = self.cacheUser[cacheKey] if cacheKey in self.cacheUser else {}


    def _get_battle_stub(self, pl):
        s = {
            '_id': pl.playerId,
            'nm': pl.name,
            'v': { 'id':pl.vId },
        }
        return self._fix(s, None)


    def _load_stat(self, playerVehicleID, allowNetwork=True):
        requestList = []

        for vehId in self.players:
            pl = self.players[vehId]
            cacheKey = "%d=%d" % (pl.playerId, pl.vId)

            if cacheKey in self.cache:
                continue
            if str(pl.playerId) in self.playersSkip:
                continue

            #if pl.vId in [None, '', 'UNKNOWN']:
            #    requestList.append(str(pl.playerId))
            #else:
            requestList.append("%d=%d%s" % (pl.playerId, pl.vId,
                '=1' if pl.vehId == playerVehicleID else ''))

        if not requestList:
            return
        updateRequest = ','.join(requestList)

        if XVM_STAT_SERVERS is None or len(XVM_STAT_SERVERS) <= 0:
            err('Cannot read statistics: no suitable server was found.')
            return

        try:
            if allowNetwork:
                server = XVM_STAT_SERVERS[randint(0, len(XVM_STAT_SERVERS) - 1)]
                (response, duration) = self.loadUrl(server, updateRequest)

                if len(response) <= 0:
                    err('Empty response or parsing error')
                    return

                data = json.loads(response)
            else:
                players = []
                for vehId in self.players:
                    players.append(self._get_battle_stub(self.players[vehId]))
                data = {'players':players}

            if 'info' in data and region in data['info']:
                self.info = data['info'][region]

            if 'players' not in data:
                err('Stat request failed: ' + str(response))
                return

            for stat in data['players']:
                #debug(json.dumps(stat))
                self._fix(stat, None)
                #pprint(stat)
                if 'nm' not in stat or not stat['nm']:
                    continue
                if 'b' not in stat or stat['b'] <= 0:
                    continue
                cacheKey = "%d=%d" % (stat['_id'], stat.get('v', {}).get('id', 0))
                self.cache[cacheKey] = stat

        except Exception, ex:
            err('_load_stat() exception: ' + traceback.format_exc(ex))


    def loadUrl(self, url, req):
        url = url.replace("{API}", XVM_STAT_API_VERSION).replace("{REQ}", req)
        u = urlparse(url)
        log('  HTTP: ' + u.path, '[INFO]  ')
        #time.sleep(5)

        duration = None
        response = ''
        responseSize = 0
        startTime = datetime.datetime.now()
        conn = None
        try:
            #log(u)
            conn = httplib.HTTPConnection(u.netloc, timeout=XVM_STAT_TIMEOUT/1000)
            conn.request("GET", u.path, None, {"Accept-Encoding":"gzip"}) # deflate
            resp = conn.getresponse()
            #log(resp.status)

            if resp.status in [200, 202]:
                # 200 OK, 202 Accepted

                response = resp.read()
                responseSize = len(response)

                encoding = resp.getheader('content-encoding')

                if encoding == 'gzip':
                    response = gzip.GzipFile(fileobj=StringIO.StringIO(response)).read()
                else:
                    raise Exception('Encoding not supported: ' + encoding)
            else:
                raise Exception('HTTP Error: [%i] %s' % (resp.status, resp.reason) )
            conn.close()

        except Exception, ex:
            err('loadUrl failed: ' + str(ex))
        finally:
            if conn is not None:
                conn.close()

        elapsed = datetime.datetime.now() - startTime
        msec = elapsed.seconds * 1000 + elapsed.microseconds / 1000
        log("  Time: %d ms, Size: %d (%d) bytes" % (msec, responseSize, len(response)), '[INFO]  ')
        #debug('response: ' + response)

        if not response.lower().startswith('onexception'):
            duration = msec

        return (response, duration)


    def _fix(self, stat, orig_name):
        #self._r(stat, 'id', '_id')
        if 'twr' in stat:
            del stat['twr']
        if 'v' not in stat:
            stat['v'] = {}
        # temporary workaround
        if 'clan' in stat:
            stat['clanstat'] = stat['clan']
            del stat['clan']

        player = BigWorld.player()
        from avatar import PlayerAvatar
        team = player.team if hasattr(player, 'team') else 0

        if self.players is not None:
            # TODO: optimize
            for vehId in self.players:
                pl = self.players[vehId]
                if pl.playerId == stat['_id']:
                    if pl.clan:
                        stat['clan'] = pl.clan
                    stat['name'] = pl.name
                    stat['team'] = TEAM_ALLY if team == pl.team else TEAM_ENEMY
                    if hasattr(pl, 'alive'):
                        stat['alive'] = pl.alive
                    if hasattr(pl, 'ready'):
                        stat['ready'] = pl.ready
                    if 'id' not in stat['v']:
                        stat['v']['id'] = pl.vId
                    break;

        if orig_name is not None:
            stat['name'] = orig_name

        #log(json.dumps(stat))
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
        self.vId = None
        if 'typeCompDescr' in vData:
            self.vId = vData['typeCompDescr']
        elif 'vehicleType' in vData:
            self.vId = vData['vehicleType'].type.compactDescr
        else:
            self.vId = 0
        self.team = vData['team']

    def update(self, vData):
        self.vId = vData['vehicleType'].type.compactDescr
        self.vLevel = vData['vehicleType'].type.level
        self.maxHealth = vData['vehicleType'].maxHealth
        self.vIcon = vData['vehicleType'].type.name.replace(':', '-')
        #self.vn = vData['vehicleType'].type.name
        #self.vn = self.vn[self.vn.find(':')+1:].upper()
        self.vType = set(VEHICLE_CLASS_TAGS.intersection(vData['vehicleType'].type.tags)).pop()
        self.team = vData['team']
        self.alive = vData['isAlive']
        self.ready = vData['isAvatarReady']


_stat = _Stat()
