""" XVM (c) www.modxvm.com 2013-2015 """

#############################
# Command

def getBattleStat(args, proxy=None):
    _stat.enqueue({
        'func': _stat.getBattleStat,
        'cmd': XVM_COMMAND.AS_STAT_BATTLE_DATA if proxy is None else AS2RESPOND.BATTLE_STAT_DATA,
        'args': args,
        'proxy': proxy})
    _stat.processQueue()

def getBattleResultsStat(args):
    _stat.enqueue({
        'func': _stat.getBattleResultsStat,
        'cmd': XVM_COMMAND.AS_STAT_BATTLE_RESULTS_DATA,
        'args': args})
    _stat.processQueue()

def getUserData(args):
    _stat.enqueue({
        'func': _stat.getUserData,
        'cmd': XVM_COMMAND.AS_STAT_USER_DATA,
        'args': args})
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
from gui.battle_control import g_sessionProvider
from items.vehicles import VEHICLE_CLASS_TAGS

from xfw import *

import config
from constants import *
import filecache
from logger import *
from loadurl import loadUrl
import utils
import vehinfo
import vehinfo_xte
import xvm_scale
import xvmapi


#############################

class _Stat(object):

    def __init__(self):
        player = BigWorld.player()
        self.queue = []  # HINT: Since WoT 0.9.0 use Queue() leads to Access Violation after client closing
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
        #debug('processQueue')
        with self.lock:
            if self.thread is not None:
                #debug('already working')
                return
        #debug('dequeue')
        self.req = self.dequeue()
        if self.req is None:
            #debug('no req')
            return
        self.resp = None
        self.thread = threading.Thread(target=self.req['func'])
        self.thread.daemon = False
        self.thread.start()
        # self.req['func']()
        #debug('start')
        # self._checkResult()
        BigWorld.callback(0, self._checkResult)


    def _checkResult(self):
        with self.lock:
            debug("checkResult: " + ("no" if self.resp is None else "yes"))
            if self.thread is not None:
                self.thread.join(0.01)  # 10 ms
            if self.resp is None:
                BigWorld.callback(0.05, self._checkResult)
                return
            try:
                self._respond()
            except Exception:
                err(traceback.format_exc())
            finally:
                #debug('done')
                if self.thread:
                    #debug('join')
                    self.thread.join()
                    #debug('thread deleted')
                    self.thread = None
                    # self.processQueue()
                    BigWorld.callback(0, self.processQueue)


    def _respond(self):
        debug("respond: " + self.req['cmd'])
        strdata = simplejson.dumps(self.resp)
        if not 'proxy' in self.req or self.req['proxy'] is None:
            as_xfw_cmd(self.req['cmd'], strdata)
        elif self.req['proxy'].component and self.req['proxy'].movie:
            self.req['proxy'].movie.invoke((self.req['cmd'], [strdata]))


    # Threaded

    def getBattleStat(self, tries=0):
        try:
            player = BigWorld.player()
            if player.__class__.__name__ == 'PlayerAvatar' and player.arena is not None:
                self._get_battle()
                return  # required to prevent deadlock
            else:
                debug('WARNING: arena not created, but getBattleStat() called')
            #    # Long initialization with high ping
            #    if tries < 5:
            #        time.sleep(1)
            #    self.getBattleStat(tries+1)
        except Exception:
            err(traceback.format_exc())
        with self.lock:
            if not self.resp:
                self.resp = {}


    def getBattleResultsStat(self):
        try:
            player = BigWorld.player()
            if player.__class__.__name__ == 'PlayerAccount':
                self._get_battleresults()
                return  # required to prevent deadlock
        except Exception:
            err(traceback.format_exc())
        with self.lock:
            if not self.resp:
                self.resp = {}


    def getUserData(self):
        try:
            self._get_user()
            return  # required to prevent deadlock
        except Exception:
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
        self._loadingClanIconsCount = 0
        vehicles = BigWorld.player().arena.vehicles
        for (vehId, vData) in vehicles.iteritems():
            if vehId not in self.players:
                pl = _Player(vehId, vData)
                self._load_clanIcon(pl)
                # cleanup same player with different vehId (bug?)
                self.players = {k:v for k,v in self.players.iteritems() if v.playerId != pl.playerId}
                self.players[vehId] = pl
            self.players[vehId].update(vData)

        # sleepCounter = 0
        while self._loadingClanIconsCount > 0:
            time.sleep(0.01)

            # # FIX: temporary workaround
            # sleepCounter += 1
            # if sleepCounter > 1000: # 10 sec
            #    log('WARNING: icons loading too long')
            #    break;

        plVehId = player.playerVehicleID if hasattr(player, 'playerVehicleID') else 0
        self._load_stat(plVehId)

        players = {}
        for (vehId, pl) in self.players.iteritems():
            cacheKey = "%d=%d" % (pl.playerId, pl.vId)
            if cacheKey not in self.cacheBattle:
                cacheKey2 = "%d" % pl.playerId
                if cacheKey2 not in self.cacheBattle:
                    self.cacheBattle[cacheKey] = self._get_battle_stub(pl)
            stat = self.cacheBattle[cacheKey]
            self._fix(stat)
            players[pl.name] = stat
        # pprint(players)

        with self.lock:
            self.resp = {'players': players}


    def _get_battleresults(self):
        (arenaUniqueId,) = self.req['args']
        player = BigWorld.player()
        player.battleResultsCache.get(int(arenaUniqueId), self._battleResultsCallback)


    def _battleResultsCallback(self, responseCode, value=None, revision=0):
        try:
            if responseCode < 0:
                with self.lock:
                    self.resp = {}
                return

            # pprint(value)

            self.players = {}

            # update players
            for (vehId, vehData) in value['vehicles'].iteritems():
                accountDBID = vehData[0]['accountDBID']
                plData = value['players'][accountDBID]
                vData = {
                    'accountDBID': accountDBID,
                    'name': plData['name'],
                    'clanAbbrev': plData['clanAbbrev'],
                    'typeCompDescr': vehData[0]['typeCompDescr'],
                    'team': vehData[0]['team']}
                self.players[vehId] = _Player(vehId, vData)

            self._load_stat(0)

            players = {}
            for (vehId, pl) in self.players.iteritems():
                cacheKey = "%d=%d" % (pl.playerId, pl.vId)
                if cacheKey not in self.cacheBattle:
                    cacheKey2 = "%d" % pl.playerId
                    if cacheKey2 not in self.cacheBattle:
                        self.cacheBattle[cacheKey] = self._get_battle_stub(pl)
                stat = self.cacheBattle[cacheKey]
                self._fix(stat)
                players[pl.name] = stat
            # pprint(players)

            with self.lock:
                self.resp = {'arenaUniqueId': value['arenaUniqueID'], 'players': players}

        except Exception:
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
        reg = GAME_REGION
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
                token = config.token.token
                if token is None:
                    err('No valid token for XVM network services (key=%s)' % cacheKey)
                else:
                    if isId:
                        data = xvmapi.getStatsById(value)
                    else:
                        data = xvmapi.getStatsByNick(reg, value)

                    if data is not None:
                        data = data[0]
                        self._fix_user(data, None if isId else orig_value)
                        if 'nm' in data and '_id' in data:
                            self.cacheUser[reg + "/" + data['nm']] = data
                            self.cacheUser["ID/" + str(data['_id'])] = data
                    else:
                        self.cacheUser[cacheKey] = {}
            except Exception:
                err(traceback.format_exc())

        with self.lock:
            self.resp = self.cacheUser.get(cacheKey, {})


    def _get_battle_stub(self, pl):
        s = {
            '_id': pl.playerId,
            'nm': pl.name,
            'v': {'id': pl.vId},
        }
        return self._fix(s)


    def _load_stat(self, playerVehicleID):
        requestList = []

        replay = isReplay()
        all_cached = True
        for (vehId, pl) in self.players.iteritems():
            cacheKey = "%d=%d" % (pl.playerId, pl.vId)

            if cacheKey not in self.cacheBattle:
                all_cached = False

            requestList.append("%d=%d%s" % (
                pl.playerId,
                pl.vId,
                '=1' if not replay and pl.vehId == playerVehicleID else ''))

        if all_cached or not requestList:
            return

        try:
            if config.networkServicesSettings.statBattle:
                token = config.token.token
                if token is None:
                    playerId = getCurrentPlayerId() if not isReplay() else userprefs.get('tokens.lastPlayerId')
                    err('No valid token for XVM network services (id=%s)' % playerId)
                    return

                cmd = 'rplstat' if isReplay() else 'stat'
                updateRequest = '%s/%s/%s' % (cmd, tdata['token'].encode('ascii'), ','.join(requestList))

                if XVM.SERVERS is None or len(XVM.SERVERS) <= 0:
                    err('Cannot read data: no suitable server was found.')
                    return

                server = XVM.SERVERS[randint(0, len(XVM.SERVERS) - 1)]
                (response, duration, errStr) = loadUrl(server, updateRequest, api=XVM.API_VERSION_OLD)

                if not response:
                    # err('Empty response or parsing error')
                    return

                data = simplejson.loads(response)
                if 'players' not in data:
                    err('Stat request failed: ' + str(response))
                    return

            else:
                if isReplay():
                    log('XVM network services inactive (id=%s)' % playerVehicleID)
                players = []
                for (vehId, pl) in self.players.iteritems():
                    players.append(self._get_battle_stub(pl))
                data = {'players': players}

            for stat in data['players']:
                # debug(simplejson.dumps(stat))
                self._fix(stat)
                # pprint(stat)
                if 'nm' not in stat or not stat['nm']:
                    continue
                if 'b' not in stat or stat['b'] <= 0:
                    continue
                cacheKey = "%d=%d" % (stat['_id'], stat.get('v', {}).get('id', 0))
                self.cacheBattle[cacheKey] = stat

        except Exception:
            err(traceback.format_exc())


    def _fix(self, stat, orig_name=None):
        self._fix_common(stat)

        player = BigWorld.player()
        team = player.team if hasattr(player, 'team') else 0

        if self.players is not None:
            # TODO: optimize
            for (vehId, pl) in self.players.iteritems():
                if pl.playerId == stat['_id']:
                    if pl.clan:
                        stat['clan'] = pl.clan
                        stat['clanInfoId'] = pl.clanInfo.get('cid', None) if pl.clanInfo else None
                        stat['clanInfoRank'] = pl.clanInfo.get('rank', None) if pl.clanInfo else None
                    stat['name'] = pl.name
                    stat['team'] = TEAM.ALLY if team == pl.team else TEAM.ENEMY
                    stat['squadnum'] = pl.squadnum
                    if hasattr(pl, 'alive'):
                        stat['alive'] = pl.alive
                    if hasattr(pl, 'ready'):
                        stat['ready'] = pl.ready
                    if stat.get('emblem', '') == '' and hasattr(pl, 'emblem'):
                        stat['emblem'] = pl.emblem
                    if 'id' not in stat['v']:
                        stat['v']['id'] = pl.vId
                    break

        self._fix_common2(stat, orig_name, False)
        self._addContactData(stat)
        # log(simplejson.dumps(stat))
        return stat


    def _fix_user(self, stat, orig_name=None):
        self._fix_common(stat)
        self._fix_common2(stat, orig_name, True)
        self._addContactData(stat)
        # log(simplejson.dumps(stat))
        return stat


    def _fix_common(self, stat):
        if 'v' not in stat:
            stat['v'] = {}
        if stat.get('e', 0) <= 0:
            stat['e'] = None
        if stat.get('wn6', 0) <= 0:
            stat['wn6'] = None
        if stat.get('wn8', 0) <= 0:
            stat['wn8'] = None
        if stat.get('wgr', 0) <= 0:
            stat['wgr'] = None


    def _fix_common2(self, stat, orig_name, multiVehicles):
        if orig_name is not None:
            stat['name'] = orig_name
        if 'b' in stat and 'w' in stat and stat['b'] > 0:
            self._calculateGWR(stat)
            self._calculateXvmScale(stat)
            if multiVehicles:
                for vehId, vdata in stat['v'].iteritems():
                    vdata['id'] = int(vehId)
                    self._calculateVehicleValues(stat, vdata)
                    self._calculateXTE(vdata)
            else:
                vdata = stat['v']
                if 'id' in vdata:
                    self._calculateVehicleValues(stat, vdata)
                    self._calculateXTE(vdata)


    # Global Win Rate (GWR)
    def _calculateGWR(self, stat):
        stat['winrate'] = float(stat['w']) / float(stat['b']) * 100.0


    # XVM Scale
    def _calculateXvmScale(self, stat):
        if 'e' in stat and stat['e'] > 0:
            stat['xeff'] = xvm_scale.XEFF(stat['e'])
        if 'wn6' in stat and stat['wn6'] > 0:
            stat['xwn6'] = xvm_scale.XWN6(stat['wn6'])
        if 'wn8' in stat and stat['wn8'] > 0:
            stat['xwn8'] = xvm_scale.XWN8(stat['wn8'])
        if 'wgr' in stat and stat['wgr'] > 0:
            stat['xwgr'] = xvm_scale.XWGR(stat['wgr'])


    # calculate Vehicle values
    def _calculateVehicleValues(self, stat, v):
        vehId = v['id']
        vData = vehinfo.getVehicleInfoData(vehId)
        if vData is None:
            return
        #log(vData['key'])
        #log(vData)

        # tank rating
        if 'b' not in v or 'w' not in v or v['b'] <= 0:
            v['winrate'] = stat['winrate']
        else:
            Tr = float(v['w']) / float(v['b']) * 100.0
            if v['b'] > 100:
                v['winrate'] = Tr
            else:
                Or = float(stat['winrate'])
                Tb = float(v['b']) / 100.0
                Tl = float(min(vData['level'], 4)) / 4.0
                v['winrate'] = Or - (Or - Tr) * Tb * Tl

        if 'b' not in v or v['b'] <= 0:
            return

        vb = float(v['b'])
        if 'dmg' in v and v['dmg'] > 0:
            v['db'] = float(v['dmg']) / vb
            v['dv'] = float(v['dmg']) / vb / vData['hpTop']
        if 'frg' in v and v['frg'] > 0:
            v['fb'] = float(v['frg']) / vb
        if 'spo' in v and v['spo'] > 0:
            v['sb'] = float(v['spo']) / vb


    # calculate xTE
    def _calculateXTE(self, v):
        if 'db' not in v or v['db'] <= 0:
            return
        if 'fb' not in v or v['fb'] <= 0:
            return
        v['xte'] = vehinfo_xte.calculateXTE(v['id'], float(v['db']), float(v['fb']))
        #log(v['xte'])


    def _addContactData(self, stat):
        # try to add changed nick and comment
        try:
            import xvm_contacts.python.contacts as contacts
            stat['xvm_contact_data'] = contacts.getXvmContactData(stat['_id'])
        except Exception:
            #err(traceback.format_exc())
            pass


    def _load_clanIcon(self, pl):
        try:
            if pl.clanInfo:
                rank = int(pl.clanInfo.get('rank', -1))
                url = pl.clanInfo.get('emblem', None)
                # url = 'http://stat.modxvm.com:81'
                if url and 0 <= rank <= config.networkServicesSettings.topClansCount:
                    url = url.replace('{size}', '32x32')
                    tID = 'icons/clan/{0}'.format(pl.clanInfo['cid'])
                    self._loadingClanIconsCount += 1
                    debug('clan={0} rank={1} url={2}'.format(pl.clan, rank, url))
                    filecache.get_url(url, (lambda url, bytes: self._load_clanIcons_callback(pl, tID, bytes)))
        except Exception:
            err(traceback.format_exc())


    def _load_clanIcons_callback(self, pl, tID, bytes):
        try:
            debug(tID + " " + (str(len(bytes)) if bytes else '(none)'))
            if bytes and imghdr.what(None, bytes) is not None:
                # imgid = str(uuid.uuid4())
                # BigWorld.wg_addTempScaleformTexture(imgid, bytes) # removed after first use?
                imgid = 'icons/{0}.png'.format(pl.clan)
                filecache.save(imgid, bytes)
                pl.emblem = 'xvm://cache/{0}'.format(imgid)
        except Exception:
            err(traceback.format_exc())
        finally:
            self._loadingClanIconsCount -= 1


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
            vtype = vData['vehicleType']
            if hasattr(vtype, 'type'):
                self.vId = vData['vehicleType'].type.compactDescr
        if self.vId is None:
            self.vId = 0
        self.team = vData['team']
        self.squadnum = 0
        arenaDP = g_sessionProvider.getCtx().getArenaDP()
        if arenaDP is not None:
            vInfo = arenaDP.getVehicleInfo(vID=vehId)
            self.squadnum = vInfo.squadIndex
            # if self.squadnum > 0:
            #    log("team=%d, squad=%d %s" % (self.team, self.squadnum, self.name))


    def update(self, vData):
        vtype = vData['vehicleType']
        if hasattr(vtype, 'type'):
            self.vId = vtype.type.compactDescr
            self.vLevel = vtype.type.level
            self.vIcon = vtype.type.name.replace(':', '-')
            # self.vn = vtype.type.name
            # self.vn = self.vn[self.vn.find(':')+1:].upper()
            self.vType = set(VEHICLE_CLASS_TAGS.intersection(vtype.type.tags)).pop()
        if hasattr(vtype, 'maxHealth'):
            self.maxHealth = vtype.maxHealth
        self.team = vData['team']
        self.alive = vData['isAlive']
        self.ready = vData['isAvatarReady']


_stat = _Stat()
