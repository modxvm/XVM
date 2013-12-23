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

    def getDossier(self):
        playerId = self.req['args'][0]

        from gui.shared import g_itemsCache
        dossier = g_itemsCache.items.getAccountDossier(playerId)
        res = self.prepareResult(dossier, playerId)

        with self.lock:
            self.resp = res


    def prepareResult(self, dossier, playerId):
        res = {}
        if dossier is None:
            return res

        stats = dossier.getTotalStats()
        res = {
            'playerId': playerId or 0,
            'battles': stats.getRecord('battlesCount'),
            'wins': stats.getRecord('wins'),
            'losses': stats.getRecord('losses'),
            'survived': stats.getRecord('survivedBattles'),
            'frags': stats.getRecord('frags'),
            'shots': stats.getRecord('shots'),
            'hits': stats.getRecord('hits'),
            'spotted': stats.getRecord('spotted'),
            'damageDealt': stats.getRecord('damageDealt'),
            'damageReceived': stats.getRecord('damageReceived'),
            'capture': stats.getRecord('capturePoints'),
            'defence': stats.getRecord('droppedCapturePoints'),
            'winAndSurvived': stats.getRecord('winAndSurvived'),
            'vehicles': {}
        }

        vehicles = stats.getVehicles()
        for (vehId, vdata) in vehicles.iteritems():
            res['vehicles'][str(vehId)] = {
                'battles': vdata.battlesCount,
                'wins': vdata.wins,
                'mastery': vdata.markOfMastery,
                'xp': vdata.xp,
            }

        return res

_dossier = _Dossier()
