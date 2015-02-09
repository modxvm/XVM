""" XVM (c) www.modxvm.com 2013-2015 """

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
import uuid
import imghdr

import simplejson

import BigWorld
from items.vehicles import VEHICLE_CLASS_TAGS

from xfw import *

import config
from constants import *
import filecache
from logger import *
from loadurl import loadUrl
import token
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
        self.cacheBattle = {}
        self.cacheUser = {}

    def enqueue(self, req):
        with self.lock:
            self.queue.append(req)

    def dequeue(self):
        with self.lock:
            return self.queue.pop(0) if self.queue else None

    def processQueue(self):
        debug('processQueue')
        with self.lock:
            if self.thread is not None:
                debug('already working')
                return
        debug('dequeue')
        self.req = self.dequeue()
        if self.req is None:
            debug('no req')
            return
        self.resp = None
        self.thread = threading.Thread(target=self.req['func'])
        self.thread.daemon = False
        self.thread.start()
        #self.req['func']()
        debug('start')
        #self._checkResult()
        BigWorld.callback(0, self._checkResult)

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
                err(traceback.format_exc())
            finally:
                debug('done')
                if self.thread:
                    debug('join')
                    self.thread.join()
                    debug('thread deleted')
                    self.thread = None
                    #self.processQueue()
                    BigWorld.callback(0, self.processQueue)

    def _respond(self):
        debug("respond: " + self.req['method'])
        if self.req['proxy'] and self.req['proxy'].component and self.req['proxy'].movie:
            strdata = simplejson.dumps(self.resp)
            self.req['proxy'].movie.invoke((self.req['method'], [strdata]))

    # Threaded

    def getBattleStat(self, tries=0):
        try:
            player = BigWorld.player()
            if player.__class__.__name__ == 'PlayerAvatar' and player.arena is not None:
                self._get_battle()
                return # required to prevent deadlock
            else:
                debug('WARNING: arena not created, but getBattleStat() called')
            #    # Long initialization with high ping
            #    if tries < 5:
            #        time.sleep(1)
            #    self.getBattleStat(tries+1)
        except Exception, ex:
            err(traceback.format_exc())
        with self.lock:
            if not self.resp:
                self.resp = {}


    def getBattleResultsStat(self):
        try:
            player = BigWorld.player()
            if player.__class__.__name__ == 'PlayerAccount':
                self._get_battleresults()
                return # required to prevent deadlock
        except Exception, ex:
            err(traceback.format_exc())
        with self.lock:
            if not self.resp:
                self.resp = {}


    def getUserData(self):
        try:
            self._get_user()
            return # required to prevent deadlock
        except Exception, ex:
            err(traceback.format_exc())
        with self.lock:
            if not self.resp:
                self.resp = {}


    def _get_battle(self):
        player = BigWorld.player()
        if player.arenaUniqueID is None or self.arenaId != player.arenaUniqueID:
            self.arenaId = player.arenaUniqueID
            self.players = {}

        # update players
        vehicles = BigWorld.player().arena.vehicles
        for (vehId, vData) in vehicles.items():
            if vehId not in self.players:
                pl = _Player(vehId, vData)
                self._load_clanIcon(pl)
                self.players[vehId] = pl
            self.players[vehId].update(vData)

        plVehId = player.playerVehicleID if hasattr(player, 'playerVehicleID') else 0
        self._load_stat(plVehId)

        players = {}
        for (vehId, pl) in self.players.items():
            cacheKey = "%d=%d" % (pl.playerId, pl.vId)
            if cacheKey not in self.cacheBattle:
                cacheKey2 = "%d" % (pl.playerId)
                if cacheKey2 not in self.cacheBattle:
                    self.cacheBattle[cacheKey] = self._get_battle_stub(pl)
            stat = self.cacheBattle[cacheKey]
            self._fix(stat)
            players[pl.name] = stat
        #pprint(players)

        with self.lock:
            self.resp = {'players': players}


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

            # update players
            for (vehId, vehData) in value['vehicles'].items():
                accountDBID = vehData['accountDBID']
                plData = value['players'][accountDBID]
                vData = {
                  'accountDBID': accountDBID,
                  'name': plData['name'],
                  'clanAbbrev': plData['clanAbbrev'],
                  'typeCompDescr': vehData['typeCompDescr'],
                  'team': vehData['team']}
                self.players[vehId] = _Player(vehId, vData)

            self._load_stat(0)

            players = {}
            for (vehId, pl) in self.players.items():
                cacheKey = "%d=%d" % (pl.playerId, pl.vId)
                if cacheKey not in self.cacheBattle:
                    cacheKey2 = "%d" % (pl.playerId)
                    if cacheKey2 not in self.cacheBattle:
                        self.cacheBattle[cacheKey] = self._get_battle_stub(pl)
                stat = self.cacheBattle[cacheKey]
                self._fix(stat)
                players[pl.name] = stat
            #pprint(players)

            with self.lock:
                self.resp = {'arenaUniqueId': value['arenaUniqueID'], 'players': players}

        except Exception, ex:
            err(traceback.format_exc())
            print('=================================')
            print('_battleResultsCallback() exception: ' + traceback.format_exc())
            pprint(value)
            print('=================================')
            with self.lock:
                self.resp = {}


    def _get_user(self):
        (value, isId) = self.req['args']
        orig_value = value
        reg = gameRegion
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
                tdata = token.getXvmActiveTokenData()
                if tdata is None or not 'token' in tdata:
                    err('No valid token for XVM network services (key=%s)' % cacheKey)
                else:
                    tok = tdata['token'].encode('ascii')
                    if isId:
                        req = "user/%s/%s" % (tok, value)
                    else:
                        req = "nick/%s/%s/%s" % (tok, reg, value)
                    server = XVM_SERVERS[randint(0, len(XVM_SERVERS) - 1)]
                    (response, duration, errStr) = loadUrl(server, req)

                    #log(response)

                    if not response:
                        #err('Empty response or parsing error')
                        pass
                    else:
                        try:
                            data = None if response in ('', '[]') else simplejson.loads(response)[0]
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
                err(traceback.format_exc())

        with self.lock:
            self.resp = self.cacheUser.get(cacheKey, {})


    def _get_battle_stub(self, pl):
        s = {
            '_id': pl.playerId,
            'nm': pl.name,
            'v': { 'id':pl.vId },
        }
        return self._fix(s)


    def _load_stat(self, playerVehicleID):
        requestList = []

        replay = isReplay()
        all_cached = True
        for (vehId, pl) in self.players.items():
            cacheKey = "%d=%d" % (pl.playerId, pl.vId)

            if not cacheKey in self.cacheBattle:
                all_cached = False

            #if pl.vId in [None, '', 'UNKNOWN']:
            #    requestList.append(str(pl.playerId))
            #else:
            requestList.append("%d=%d%s" % (pl.playerId, pl.vId,
                '=1' if not replay and pl.vehId == playerVehicleID else ''))

        if all_cached or not requestList:
            return

        try:
            tdata = token.getXvmActiveTokenData()
            if token.networkServicesSettings['statBattle']:
                if tdata is None or not 'token' in tdata:
                    err('No valid token for XVM network services (id=%s)' % playerVehicleID)
                    return

                cmd = 'rplstat' if isReplay() else 'stat'
                updateRequest = '%s/%s/%s' % (cmd, tdata['token'].encode('ascii'), ','.join(requestList))

                if XVM_SERVERS is None or len(XVM_SERVERS) <= 0:
                    err('Cannot read data: no suitable server was found.')
                    return

                server = XVM_SERVERS[randint(0, len(XVM_SERVERS) - 1)]
                (response, duration, errStr) = loadUrl(server, updateRequest)

                if not response:
                    #err('Empty response or parsing error')
                    return

                data = simplejson.loads(response)
            else:
                if isReplay():
                    log('XVM network services inactive (id=%s)' % playerVehicleID)
                players = []
                for (vehId, pl) in self.players.items():
                    players.append(self._get_battle_stub(pl))
                data = {'players':players}

            if 'players' not in data:
                err('Stat request failed: ' + str(response))
                return

            for stat in data['players']:
                #debug(simplejson.dumps(stat))
                self._fix(stat)
                #pprint(stat)
                if 'nm' not in stat or not stat['nm']:
                    continue
                if 'b' not in stat or stat['b'] <= 0:
                    continue
                cacheKey = "%d=%d" % (stat['_id'], stat.get('v', {}).get('id', 0))
                self.cacheBattle[cacheKey] = stat

        except Exception, ex:
            err(traceback.format_exc())

    def _fix(self, stat, orig_name=None):
        if 'twr' in stat:
            del stat['twr']
        if not 'v' in stat:
            stat['v'] = {}
        # temporary workaround
        #if 'clan' in stat:
        #    del stat['clan']
        #if 'wn' in stat:
        #    del stat['wn']
        if stat.get('wn6', 0) <= 0:
            stat['wn6'] = None
        if stat.get('wn8', 0) <= 0:
            stat['wn8'] = None

        player = BigWorld.player()
        team = player.team if hasattr(player, 'team') else 0

        if self.players is not None:
            # TODO: optimize
            for (vehId, pl) in self.players.items():
                if pl.playerId == stat['_id']:
                    if pl.clan:
                        stat['clan'] = pl.clan
                        stat['clanInfoId'] = pl.clanInfo.get('cid', None) if pl.clanInfo else None
                        stat['clanInfoRank'] = pl.clanInfo.get('rank', None) if pl.clanInfo else None
                    stat['name'] = pl.name
                    stat['team'] = TEAM_ALLY if team == pl.team else TEAM_ENEMY
                    stat['squadnum'] = pl.squadnum
                    if hasattr(pl, 'alive'):
                        stat['alive'] = pl.alive
                    if hasattr(pl, 'ready'):
                        stat['ready'] = pl.ready
                    if stat.get('emblem', '') == '' and hasattr(pl, 'emblem'):
                        stat['emblem'] = pl.emblem
                    if 'id' not in stat['v']:
                        stat['v']['id'] = pl.vId
                    break;

        if orig_name is not None:
            stat['name'] = orig_name

        #log(simplejson.dumps(stat))
        return stat

    def _load_clanIcon(self, pl):
        try:
            if pl.clanInfo:
                rank = pl.clanInfo.get('rank', None)
                url = pl.clanInfo.get('emblem', None)
                if url and rank is not None and rank <= token.networkServicesSettings['topClansCount']:
                    url = url.replace('{size}', '32x32')
                    tID = 'icons/clan/{0}'.format(pl.clanInfo['cid'])
                    self._loading = True
                    filecache.get_url(url, (lambda url, bytes: self._load_clanIcons_callback(pl, tID, bytes)))
                    while self._loading:
                        time.sleep(0.001)
        except Exception, ex:
            err(traceback.format_exc())

    def _load_clanIcons_callback(self, pl, tID, bytes):
        try:
            #debug(tID + " " + str(len(bytes)))
            if bytes and imghdr.what(None, bytes) is not None:
                #imgid = str(uuid.uuid4())
                #BigWorld.wg_addTempScaleformTexture(imgid, bytes) # removed after first use?
                imgid = 'icons/{0}.png'.format(pl.clan)
                filecache.save(imgid, bytes)
                pl.emblem = 'xvm://cache/{0}'.format(imgid)
        except Exception, ex:
            err(traceback.format_exc())
        finally:
            self._loading = False


class _Player(object):

    __slots__ = ('vehId', 'playerId', 'name', 'clan', 'clanInfo', 'team', 'squadnum',
        'vId', 'vLevel', 'maxHealth', 'vIcon', 'vn', 'vType', 'alive', 'ready', 'emblem')

    def __init__(self, vehId, vData):
        self.vehId = vehId
        self.playerId = vData['accountDBID']
        self.name = vData['name']
        self.clan = vData['clanAbbrev']
        self.clanInfo = token.getClanInfo(self.clan)
        self.vId = None
        if 'typeCompDescr' in vData:
            self.vId = vData['typeCompDescr']
        elif 'vehicleType' in vData:
            self.vId = vData['vehicleType'].type.compactDescr
        else:
            self.vId = 0
        self.team = vData['team']
        self.squadnum = 0
        from gui.battle_control import g_sessionProvider
        arenaDP = g_sessionProvider.getCtx().getArenaDP()
        if arenaDP is not None:
            vInfo = arenaDP.getVehicleInfo(vID=vehId)
            self.squadnum = vInfo.squadIndex
            #if self.squadnum > 0:
            #    log("team=%d, squad=%d %s" % (self.team, self.squadnum, self.name))

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
