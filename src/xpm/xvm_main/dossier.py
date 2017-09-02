""" XFW Library (c) www.modxvm.com 2013-2017 """

#############################
# Command

def getDossier(battlesType, accountDBID, vehCD):
    return _dossier.getDossier(battlesType, accountDBID, vehCD)

def getAccountDossierValue(name):
    return _dossier.getAccountDossierValue(name)

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
from gui.ranked_battles.ranked_models import Rank, VehicleRank
from gui.shared.gui_items import GUI_ITEM_TYPE
from gui.Scaleform.locale.MENU import MENU
from gui.Scaleform.genConsts.PROFILE_DROPDOWN_KEYS import PROFILE_DROPDOWN_KEYS
from gui.Scaleform.daapi.view.lobby.profile.QueuedVehicleDossierReceiver import QueuedVehicleDossierReceiver
from helpers import dependency
from skeletons.gui.shared import IItemsCache
from skeletons.gui.game_control import IRankedBattlesController
from skeletons.gui.lobby_context import ILobbyContext

from xfw import *

from consts import *
from logger import *
import vehinfo


#############################

class _Dossier(object):

    itemsCache = dependency.descriptor(IItemsCache)
    lobbyContext = dependency.descriptor(ILobbyContext)
    rankedController = dependency.descriptor(IRankedBattlesController)

    def __init__(self, *args):
        self.__dataReceiver = QueuedVehicleDossierReceiver()
        self.__dataReceiver.onDataReceived += self.__requestedDataReceived
        self._cache = {}

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
        res = self.getDossier(self._battlesType, accountDBID, vehCD)
        #log(res)
        as_xfw_cmd(XVM_COMMAND.AS_DOSSIER, accountDBID, vehCD, res)

    def getAccountDossierValue(self, name):
        return self.getDossier(PROFILE_DROPDOWN_KEYS.ALL).get(name, None)

    def getDossier(self, battlesType, accountDBID=None, vehCD=0):
        self._battlesType = battlesType

        if accountDBID == 0:
            accountDBID = None
        if accountDBID is not None:
            accountDBID = int(accountDBID)

        if vehCD is None:
            vehCD = 0
        else:
            vehCD = int(vehCD)

        cache_key = "{}:{}:{}".format(battlesType, 0 if accountDBID is None else accountDBID, vehCD)

        if vehCD == 0:
            # account dossier
            dossier = self.itemsCache.items.getAccountDossier(accountDBID)
            cache_item = self._cache.get(cache_key, None)
            if cache_item is not None and cache_item['battles'] == dossier.getRandomStats().getBattlesCount():
                return cache_item
            res = self.__prepareAccountResult(accountDBID, dossier)
            self._cache[cache_key] = res
            return res

        # vehicle dossier
        if not self.__isVehicleDossierCached(accountDBID, vehCD):
            return None

        dossier = self.itemsCache.items.getVehicleDossier(vehCD, accountDBID)
        cache_item = self._cache.get(cache_key, None)
        if cache_item is not None and cache_item['battles'] == dossier.getRandomStats().getBattlesCount():
            return cache_item

        rankCount = None
        rankSteps = None
        rankStepsTotal = None
        if self.rankedController.isAvailable():
            vdata = vehinfo.getVehicleInfoData(vehCD)
            if vdata['level'] == 10:
                #log(vdata['key'])
                #log(dossier.getRankedCurrentSeason())

                vehicle = self.itemsCache.items.getItemByCD(vehCD)
                ranks = self.rankedController.getAllRanksChain(vehicle)

                currentRank = self.rankedController.getCurrentRank(vehicle)
                if isinstance(currentRank, VehicleRank):
                    rankCount = currentRank.getSerialID()

                currentRankID = currentRank.getID()
                nextRank = ranks[currentRankID + 1] if currentRankID < len(ranks) - 1 else currentRank
                if isinstance(nextRank, VehicleRank):
                    progress = nextRank.getProgress()
                    if progress is not None:
                        rankSteps = len(nextRank.getProgress().getAcquiredSteps())
                        rankStepsTotal = len(nextRank.getProgress().getSteps())

        xpVehs = self.itemsCache.items.stats.vehiclesXPs
        earnedXP = xpVehs.get(vehCD, 0)
        freeXP = self.itemsCache.items.stats.actualFreeXP
        #log('vehCD: {0} pVehXp: {1}'.format(vehCD, earnedXP))

        xpToElite = 0
        unlocks = self.itemsCache.items.stats.unlocks
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
                curdmg = float(dmg) / battles
                curfrg = float(frg) / battles
                xtdb = vehinfo.calculateXTDB(vehCD, curdmg)
                xte = vehinfo.calculateXTE(vehCD, curdmg, curfrg)

        res = self.__prepareVehicleResult(accountDBID, vehCD, dossier, xtdb, xte, earnedXP, freeXP,
                                          xpToElite, rankCount, rankSteps, rankStepsTotal)
        self._cache[cache_key] = res
        return res

    # PRIVATE

    # check vehicle dossier already loaded and cached
    def __isVehicleDossierCached(self, accountDBID, vehCD):
        if accountDBID is None or accountDBID == 0:
            return True

        container = self.itemsCache.items._ItemsRequester__itemsCache[GUI_ITEM_TYPE.VEHICLE_DOSSIER]
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
            currentSeasonID = self.lobbyContext.getServerSettings().eSportCurrentSeason.getID()
            return dossier.getSeasonRated7x7Stats(currentSeasonID)
        elif self._battlesType == PROFILE_DROPDOWN_KEYS.FORTIFICATIONS_BATTLES:
            return dossier.getFortBattlesStats()
        elif self._battlesType == PROFILE_DROPDOWN_KEYS.FORTIFICATIONS_SORTIES:
            return dossier.getFortSortiesStats()
        elif self._battlesType == PROFILE_DROPDOWN_KEYS.COMPANY:
            return dossier.getCompanyStats()
        elif self._battlesType == PROFILE_DROPDOWN_KEYS.RANKED:
            return dossier.getRankedStats()
        raise ValueError('_Dossier: Unknown battle type: ' + self._battlesType)


    def __prepareCommonResult(self, accountDBID, dossier):
        stats = self.__getStatsBlock(dossier)
        glob = dossier.getGlobalStats()
        return {
            'accountDBID': 0 if accountDBID is None else accountDBID,

            'battles': stats.getBattlesCount(),
            'wins': stats.getWinsCount(),
            'winrate': float(stats.getWinsCount()) / float(stats.getBattlesCount()) * 100.0 if stats.getBattlesCount() > 0 else None,
            'losses': stats.getLossesCount(),
            'xp': stats.getXP(),
            'survived': stats.getSurvivedBattlesCount(),
            'shots': stats.getShotsCount(),
            'hits': stats.getHitsCount(),
            'hitPercent': float(stats.getHitsCount()) / float(stats.getShotsCount()) * 100.0 if stats.getShotsCount() > 0 else None,
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
            'treesCut': glob.getTreesCut()}


    def __prepareAccountResult(self, accountDBID, dossier):
        res = {}
        if dossier is None:
            return res

        res = self.__prepareCommonResult(accountDBID, dossier)

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
            'vehicles': {}})

        vehicles = stats.getVehicles()
        for (vehCD, vdata) in vehicles.iteritems():
            res['vehicles'][str(vehCD)] = {
                'battles': vdata.battlesCount,
                'wins': vdata.wins,
                'mastery': stats.getMarkOfMasteryForVehicle(vehCD),
                'xp': vdata.xp}

        return res

    def __prepareVehicleResult(self, accountDBID, vehCD, dossier, xtdb, xte, earnedXP, freeXP, xpToElite, rankCount, rankSteps, rankStepsTotal):
        res = {}
        if dossier is None:
            return res

        res = self.__prepareCommonResult(accountDBID, dossier)

        res.update({
            'vehCD': vehCD,
            'xtdb': xtdb,
            'xte': xte,
            'earnedXP': earnedXP,
            'freeXP': freeXP,
            'xpToElite': xpToElite,
            'rankCount': rankCount,
            'rankSteps': rankSteps,
            'rankStepsTotal': rankStepsTotal,
            'marksOnGun': int(dossier.getRecordValue(_AB.TOTAL, 'marksOnGun')),
            'damageRating': dossier.getRecordValue(_AB.TOTAL, 'damageRating') / 100.0})

        return res


_dossier = None

def _init():
    global _dossier
    _dossier = _Dossier()

BigWorld.callback(0, _init)
