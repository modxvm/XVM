""" xvm (c) sirmax 2013 """

#############################
# Command

def getDossier(proxy, args):
    _dossier.queue.put({
        'func':_dossier.getDossier,
        'proxy':proxy,
        'method':RESPOND_DOSSIER,
        'args':args})
    _dossier.processQueue()


#############################
# Private

from pprint import pprint
from threading import Thread, RLock
from Queue import Queue
import traceback

from gui.mods.xpm import *
from constants import *
from logger import *

#############################

class _Dossier(object):

    def __init__(self):
        player = BigWorld.player()
        self.queue = Queue()
        self.lock = RLock()
        self.thread = None
        self.req = None
        self.playerId = None
        self.vehId = None
        self.resp = None

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

        # not threaded
        self.req['func']()
        self._respond()
        self.processQueue()

        # threaded (DossierRequester is not thread-safe)
        #self.thread = Thread(target=self.req['func'])
        #self.thread.start()
        #self._checkResult()

    def _checkResult(self):
        with self.lock:
            #debug("checkResult: " + ("no" if self.resp is None else "yes"))
            #self.thread.join(0.01) # 10 ms
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
            self.req['proxy'].movie.invoke((self.req['method'], [self.playerId, self.vehId, strdata]))


    # Threaded

    def getDossier(self):
        (self.playerId, self.vehId) = self.req['args']

        from gui.shared import g_itemsCache
        if self.vehId is None:
            dossier = g_itemsCache.items.getAccountDossier(self.playerId)
            res = self.prepareAccountResult(dossier)
        else:
            dossier = g_itemsCache.items.getVehicleDossier(int(self.vehId), self.playerId)
            res = self.prepareVehicleResult(dossier)

        with self.lock:
            self.resp = res


    def prepareCommonResult(self, dossier):
        total = dossier.getTotalStats()
        glob = dossier.getGlobalStats()
        return {
            'playerId': 0 if self.playerId is None else int(self.playerId),

            'battles': total.getBattlesCount(),
            'wins': total.getWinsCount(),
            'xp': total.getXP(),
            'losses': total.getLosses(),
            'survived': total.getSurvivedBattlesCount(),
            'winAndSurvived': total.getWinAndSurvived(),
            'shots': total.getShotsCount(),
            'hits': total.getHitsCount(),
            'spotted': total.getSpottedEnemiesCount(),
            'frags': total.getFragsCount(),
            'damageDealt': total.getDamageDealt(),
            'damageReceived': total.getDamageReceived(),
            'capture': total.getCapturePoints(),
            'defence': total.getDroppedCapturePoints(),

            'frags8p': total.getFrags8p(),

            'xpBefore8_8': total.getXpBefore8_8(),
            'battlesBefore8_8': total.getBattlesCountBefore8_8(),

            'originalXP': total.getOriginalXP(),
            'damageAssistedTrack': total.getDamageAssistedTrack(),
            'damageAssistedRadio': total.getDamageAssistedRadio(),
            'shotsReceived': total.getShotsReceived(),
            'noDamageShotsReceived': total.getNoDamageShotsReceived(),
            'piercedReceived': total.getPiercedReceived(),
            'heHitsReceived': total.getHeHitsReceived(),
            'he_hits': total.getHeHits(),
            'pierced': total.getPierced(),

            'maxXP': total.getMaxXp(),
            'maxFrags': total.getMaxFrags(),
            'maxDamage': total.getMaxDamage(),

            'battleLifeTime': glob.getBattleLifeTime(),
            'mileage': glob.getMileage(),
            'treesCut': glob.getTreesCut(),
        }


    def prepareAccountResult(self, dossier):
        res = {}
        if dossier is None:
            return res

        res = self.prepareCommonResult(dossier)

        total = dossier.getTotalStats()
        glob = dossier.getGlobalStats()

        res.update({
            'maxXPVehId': total.getMaxXpVehicle(),
            'maxFragsVehId': total.getMaxFragsVehicle(),
            'maxDamageVehId': total.getMaxDamageVehicle(),

            'creationTime': glob.getCreationTime(),
            'lastBattleTime': glob.getLastBattleTime(),

            'vehicles': {}
        })

        vehicles = total.getVehicles()
        for (vehId, vdata) in vehicles.iteritems():
            res['vehicles'][str(vehId)] = {
                'battles': vdata.battlesCount,
                'wins': vdata.wins,
                'mastery': vdata.markOfMastery,
                'xp': vdata.xp,
            }

        return res


    def prepareVehicleResult(self, dossier):
        res = {}
        if dossier is None:
            return res

        res = self.prepareCommonResult(dossier)
        res['vehId'] = int(self.vehId)

        return res


_dossier = _Dossier()
