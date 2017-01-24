""" XVM (c) www.modxvm.com 2013-2017 """

#############################
# Command

def getBattleStat(args, respondFunc):
    _stat.enqueue({
        'func': _stat.getBattleStat,
        'cmd': XVM_COMMAND.AS_STAT_BATTLE_DATA,
        'respondFunc': respondFunc,
        'args': args})
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

def getClanIcon(vehicleID):
    return _stat.getClanIcon(vehicleID)


#############################
# Private

import os
from pprint import pprint
import datetime
import traceback
import time
from random import randint
import threading
import uuid
import imghdr

import BigWorld
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider
from gui.app_loader import g_appLoader
from items.vehicles import VEHICLE_CLASS_TAGS

from xfw import *

import config
from consts import *
import filecache
from logger import *
import topclans
import utils
import vehinfo
import vehinfo_xtdb
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
        self._loadingClanIconsCount = 0

    def enqueue(self, req):
        with self.lock:
            self.queue.append(req)

    def dequeue(self):
        with self.lock:
            return self.queue.pop(0) if self.queue else None

    def getClanIcon(self, vehicleID):
        # Load order: id -> nick -> srv -> clan -> default clan -> default nick
        pl = self.players.get(vehicleID, None)
        if not pl:
            return None

        # Return cached path
        if hasattr(pl, 'clanicon'):
            return pl.clanicon

        def paths_gen():
            # Search icons
            prefix = 'res_mods/mods/shared_resources/xvm/res/{}'.format(
                utils.fixPath(config.get('battle/clanIconsFolder')))
            yield '{}ID/{}.png'.format(prefix, pl.accountDBID)
            yield '{}{}/nick/{}.png'.format(prefix, GAME_REGION, pl.name)
            if hasattr(pl, 'x_emblem'):
                yield pl.x_emblem
            if pl.clan:
                yield '{}{}/clan/{}.png'.format(prefix, GAME_REGION, pl.clan)
                yield '{}{}/clan/default.png'.format(prefix, GAME_REGION)
            yield '{}{}/nick/default.png'.format(prefix, GAME_REGION)

        for fn in paths_gen():
            if os.path.isfile(fn):
                pl.clanicon = utils.fixImgTag('xvm://' + fn[len('res_mods/mods/shared_resources/xvm/'):])
                return pl.clanicon
        pl.clanicon = None
        return pl.clanicon

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
                BigWorld.callback(0.1, self._checkResult)
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
        self.resp = unicode_to_ascii(self.resp)
        func = self.req.get('respondFunc', as_xfw_cmd)
        func(self.req['cmd'], self.resp)


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
        for (vehicleID, vData) in vehicles.iteritems():
            if vehicleID not in self.players:
                pl = _Player(vehicleID, vData)
                self._load_clanIcon(pl)
                # cleanup same player with different vehicleID (bug?)
                self.players = {k:v for k,v in self.players.iteritems() if v.accountDBID != pl.accountDBID}
                self.players[vehicleID] = pl
            self.players[vehicleID].update(vData)

        # sleepCounter = 0
        while self._loadingClanIconsCount > 0:
            time.sleep(0.01)

            # # FIX: temporary workaround
            # sleepCounter += 1
            # if sleepCounter > 1000: # 10 sec
            #    log('WARNING: icons loading too long')
            #    break;

        playerVehicleID = player.playerVehicleID if hasattr(player, 'playerVehicleID') else 0
        self._load_stat(playerVehicleID)

        players = {}
        for (vehicleID, pl) in self.players.iteritems():
            cacheKey = "%d=%d" % (pl.accountDBID, pl.vehCD)
            if cacheKey not in self.cacheBattle:
                cacheKey2 = "%d" % pl.accountDBID
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
            for (vehicleID, vData) in value['vehicles'].iteritems():
                accountDBID = vData[0]['accountDBID']
                plData = value['players'][accountDBID]
                vData = {
                    'accountDBID': accountDBID,
                    'name': plData['name'],
                    'clanAbbrev': plData['clanAbbrev'],
                    'typeCompDescr': vData[0]['typeCompDescr'],
                    'team': vData[0]['team']}
                self.players[vehicleID] = _Player(vehicleID, vData)

            self._load_stat(0)

            players = {}
            for (vehicleID, pl) in self.players.iteritems():
                cacheKey = "%d=%d" % (pl.accountDBID, pl.vehCD)
                if cacheKey not in self.cacheBattle:
                    cacheKey2 = "%d" % pl.accountDBID
                    if cacheKey2 not in self.cacheBattle:
                        self.cacheBattle[cacheKey] = self._get_battle_stub(pl)
                stat = self.cacheBattle[cacheKey]
                self._fix(stat)
                players[pl.name] = stat
            # pprint(players)

            with self.lock:
                self.resp = {'arenaUniqueId': str(value['arenaUniqueID']), 'players': players}

        except Exception:
            err(traceback.format_exc())
            print('=================================')
            print('_battleResultsCallback() exception: ' + traceback.format_exc())
            pprint(value)
            print('=================================')
            with self.lock:
                self.resp = {}

    def _get_user(self):
        (value,) = self.req['args']
        orig_value = value
        region = GAME_REGION
        if region == "CT":
            suf = value[-3:]
            if suf in ('_RU', '_EU', '_NA', '_US', '_SG'):
                region = value[-2:]
                value = value[:-3]
                if region == 'US':
                    region = 'NA'
            else:
                region = "RU"
        cacheKey = "%s/%s" % (region, value)
        data = None
        if cacheKey not in self.cacheUser:
            try:
                token = config.token.token
                if token is None:
                    err('No valid token for XVM network services (key=%s)' % cacheKey)
                else:
                    data = xvmapi.getStatsByNick(region, value)
                    if data is not None:
                        self._fix_user(data, orig_value)
                        if 'nm' in data and '_id' in data:
                            self.cacheUser[region + "/" + data['nm']] = data
                    else:
                        self.cacheUser[cacheKey] = {}
            except Exception:
                err(traceback.format_exc())

        with self.lock:
            self.resp = self.cacheUser.get(cacheKey, {})

    def _get_battle_stub(self, pl):
        s = {
            'vehicleID': pl.vehicleID,
            '_id': pl.accountDBID,
            'nm': pl.name,
            'v': {'id': pl.vehCD},
        }
        return self._fix(s)

    def _load_stat(self, playerVehicleID):
        requestList = []

        replay = isReplay()
        all_cached = True
        for (vehicleID, pl) in self.players.iteritems():
            cacheKey = "%d=%d" % (pl.accountDBID, pl.vehCD)

            if cacheKey not in self.cacheBattle:
                all_cached = False

            if pl.vehCD != 65281:
                requestList.append("%d=%d%s" % (
                    pl.accountDBID,
                    pl.vehCD,
                    '=1' if not replay and pl.vehicleID == playerVehicleID else ''))

        if all_cached or not requestList:
            return

        try:
            accountDBID = utils.getAccountDBID()
            if config.networkServicesSettings.statBattle:
                data = self._load_data_online(accountDBID, ','.join(requestList))
            else:
                data = self._load_data_offline(accountDBID)

            if data is None:
                return

            for stat in data['players']:
                self._fix(stat)
                #log(stat)
                if 'nm' not in stat or not stat['nm']:
                    continue
                if 'b' not in stat or stat['b'] <= 0:
                    continue
                cacheKey = "%d=%d" % (stat['_id'], stat.get('v', {}).get('id', 0))
                self.cacheBattle[cacheKey] = stat

        except Exception:
            err(traceback.format_exc())

    def _load_data_online(self, accountDBID, request):
        token = config.token.token
        if token is None:
            err('No valid token for XVM network services (id=%s)' % accountDBID)
            return None

        if isReplay():
            data = xvmapi.getStatsReplay(request)
        else:
            data = xvmapi.getStats(request)

        if data is None:
            err('Stat request data is None')
            return None

        if 'players' not in data:
            err('Malformed stat result: {}'.format(data))
            return None

        return data

    def _load_data_offline(self, accountDBID):
        players = []
        for (vehicleID, pl) in self.players.iteritems():
            players.append(self._get_battle_stub(pl))
        return {'players': players}

    def _fix(self, stat, orig_name=None):
        self._fix_common(stat)

        player = BigWorld.player()
        team = player.team if hasattr(player, 'team') else 0

        if self.players is not None:
            for (vehicleID, pl) in self.players.iteritems():
                if pl.accountDBID == stat['_id']:
                    stat['vehicleID'] = pl.vehicleID
                    if pl.clan:
                        stat['clan'] = pl.clan
                        cid = pl.clanInfo.get('cid', None) if pl.clanInfo else None
                        scid = stat.get('cid', None)
                        if (scid is None or scid == cid) and stat.get('rank') is not None and stat.get('emblem') is not None:
                            pl.clanInfo = {'cid': scid, 'rank': stat['rank'], 'emblem': stat['emblem']}
                            self._load_clanIcon(pl)
                        else:
                            stat['cid'] = cid
                            stat['rank'] = pl.clanInfo.get('rank', None) if pl.clanInfo else None
                            stat['emblem'] = pl.clanInfo.get('emblem', None) if pl.clanInfo else None
                    stat['name'] = pl.name
                    stat['team'] = TEAM.ALLY if team == pl.team else TEAM.ENEMY
                    stat['squadnum'] = pl.squadnum
                    if hasattr(pl, 'alive'):
                        stat['alive'] = pl.alive
                    if hasattr(pl, 'ready'):
                        stat['ready'] = pl.ready
                    if 'id' not in stat['v']:
                        stat['v']['id'] = pl.vehCD
                    break

        self._fix_common2(stat, orig_name, False)
        self._addContactData(stat)
        return stat

    def _fix_user(self, stat, orig_name=None):
        self._fix_common(stat)
        self._fix_common2(stat, orig_name, True)
        self._addContactData(stat)
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
                for vehicleID, vData in stat['v'].iteritems():
                    vData['id'] = int(vehicleID)
                    self._calculateVehicleValues(stat, vData)
                    self._calculateXTDB(vData)
                    self._calculateXTE(vData)
            else:
                vData = stat['v']
                if 'id' in vData:
                    self._calculateVehicleValues(stat, vData)
                    self._calculateXTDB(vData)
                    self._calculateXTE(vData)


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
        vehicleID = v['id']
        vData = vehinfo.getVehicleInfoData(vehicleID)
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

    # calculate xTDB
    def _calculateXTDB(self, v):
        if 'db' not in v or v['db'] < 0:
            return
        v['xtdb'] = vehinfo_xtdb.calculateXTDB(v['id'], float(v['db']))
        #log(v['xtdb'])

    # calculate xTE
    def _calculateXTE(self, v):
        if 'db' not in v or v['db'] < 0:
            return
        if 'fb' not in v or v['fb'] < 0:
            return
        v['xte'] = vehinfo_xte.calculateXTE(v['id'], float(v['db']), float(v['fb']))
        #log(str(v['id']) + " xte=" + str(v['xte']))

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
            if hasattr(pl, 'x_emblem'):
                BigWorld.callback(0,
                    lambda: as_xfw_cmd(XVM_COMMAND.AS_ON_CLAN_ICON_LOADED, pl.vehicleID, pl.name))
            elif hasattr(pl, 'x_emblem_loading'):
                return
            elif pl.clanInfo:
                rank = pl.clanInfo.get('rank', -1)
                url = pl.clanInfo.get('emblem', None)
                # url = 'http://stat.modxvm.com:81'
                if url and 0 <= rank <= config.networkServicesSettings.topClansCount:
                    url = url.replace('{size}', '32x32')
                    tID = 'icons/clan/{0}'.format(pl.clanInfo['cid'])
                    self._loadingClanIconsCount += 1
                    pl.x_emblem_loading = True
                    debug('clan={0} rank={1} url={2}'.format(pl.clan, rank, url))
                    filecache.get_url(url, (lambda url, bytes: self._load_clanIcons_callback(pl, tID, bytes)))
        except Exception:
            err(traceback.format_exc())

    def _load_clanIcons_callback(self, pl, tID, bytes):
        try:
            if bytes and imghdr.what(None, bytes) is not None:
                # imgid = str(uuid.uuid4())
                # BigWorld.wg_addTempScaleformTexture(imgid, bytes) # removed after first use?
                imgid = 'icons/{0}.png'.format(pl.clan)
                filecache.save(imgid, bytes)
                del pl.x_emblem_loading
                pl.x_emblem = 'res_mods/mods/shared_resources/xvm/cache/%s' % imgid
                if hasattr(pl, 'clanicon'):
                    del pl.clanicon
                as_xfw_cmd(XVM_COMMAND.AS_ON_CLAN_ICON_LOADED, pl.vehicleID, pl.name)
            #debug('{} {} {} {}'.format(
            #    pl.clan,
            #    tID,
            #    len(bytes) if bytes else '(none)',
            #    imghdr.what(None, bytes) if bytes else ''))
        except Exception:
            err(traceback.format_exc())
        finally:
            self._loadingClanIconsCount -= 1


