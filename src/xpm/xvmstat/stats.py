""" xvm (c) sirmax 2013-2014 """

#############################
# Command

def getBattleStat(proxy, args):
    _stat.enqueue({
        'func':_stat.getBattleStat,
        'proxy':proxy,
        'method':RESPOND_BATTLEDATA,
        'args':args})
    _stat.processQueue()

def getBattleResultsStat(proxy, args):
    _stat.enqueue({
        'func':_stat.getBattleResultsStat,
        'proxy':proxy,
        'method':RESPOND_BATTLERESULTSDATA,
        'args':args})
    _stat.processQueue()

def getUserData(proxy, args):
    _stat.enqueue({
        'func':_stat.getUserData,
        'proxy':proxy,
        'method':RESPOND_USERDATA,
        'args':args})
    _stat.processQueue()


#############################
# Private

from pprint import pprint
import datetime
import traceback
import time
from random import randint
import threading

import simplejson as json

import BigWorld
from items.vehicles import VEHICLE_CLASS_TAGS

from xpm import *

from constants import *
from logger import *
from gameregion import region
from loadurl import loadUrl
from token import getXvmStatActiveTokenData
import utils

#############################

_PUBLIC_TOKEN = 'xpm'

class _Stat(object):

    def __init__(self):
        player = BigWorld.player()
        self.queue = [] # HINT: Since WoT 0.9.0 use Queue() leads to Access Violation after client closing
        self.lock = threading.RLock()
        self.thread = None
        self.req = None
        self.resp = None
        self.arenaId = None
        self.players = None
        self.playersSkip = None
        self.cache = {}
        self.cacheUser = {}
        self.info = None

    def enqueue(self, req):
        with self.lock:
            self.queue.append(req)

    def dequeue(self):
        with self.lock:
            return self.queue.pop(0) if self.queue else None

    def processQueue(self):
        with self.lock:
            if self.thread is not None:
                return
        self.req = self.dequeue()
        if self.req is None:
            return
        self.resp = None
        self.thread = threading.Thread(target=self.req['func'])
        self.thread.daemon = False
        self.thread.start()
        #self.req['func']()
        debug('start')
        self._checkResult()

    def _checkResult(self):
        with self.lock:
            debug("checkResult: " + ("no" if self.resp is None else "yes"))
            if self.thread is not None:
                self.thread.join(0.01) # 10 ms
            if self.resp is None:
                BigWorld.callback(0.05, self._checkResult)
                return
            try:
                self._respond()
            except Exception, ex:
                err('_checkResult() exception: ' + traceback.format_exc())
            finally:
                debug('done')
                if self.thread:
                    self.thread.join()
                    self.thread = None
                    self.processQueue()

    def _respond(self):
        debug("respond: " + self.req['method'])
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
            err('_battleResultsCallback() exception: ' + traceback.format_exc())
            print('=================================')
            print('_battleResultsCallback() exception: ' + traceback.format_exc())
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
                if suf in ('_RU', '_EU', '_NA', '_US', '_SG'):
                    reg = value[-2:]
                    value = value[:-3]
                    if reg == 'US':
                        reg = 'NA'
                else:
                    reg = "RU"
        cacheKey = "%s/%s" % ("ID" if isId else reg, value)
        data = None
        if cacheKey not in self.cacheUser:
            try:
                tdata = getXvmStatActiveTokenData()
                if tdata is None or not 'token' in tdata:
                    err('No valid token for XVM statistics (key=%s)' % cacheKey)
                else:
                    tok = tdata['token'].encode('ascii')
                    if isId:
                        req = "user/%s/%s" % (tok, value)
                    else:
                        req = "nick/%s/%s/%s" % (tok, reg, value)
                    server = XVM_STAT_SERVERS[randint(0, len(XVM_STAT_SERVERS) - 1)]
                    (response, duration) = loadUrl(server, req)

                    if not response:
                        #err('Empty response or parsing error')
                        pass
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
                err('_get_user() exception: ' + traceback.format_exc())

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

        replay = isReplay()
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
                '=1' if not replay and pl.vehId == playerVehicleID else ''))

        if not requestList:
            return

        try:
            if allowNetwork:
                tdata = getXvmStatActiveTokenData()
                if tdata is None or not 'token' in tdata:
                    err('No valid token for XVM statistics (id=%s)' % playerVehicleID)
                    return

                cmd = 'rplstat' if isReplay() else 'stat'
                updateRequest = '%s/%s/%s' % (cmd, tdata['token'].encode('ascii'), ','.join(requestList))

                if XVM_STAT_SERVERS is None or len(XVM_STAT_SERVERS) <= 0:
                    err('Cannot read statistics: no suitable server was found.')
                    return

                server = XVM_STAT_SERVERS[randint(0, len(XVM_STAT_SERVERS) - 1)]
                (response, duration) = loadUrl(server, updateRequest)

                if not response:
                    #err('Empty response or parsing error')
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
            err('_load_stat() exception: ' + traceback.format_exc())

    def _fix(self, stat, orig_name):
        #self._r(stat, 'id', '_id')
        if 'twr' in stat:
            del stat['twr']
        if not 'v' in stat:
            stat['v'] = {}
        # temporary workaround
        if 'clan' in stat:
            if not 'clanstat' in stat:
                stat['clanstat'] = stat['clan']
            del stat['clan']
        if 'wn' in stat:
            if not 'wn6' in stat:
                stat['wn6'] = stat['wn']
            del stat['wn']
        if stat.get('wn6', 0) <= 0:
            stat['wn6'] = None
        if stat.get('wn8', 0) <= 0:
            stat['wn8'] = None

        player = BigWorld.player()
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
                    stat['squadnum'] = pl.squadnum
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
        from gui.BattleContext import g_battleContext
        vInfo = g_battleContext.arenaDP.getVehicleInfo(vID=vehId)
        self.squadnum = vInfo.squadIndex

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
