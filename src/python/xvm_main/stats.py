"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2024 XVM Contributors
"""

#############################
# Command

def getBattleStat(args, respondFunc):
    _stat.enqueue({
        'func': _stat.getBattleStat,
        'cmd': XVM_COMMAND.AS_STAT_BATTLE_DATA,
        'respondFunc': respondFunc,
        'args': args})
    _stat.processQueue()

def getBattleResultsStat(args, respondFunc):
    _stat.enqueue({
        'func': _stat.getBattleResultsStat,
        'cmd': XVM_COMMAND.AS_STAT_BATTLE_RESULTS_DATA,
        'respondFunc': respondFunc,
        'args': args})
    _stat.processQueue()

def getUserData(args, respondFunc):
    _stat.enqueue({
        'func': _stat.getUserData,
        'cmd': XVM_COMMAND.AS_STAT_USER_DATA,
        'respondFunc': respondFunc,
        'args': args})
    _stat.processQueue()

def getClanIcon(vehicleID):
    return _stat.getClanIcon(vehicleID)


#############################
# Private

import os
import pprint
import traceback
import time
import threading
import uuid
import imghdr

import BigWorld
import AccountCommands
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider
from gui.battle_control import avatar_getter
from items.vehicles import VEHICLE_CLASS_TAGS

from xfw import *
import xfw.utils as xfwutils
from xfw_actionscript.python import *

import config
from consts import *
import filecache
from logger import *
import topclans
import utils
import vehinfo
import xvm_scale
import xvmapi

#############################

class _Stat(object):

    def __init__(self):
        self.queue = []  # HINT: Since WoT 0.9.0 use Queue() leads to Access Violation after client closing
        self.lock = threading.RLock()
        self.thread = None
        self.req = None
        self.resp = None
        self.arenaId = None
        self.players = {}
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
            prefix = '{}/res/{}'.format(
                XVM.SHARED_RESOURCES_DIR,
                xfwutils.fix_path_slashes(config.get('battle/clanIconsFolder')))
            if prefix[-1] != '/':
                prefix += '/'
            yield '{}ID/{}.png'.format(prefix, pl.accountDBID)
            yield '{}{}/nick/{}.png'.format(prefix, getRegion(), pl.name)
            if hasattr(pl, 'x_emblem'):
                yield pl.x_emblem
            if pl.clan:
                yield '{}{}/clan/{}.png'.format(prefix, getRegion(), pl.clan)
                yield '{}{}/clan/default.png'.format(prefix, getRegion())
            yield '{}{}/nick/default.png'.format(prefix, getRegion())

        for fn in paths_gen():
            if os.path.isfile(fn):
                pl.clanicon = utils.fixImgTag('xvm://' + fn[len(XVM.SHARED_RESOURCES_DIR + '/'):])
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
        #debug('start')
        BigWorld.callback(0, self._checkResult)

    def _checkResult(self):
        with self.lock:
            debug('checkResult: {} => {}'.format(self.req['cmd'], 'no' if self.resp is None else 'yes'))
            if self.thread is not None:
                self.thread.join(0.01)  # 10 ms
            if self.resp is None:
                BigWorld.callback(0.1, self._checkResult)
                return
        try:
            with self.lock:
                self._respond()
        except Exception:
            err(traceback.format_exc())
        finally:
            #debug('done')
            with self.lock:
                if not self.resp:
                    self.resp = {}
            if self.thread:
                #debug('join')
                self.thread.join()
                #debug('thread deleted')
                with self.lock:
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
            arena = avatar_getter.getArena()
            if arena is None:
                debug('WARNING: arena not created, but getBattleStat() called')
                ## Long initialization with high ping
                #if tries < 5:
                #    time.sleep(1)
                #self.getBattleStat(tries+1)
            else:
                self._get_battle()
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
        except Exception:
            err(traceback.format_exc())
        with self.lock:
            if not self.resp:
                self.resp = {}

    def getUserData(self):
        try:
            self._get_user()
        except Exception:
            err(traceback.format_exc())
        with self.lock:
            if not self.resp:
                self.resp = {}

    def _get_battle(self):
        arenaUniqueID = avatar_getter.getArenaUniqueID()
        if arenaUniqueID is None or arenaUniqueID != self.arenaId:
            self.arenaId = arenaUniqueID
            self.players = {}

        # update players
        self._loadingClanIconsCount = 0
        vehicles = avatar_getter.getArena().vehicles
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

        self._load_stat(False)

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
        # pprint.pprint(players)

        with self.lock:
            self.resp = {'players': players}

    def _get_battleresults(self):
        (arenaUniqueID,) = self.req['args']
        try:
            #log('BigWorld.player().battleResultsCache.get(): start')
            while True:
                BigWorld.player().battleResultsCache.get(int(arenaUniqueID), self._battleResultsCallback)
                if self.resp is not None:
                    return
                time.sleep(0.5) # 500 ms
        except Exception:
            err(traceback.format_exc())
        finally:
            pass
            #log('BigWorld.player().battleResultsCache.get(): end')

    def _battleResultsCallback(self, responseCode, value=None, revision=0):
        try:
            #log('_Stat._battleResultsCallback({})'.format(responseCode))
            if responseCode == AccountCommands.RES_COOLDOWN:
                BigWorld.callback(0.3, self._get_battleresults)
                return
            elif responseCode not in [AccountCommands.RES_STREAM, AccountCommands.RES_CACHE]:
                with self.lock:
                    self.resp = {}
                return

            #log(value)

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


            battleinfo = {
                'arena_unique_id': value['arenaUniqueID'],
                'duration': value['common']['duration'],
                'finishReason': value['common']['finishReason'],
                'winnerTeam': value['common']['winnerTeam']}

            self._load_stat(True, battleinfo)

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
            # pprint.pprint(players)

            with self.lock:
                self.resp = {'arenaUniqueID': str(value['arenaUniqueID']), 'players': players}

        except Exception:
            err(traceback.format_exc())
            print('=================================')
            print('_battleResultsCallback() exception: ' + traceback.format_exc())
            pprint.pprint(value)
            print('=================================')
            with self.lock:
                self.resp = {}

    def _get_user(self):
        (value,) = self.req['args']
        orig_value = value
        region = getRegion()
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
                        if 'name_db' in data and 'player_id' in data:
                            self.cacheUser[region + "/" + data['name_db']] = data
                    else:
                        self.cacheUser[cacheKey] = {}
            except Exception:
                err(traceback.format_exc())

        with self.lock:
            self.resp = self.cacheUser.get(cacheKey, {})

    def _get_battle_stub(self, pl):
        s = {
            'vehicleID': pl.vehicleID,
            'player_id': pl.accountDBID,
            'name_db': pl.name,
            'v': {'id': pl.vehCD},
        }
        return self._fix(s)

    def _load_stat(self, isBattleResults, battleinfo=None):
        requestList = []

        replay = isReplay()
        all_cached = True
        for (vehicleID, pl) in self.players.iteritems():
            cacheKey = "%d=%d" % (pl.accountDBID, pl.vehCD)

            if cacheKey not in self.cacheBattle:
                all_cached = False

            requestList.append("{}={}={}".format(pl.accountDBID, pl.vehCD, pl.team))

        if all_cached or not requestList:
            return

        try:
            accountDBID = utils.getAccountDBID()
            if config.networkServicesSettings.statBattle:
                data = self._load_data_online(accountDBID, ','.join(requestList), isBattleResults, battleinfo)
            else:
                data = self._load_data_offline(accountDBID)

            if data is None:
                return

            for stat in data['players']:
                self._fix(stat)
                #log(stat)
                if 'name_db' not in stat or not stat['name_db']:
                    continue
                if 'battles' not in stat or stat['battles'] <= 0:
                    continue
                cacheKey = "%d=%d" % (stat['player_id'], stat.get('v', {}).get('id', 0))
                self.cacheBattle[cacheKey] = stat

        except Exception:
            err(traceback.format_exc())

    def _load_data_online(self, accountDBID, request, isBattleResults, battleinfo):
        token = config.token.token
        if token is None:
            err('No valid token for XVM network services (id=%s)' % accountDBID)
            return None

        if isReplay():
            data = xvmapi.getStatsReplay(request)
        elif isBattleResults:
            data = xvmapi.getStatsBattleResults(request, battleinfo)
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

        team = avatar_getter.getPlayerTeam()

        if self.players is not None:
            for (vehicleID, pl) in self.players.iteritems():
                if pl.accountDBID == stat['player_id']:
                    stat['vehicleID'] = pl.vehicleID
                    if pl.clan:
                        stat['clan'] = pl.clan
                        clan_id = pl.clanInfo.get('clan_id', None) if pl.clanInfo else None
                        stat_clan_id = stat.get('clan_id', None)
                        if (stat_clan_id is None or stat_clan_id == clan_id) and stat.get('rank') is not None and stat.get('emblem') is not None:
                            pl.clanInfo = {'clan_id': stat_clan_id, 'rank': stat['rank'], 'emblem': stat['emblem']}
                            self._load_clanIcon(pl)
                        else:
                            stat['clan_id'] = clan_id
                            stat['rank'] = pl.clanInfo.get('rank', None) if pl.clanInfo else None
                            stat['emblem'] = pl.clanInfo.get('emblem', None) if pl.clanInfo else None
                    stat['name'] = pl.name
                    stat['team'] = TEAM.ALLY if team == pl.team else TEAM.ENEMY
                    stat['badgeId'] = pl.badgeId
                    stat['badgeStage'] = pl.badgeStage
                    if hasattr(pl, 'alive'):
                        stat['alive'] = pl.alive
                    if hasattr(pl, 'ready'):
                        stat['ready'] = pl.ready
                    if 'id' not in stat['v']:
                        stat['v']['id'] = pl.vehCD
                    break

        self._fix_common2(stat, orig_name)
        self._addContactData(stat)
        return stat

    def _fix_user(self, stat, orig_name=None):
        self._fix_common(stat)
        stat['vehicles'] = stat['v']
        del stat['v']
        self._fix_common2(stat, orig_name)
        self._addContactData(stat)
        return stat

    def _fix_common(self, stat):
        # TODO: remove after fix in XVM API
        if '_id' in stat:
            stat['player_id'] = stat['_id']
            del stat['_id']
        if 'nm' in stat:
            stat['name_db'] = stat['nm']
            del stat['nm']
        if 'cid' in stat:
            stat['clan_id'] = stat['cid']
            del stat['cid']
        if 'b' in stat:
            stat['battles'] = stat['b']
            del stat['b']
        if 'w' in stat:
            stat['wins'] = stat['w']
            del stat['w']
        if 'e' in stat:
            stat['eff'] = stat['e']
            del stat['e']
        if 'lvl' in stat:
            stat['avglvl'] = stat['lvl']
            del stat['lvl']
        if 'ver' in stat:
            del stat['ver']
        if 'st' in stat:
            del stat['st']
        if 'dt' in stat:
            del stat['dt']
        if 'cr' in stat:
            del stat['cr']
        if 'up' in stat:
            del stat['up']
        if 'rnd' in stat:
            del stat['rnd']
        if 'lang' in stat:
            del stat['lang']
        ###
        if 'v' not in stat:
            stat['v'] = {}
        if stat.get('eff', 0) <= 0:
            stat['eff'] = None
        if stat.get('wn8', 0) <= 0:
            stat['wn8'] = None
        if stat.get('wgr', 0) <= 0:
            stat['wgr'] = None
        if stat.get('wtr', 0) <= 0:
            stat['wtr'] = None

    def _fix_common2(self, stat, orig_name):
        if orig_name is not None:
            stat['name'] = orig_name
        if 'battles' in stat and 'wins' in stat and stat['battles'] > 0:
            self._calculateGWR(stat)
            self._calculateXvmScale(stat)
            if 'v' in stat:
                vData = stat['v']
                if 'id' in vData:
                    self._calculateVehicleValues(stat, vData)
                    self._calculateXTDB(vData)
                    self._calculateXTE(vData)
                    self._calculateVXWTR(vData)
            if 'vehicles' in stat:
                for vehicleID, vData in stat['vehicles'].iteritems():
                    vData['id'] = int(vehicleID)
                    self._calculateVehicleValues(stat, vData)
                    self._calculateXTDB(vData)
                    self._calculateXTE(vData)
                    self._calculateVXWTR(vData)

    # Global Win Rate (GWR)
    def _calculateGWR(self, stat):
        stat['winrate'] = float(stat['wins']) / float(stat['battles']) * 100.0

    # XVM Scale
    def _calculateXvmScale(self, stat):
        if 'wtr' in stat and stat['wtr'] > 0:
            stat['xwtr'] = vehinfo.calculateXvmScale('wtr', stat['wtr'])
        if 'wn8' in stat and stat['wn8'] > 0:
            stat['xwn8'] = vehinfo.calculateXvmScale('wn8',stat['wn8'])
        if 'eff' in stat and stat['eff'] > 0:
            stat['xeff'] = vehinfo.calculateXvmScale('eff', stat['eff'])
        if 'wgr' in stat and stat['wgr'] > 0:
            stat['xwgr'] = vehinfo.calculateXvmScale('wgr', stat['wgr'])
        if 'winrate' in stat and stat['winrate'] > 0:
            stat['xwr'] = vehinfo.calculateXvmScale('win', stat['winrate'])

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
        v['xtdb'] = vehinfo.calculateXTDB(v['id'], float(v['db']))
        #log(v['xtdb'])

    # calculate xTE
    def _calculateXTE(self, v):
        if 'db' not in v or v['db'] < 0:
            return
        if 'fb' not in v or v['fb'] < 0:
            return
        v['xte'] = vehinfo.calculateXTE(v['id'], float(v['db']), float(v['fb']))
        #log(str(v['id']) + " xte=" + str(v['xte']))

    # calculate per-vehicle xWTR
    def _calculateVXWTR(self, v):
        if 'wtr' in v and v['wtr'] > 0:
            v['xwtr'] = vehinfo.calculateXvmScale('wtr', v['wtr'])

    def _addContactData(self, stat):
        # try to add changed nick and comment
        try:
            import xvm_contacts.python.contacts as contacts
            stat['xvm_contact_data'] = contacts.getXvmContactData(stat['player_id'])
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
                if url and rank >= 0:
                    url = url.replace('{size}', '32x32')
                    tID = 'icons/clan/{0}'.format(pl.clanInfo['clan_id'])
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
                pl.x_emblem = '{}/cache/{}'.format(XVM.SHARED_RESOURCES_DIR, imgid)
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

    __slots__ = ('vehicleID', 'accountDBID', 'name', 'clan', 'clanInfo',
                 'badgeId', 'badgeStage', 'team', 'vehCD', 'vLevel',
                 'maxHealth', 'vIcon', 'vn', 'vType', 'alive',
                 'ready', 'x_emblem', 'x_emblem_loading', 'clanicon')

    sessionProvider = dependency.descriptor(IBattleSessionProvider)

    def __init__(self, vehicleID, vData):
        self.vehicleID = vehicleID
        self.accountDBID = vData['accountDBID']
        self.name = vData['name']
        self.clan = vData['clanAbbrev']

        self.badgeId = None
        self.badgeStage = None
        badges = vData.get('badges', None)
        if badges:
            try:
                self.badgeId = str(badges[0])
                self.badgeStage = str(badges[1][0])
            except IndexError:
                self.badgeId = None
                self.badgeStage = None

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
