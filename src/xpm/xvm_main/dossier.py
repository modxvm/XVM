""" XVM (c) www.modxvm.com 2013-2015 """

#############################
# Command

def getDossier(proxy, args):
    _dossier.getDossier(proxy, args)


#############################
# Private

from pprint import pprint
import traceback
from adisp import process

import simplejson

from gui.shared.gui_items import GUI_ITEM_TYPE
from helpers.i18n import makeString
from gui.Scaleform.locale.MENU import MENU
from gui.Scaleform.locale.PROFILE import PROFILE
from items import vehicles
from dossiers2.ui.achievements import ACHIEVEMENT_BLOCK as _AB

from xfw import *

from constants import *
from logger import *

#############################

class _Dossier(object):

    # @process
    def getDossier(self, proxy, args):
        (self.battlesType, self.playerId, self.vehId) = args

        # log(str(args))

        from gui.shared import g_itemsCache
        if self.vehId is None:
            dossier = g_itemsCache.items.getAccountDossier(self.playerId)
            res = self._prepareAccountResult(dossier)
        else:
            vehId = int(self.vehId)
            dossier = g_itemsCache.items.getVehicleDossier(vehId, self.playerId)
            xpVehs = g_itemsCache.items.stats.vehiclesXPs
            earnedXP = xpVehs.get(vehId, 0)
            freeXP = g_itemsCache.items.stats.actualFreeXP
            # log('vehId: {0} pVehXp: {1}'.format(vehId, earnedXP))

            xpToElite = 0
            unlocks = g_itemsCache.items.stats.unlocks
            _, nID, invID = vehicles.parseIntCompactDescr(vehId)
            vType = vehicles.g_cache.vehicle(nID, invID)
            for data in vType.unlocksDescrs:
                if data[1] not in unlocks:
                    xpToElite += data[0]

            res = self._prepareVehicleResult(dossier, earnedXP, freeXP, xpToElite)

        # respond
        if proxy and proxy.component and proxy.movie:
            strdata = simplejson.dumps(res)
            proxy.movie.invoke((RESPOND_DOSSIER, [self.playerId, self.vehId, strdata]))

        # log(str(args) + " done")


    def _getStatsBlock(self, dossier):
        if self.battlesType == PROFILE.PROFILE_DROPDOWN_LABELS_ALL:
            return dossier.getRandomStats()
        elif self.battlesType == PROFILE.PROFILE_DROPDOWN_LABELS_TEAM:
            return dossier.getTeam7x7Stats()
        elif self.battlesType == PROFILE.PROFILE_DROPDOWN_LABELS_HISTORICAL:
            return dossier.getHistoricalStats()
        elif self.battlesType == PROFILE.PROFILE_DROPDOWN_LABELS_FORTIFICATIONS:
            return dossier._receiveFortDossier(accountDossier)
        elif self.battlesType == PROFILE.PROFILE_DROPDOWN_LABELS_FORTIFICATIONS_SORTIES:
            return dossier.getFortSortiesStats()
        elif self.battlesType == PROFILE.PROFILE_DROPDOWN_LABELS_FORTIFICATIONS_BATTLES:
            return dossier.getFortBattlesStats()
        elif self.battlesType == PROFILE.PROFILE_DROPDOWN_LABELS_COMPANY:
            return dossier.getCompanyStats()
        elif self.battlesType == PROFILE.PROFILE_DROPDOWN_LABELS_CLAN:
            return dossier.getClanStats()
        raise ValueError('_Dossier: Unknown battle type: ' + self.battlesType)


    def _prepareCommonResult(self, dossier):
        stats = self._getStatsBlock(dossier)
        glob = dossier.getGlobalStats()
        return {
            'playerId': 0 if self.playerId is None else int(self.playerId),

            'battles': stats.getBattlesCount(),
            'wins': stats.getWinsCount(),
            'losses': stats.getLossesCount(),
            'xp': stats.getXP(),
            'survived': stats.getSurvivedBattlesCount(),
            'shots': stats.getShotsCount(),
            'hits': stats.getHitsCount(),
            'spotted': stats.getSpottedEnemiesCount(),
            'frags': stats.getFragsCount(),
            'damageDealt': stats.getDamageDealt(),
            'damageReceived': stats.getDamageReceived(),
            'capture': stats.getCapturePoints(),
            'defence': stats.getDroppedCapturePoints(),

            'xpBefore8_8': stats.getXpBefore8_8(),
            'battlesBefore8_8': stats.getBattlesCountBefore8_8(),

            'originalXP': stats.getOriginalXP(),
            'damageAssistedTrack': stats.getDamageAssistedTrack(),
            'damageAssistedRadio': stats.getDamageAssistedRadio(),
            'shotsReceived': stats.getShotsReceived(),
            'noDamageShotsReceived': stats.getNoDamageShotsReceived(),
            'piercedReceived': stats.getPiercedReceived(),
            'heHitsReceived': stats.getHeHitsReceived(),
            'he_hits': stats.getHeHits(),
            'pierced': stats.getPierced(),

            'maxXP': stats.getMaxXp(),
            'maxFrags': stats.getMaxFrags(),
            'maxDamage': stats.getMaxDamage(),

            'battleLifeTime': glob.getBattleLifeTime(),
            'mileage': glob.getMileage(),
            'treesCut': glob.getTreesCut(),
        }


    def _prepareAccountResult(self, dossier):
        res = {}
        if dossier is None:
            return res

        res = self._prepareCommonResult(dossier)

        stats = self._getStatsBlock(dossier)
        glob = dossier.getGlobalStats()

        lbt = glob.getLastBattleTime()
        res.update({
            'maxXPVehId': stats.getMaxXpVehicle(),
            'maxFragsVehId': stats.getMaxFragsVehicle(),
            'maxDamageVehId': stats.getMaxDamageVehicle(),

            'creationTime': glob.getCreationTime(),
            'lastBattleTime': lbt,
            'lastBattleTimeStr': makeString(MENU.PROFILE_HEADER_LASTBATTLEDATETITLE) + ' ' +
                                 ('%s %s' % (BigWorld.wg_getLongDateFormat(lbt), BigWorld.wg_getShortTimeFormat(lbt))),
            'vehicles': {}
        })

        vehicles = stats.getVehicles()
        for (vehId, vdata) in vehicles.iteritems():
            res['vehicles'][str(vehId)] = {
                'battles': vdata.battlesCount,
                'wins': vdata.wins,
                'mastery': vdata.markOfMastery,
                'xp': vdata.xp,
            }

        return res

    def _prepareVehicleResult(self, dossier, earnedXP, freeXP, xpToElite):
        res = {}
        if dossier is None:
            return res

        res = self._prepareCommonResult(dossier)

        res.update({
            'vehId': int(self.vehId),
            'earnedXP': earnedXP,
            'freeXP': freeXP,
            'xpToElite': xpToElite,
            'marksOnGun': int(dossier.getRecordValue(_AB.TOTAL, 'marksOnGun')),
            'damageRating': dossier.getRecordValue(_AB.TOTAL, 'damageRating') / 100.0,
        })

        return res


_dossier = _Dossier()