class _Player(object):

    __slots__ = ('vehicleID', 'accountDBID', 'name', 'clan', 'clanInfo', 'team', 'squadnum',
                 'vehCD', 'vLevel', 'maxHealth', 'vIcon', 'vn', 'vType', 'alive', 'ready',
                 'x_emblem', 'x_emblem_loading', 'clanicon')

    sessionProvider = dependency.descriptor(IBattleSessionProvider)

    def __init__(self, vehicleID, vData):
        self.vehicleID = vehicleID
        self.accountDBID = vData['accountDBID']
        self.name = vData['name']
        self.clan = vData['clanAbbrev']
        self.clanInfo = topclans.getClanInfo(self.clan)
        self.vehCD = None
        if 'typeCompDescr' in vData:
            self.vehCD = vData['typeCompDescr']
        elif 'vehicleType' in vData:
            vtype = vData['vehicleType']
            if hasattr(vtype, 'type'):
                self.vehCD = vData['vehicleType'].type.compactDescr
        if self.vehCD is None:
            self.vehCD = 0
        self.team = vData['team']
        self.squadnum = 0
        arenaDP = self.sessionProvider.getArenaDP()
        if arenaDP is not None:
            vInfo = arenaDP.getVehicleInfo(vID=vehicleID)
            self.squadnum = vInfo.squadIndex
            # if self.squadnum > 0:
            #    log("team=%d, squad=%d %s" % (self.team, self.squadnum, self.name))

    def update(self, vData):
        vtype = vData['vehicleType']
        if hasattr(vtype, 'type'):
            self.vehCD = vtype.type.compactDescr
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
