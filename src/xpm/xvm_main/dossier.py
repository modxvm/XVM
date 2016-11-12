""" XFW Library (c) www.modxvm.com 2013-2016 """

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
from helpers.i18n import makeString
from items import vehicles
from dossiers2.ui.achievements import ACHIEVEMENT_BLOCK as _AB
from gui.shared import g_itemsCache
from gui.shared.gui_items import GUI_ITEM_TYPE
from gui.Scaleform.locale.MENU import MENU
from gui.Scaleform.genConsts.PROFILE_DROPDOWN_KEYS import PROFILE_DROPDOWN_KEYS
from gui.Scaleform.daapi.view.lobby.profile.QueuedVehicleDossierReceiver import QueuedVehicleDossierReceiver
from gui.LobbyContext import g_lobbyContext

from xfw import *

from consts import *
from logger import *
import vehinfo_xtdb
import vehinfo_xte


#############################

class _Dossier(object):

    def __init__(self, *args):
        self.__dataReceiver = QueuedVehicleDossierReceiver()
        self.__dataReceiver.onDataReceived += self.__requestedDataReceived

    def _dispose(self):
        self.__dataReceiver.onDataReceived -= self.__requestedDataReceived
        self.__dataReceiver.dispose()
        self.__dataReceiver = None

    def requestDossier(self, args):
        (self._battlesType, accountDBID, vehCD) = args
        if vehCD == 0 or self.__isVehicleDossierCached(accountDBID, vehCD):
            self.__requestedDataReceived(accountDBID, vehCD)
        else:
            self.__dataReceiver.invoke(accountDBID, vehCD)

    def __requestedDataReceived(self, accountDBID, vehCD):
        # respond
        res = self.getDossier((self._battlesType, accountDBID, vehCD))
        #log(res)
        as_xfw_cmd(XVM_COMMAND.AS_DOSSIER, accountDBID, vehCD, res)


    def getDossier(self, args):
        #log(str(args))

        (self._battlesType, self.accountDBID, self.vehCD) = args

        if self.accountDBID == 0:
            self.accountDBID = None

        if self.vehCD == 0:
            dossier = g_itemsCache.items.getAccountDossier(self.accountDBID)
            res = self.__prepareAccountResult(dossier)
        else:
            vehCD = int(self.vehCD)
            if not self.__isVehicleDossierCached(self.accountDBID, vehCD):
                return None
            dossier = g_itemsCache.items.getVehicleDossier(vehCD, self.accountDBID)
            xpVehs = g_itemsCache.items.stats.vehiclesXPs
            earnedXP = xpVehs.get(vehCD, 0)
            freeXP = g_itemsCache.items.stats.actualFreeXP
            #log('vehCD: {0} pVehXp: {1}'.format(vehCD, earnedXP))

            xpToElite = 0
            unlocks = g_itemsCache.items.stats.unlocks
            _, nID, invID = vehicles.parseIntCompactDescr(vehCD)
            vType = vehicles.g_cache.vehicle(nID, invID)
            for data in vType.unlocksDescrs:
                if data[1] not in unlocks:
                    xpToElite += data[0]

            # xTDB & xTE
            xtdb = -1
            xte = -1
            if dossier is not None:
                stats = self.__getStatsBlock(dossier)
                battles = stats.getBattlesCount()
                dmg = stats.getDamageDealt()
                frg = stats.getFragsCount()
                if battles > 0 and dmg >= 0 and frg >= 0:
                    xtdb = vehinfo_xtdb.calculateXTDB(vehCD, float(dmg) / battles)
                    xte = vehinfo_xte.calculateXTE(vehCD, float(dmg) / battles, float(frg) / battles)

            res = self.__prepareVehicleResult(dossier, xtdb, xte, earnedXP, freeXP, xpToElite)

        return res


    # PRIVATE

    # check vehicle dossier already loaded and cached
    def __isVehicleDossierCached(self, accountDBID, vehCD):
        if accountDBID is None or accountDBID == 0:
            return True

        container = g_itemsCache.items._ItemsRequester__itemsCache[GUI_ITEM_TYPE.VEHICLE_DOSSIER]
        dossier = container.get((accountDBID, vehCD))
        return dossier is not None

    def __getStatsBlock(self, dossier):
        if self._battlesType == PROFILE_DROPDOWN_KEYS.ALL:
            return dossier.getRandomStats()
        elif self._battlesType == PROFILE_DROPDOWN_KEYS.FALLOUT:
            return dossier.getFalloutStats()
        elif self._battlesType == PROFILE_DROPDOWN_KEYS.HISTORICAL:
            return dossier.getHistoricalStats()
        elif self._battlesType == PROFILE_DROPDOWN_KEYS.TEAM:
            return dossier.getTeam7x7Stats()
        elif self._battlesType == PROFILE_DROPDOWN_KEYS.STATICTEAM:
            return dossier.getRated7x7Stats()
        elif self._battlesType == PROFILE_DROPDOWN_KEYS.FORTIFICATIONS:
            return dossier.getFortSortiesStats()
        elif self._battlesType == PROFILE_DROPDOWN_KEYS.CLAN:
            return dossier.getGlobalMapStats()
        elif self._battlesType == PROFILE_DROPDOWN_KEYS.STATICTEAM_SEASON:
            currentSeasonID = g_lobbyContext.getServerSettings().eSportCurrentSeason.getID()
            return dossier.getSeasonRated7x7Stats(currentSeasonID)
        elif self._battlesType == PROFILE_DROPDOWN_KEYS.FORTIFICATIONS_BATTLES:
            return dossier.getFortBattlesStats()
        elif self._battlesType == PROFILE_DROPDOWN_KEYS.FORTIFICATIONS_SORTIES:
            return dossier.getFortSortiesStats()
        elif self._battlesType == PROFILE_DROPDOWN_KEYS.COMPANY:
            return dossier.getCompanyStats()
        raise ValueError('_Dossier: Unknown battle type: ' + self._battlesType)


    def __prepareCommonResult(self, dossier):
        stats = self.__getStatsBlock(dossier)
        glob = dossier.getGlobalStats()
        return {
            'accountDBID': 0 if self.accountDBID is None else int(self.accountDBID),

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
            'maxXPVehCD': stats.getMaxXpVehicle(),
            'maxFragsVehCD': stats.getMaxFragsVehicle(),
            'maxDamageVehCD': stats.getMaxDamageVehicle(),

            'creationTime': glob.getCreationTime(),
            'lastBattleTime': lbt,
            'lastBattleTimeStr': makeString(MENU.PROFILE_HEADER_LASTBATTLEDATETITLE) + ' ' +
                                 ('%s %s' % (BigWorld.wg_getLongDateFormat(lbt), BigWorld.wg_getShortTimeFormat(lbt))),
            'vehicles': {}
        })

        vehicles = stats.getVehicles()
        for (vehCD, vdata) in vehicles.iteritems():
            res['vehicles'][str(vehCD)] = {
                'battles': vdata.battlesCount,
                'wins': vdata.wins,
                'mastery': vdata.markOfMastery,
                'xp': vdata.xp,
            }

        return res

    def __prepareVehicleResult(self, dossier, xtdb, xte, earnedXP, freeXP, xpToElite):
        res = {}
        if dossier is None:
            return res

        res = self.__prepareCommonResult(dossier)

        res.update({
            'vehCD': int(self.vehCD),
            'xtdb': xtdb,
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
