""" XFW Library (c) www.modxvm.com 2013-2015 """

#############################
# Command

def getDossier(args):
    return _dossier.getDossier(args)

def requestDossier(args):
    _dossier.requestDossier(args)

#############################
# Private

from pprint import pprint
import traceback
from adisp import process

import BigWorld

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
import vehinfo_xte

#############################

class _Dossier(object):

    def __init__(self, *args):
        from gui.Scaleform.daapi.view.lobby.profile.QueuedVehicleDossierReceiver import QueuedVehicleDossierReceiver
        self.__dataReceiver = QueuedVehicleDossierReceiver()
        self.__dataReceiver.onDataReceived += self.__requestedDataReceived

    def _dispose(self):
        self.__dataReceiver.onDataReceived -= self.__requestedDataReceived
        self.__dataReceiver.dispose()
        self.__dataReceiver = None

    def requestDossier(self, args):
        (self.battlesType, playerId, vehId) = args
        if vehId == 0 or self.__isVehicleDossierCached(playerId, vehId):
            self.__requestedDataReceived(playerId, vehId)
        else:
            self.__dataReceiver.invoke(playerId, vehId)

    def __requestedDataReceived(self, playerId, vehId):
        # respond
        res = self.getDossier((self.battlesType, playerId, vehId))
        #log(res)
        as_xfw_cmd(XVM_COMMAND.AS_DOSSIER, playerId, vehId, res)


    def getDossier(self, args):
        #log(str(args))

        (self.battlesType, self.playerId, self.vehId) = args

        if self.playerId == 0:
            self.playerId = None

        from gui.shared import g_itemsCache
        if self.vehId == 0:
            dossier = g_itemsCache.items.getAccountDossier(self.playerId)
            res = self.__prepareAccountResult(dossier)
        else:
            vehId = int(self.vehId)
            if not self.__isVehicleDossierCached(self.playerId, vehId):
                return None
            dossier = g_itemsCache.items.getVehicleDossier(vehId, self.playerId)
            xpVehs = g_itemsCache.items.stats.vehiclesXPs
            earnedXP = xpVehs.get(vehId, 0)
            freeXP = g_itemsCache.items.stats.actualFreeXP
            #log('vehId: {0} pVehXp: {1}'.format(vehId, earnedXP))

            xpToElite = 0
            unlocks = g_itemsCache.items.stats.unlocks
            _, nID, invID = vehicles.parseIntCompactDescr(vehId)
            vType = vehicles.g_cache.vehicle(nID, invID)
            for data in vType.unlocksDescrs:
                if data[1] not in unlocks:
                    xpToElite += data[0]

            # xTE
            if dossier is None:
                xte = None
            else:
                stats = self.__getStatsBlock(dossier)
                battles = stats.getBattlesCount()
                dmg = stats.getDamageDealt()
                frg = stats.getFragsCount()
                xte = 0
                if battles > 0 and dmg > 0 and frg > 0:
                    xte = vehinfo_xte.calculateXTE(vehId, float(dmg) / battles, float(frg) / battles)

            res = self.__prepareVehicleResult(dossier, xte, earnedXP, freeXP, xpToElite)

        return res


    # PRIVATE

    # check vehicle dossier already loaded and cached
    def __isVehicleDossierCached(self, playerId, vehId):
        from gui.shared import g_itemsCache
        from gui.shared.gui_items import GUI_ITEM_TYPE

        if playerId is None or playerId == 0:
            return True

        container = g_itemsCache.items._ItemsRequester__itemsCache[GUI_ITEM_TYPE.VEHICLE_DOSSIER]
        dossier = container.get((playerId, vehId))
        return dossier is not None

    def __getStatsBlock(self, dossier):
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


    def __prepareCommonResult(self, dossier):
        stats = self.__getStatsBlock(dossier)
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


    def __prepareAccountResult(self, dossier):
        res = {}
        if dossier is None:
            return res

        res = self.__prepareCommonResult(dossier)

        stats = self.__getStatsBlock(dossier)
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

    def __prepareVehicleResult(self, dossier, xte, earnedXP, freeXP, xpToElite):
        res = {}
        if dossier is None:
            return res

        res = self.__prepareCommonResult(dossier)

        res.update({
            'vehId': int(self.vehId),
            'xte': xte,
            'earnedXP': earnedXP,
            'freeXP': freeXP,
            'xpToElite': xpToElite,
            'marksOnGun': int(dossier.getRecordValue(_AB.TOTAL, 'marksOnGun')),
            'damageRating': dossier.getRecordValue(_AB.TOTAL, 'damageRating') / 100.0,
        })

        return res

_dossier = None

def _init():
    global _dossier
    _dossier = _Dossier()

BigWorld.callback(0, _init)
