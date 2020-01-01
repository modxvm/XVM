""" XFW Library (c) https://modxvm.com 2013-2020 """

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
from gui.impl import backport
from gui.shared.gui_items import GUI_ITEM_TYPE
from gui.shared.utils.requesters import REQ_CRITERIA
from gui.Scaleform.locale.MENU import MENU
from gui.Scaleform.genConsts.PROFILE_DROPDOWN_KEYS import PROFILE_DROPDOWN_KEYS
from gui.Scaleform.daapi.view.lobby.profile.QueuedVehicleDossierReceiver import QueuedVehicleDossierReceiver
from items.components.c11n_constants import SeasonType
from helpers import dependency
from skeletons.gui.shared import IItemsCache
from skeletons.gui.game_control import IRankedBattlesController
from skeletons.gui.lobby_context import ILobbyContext

from xfw import *
from xfw_actionscript.python import *

from consts import *
from logger import *
import vehinfo


#############################

class _DummyStats(object):
    def getBattlesCount(self): return 0
    def getWinsCount(self): return 0
    def getLossesCount(self): return 0
    def getXP(self): return 0
    def getSurvivedBattlesCount(self): return 0
    def getShotsCount(self): return 0
    def getHitsCount(self): return 0
    def getShotsCount(self): return 0
    def getSpottedEnemiesCount(self): return 0
    def getFragsCount(self): return 0
    def getDamageDealt(self): return 0
    def getDamageReceived(self): return 0
    def getCapturePoints(self): return 0
    def getDroppedCapturePoints(self): return 0
    def getOriginalXP(self): return 0
    def getDamageAssistedTrack(self): return 0
    def getDamageAssistedRadio(self): return 0
    def getShotsReceived(self): return 0
    def getNoDamageShotsReceived(self): return 0
    def getPiercedReceived(self): return 0
    def getHeHitsReceived(self): return 0
    def getHeHits(self): return 0
    def getPierced(self): return 0
    def getMaxXp(self): return 0
    def getMaxFrags(self): return 0
    def getMaxDamage(self): return 0
    def getBattleLifeTime(self): return 0
    def getMileage(self): return 0
    def getTreesCut(self): return 0

class _DummyDossier(object):
    _dummyStats = _DummyStats()
    def getRecordValue(*a, **k): return 0
    def getGlobalStats(self): return self._dummyStats
    def getTotalStats(self): return self._dummyStats
    def getRandomStats(self): return self._dummyStats
    def getFalloutStats(self): return self._dummyStats
    def getHistoricalStats(self): return self._dummyStats
    def getTeam7x7Stats(self): return self._dummyStats
    def getRated7x7Stats(self): return self._dummyStats
    def getFortSortiesStats(self): return self._dummyStats
    def getGlobalMapStats(self): return self._dummyStats
    def getSeasonRated7x7Stats(*a, **k): return self._dummyStats
    def getFortBattlesStats(self): return self._dummyStats
    def getFortSortiesStats(self): return self._dummyStats
    def getCompanyStats(self): return self._dummyStats
    def getRankedStats(self): return self._dummyStats

class _Dossier(object):

    itemsCache = dependency.descriptor(IItemsCache)
    lobbyContext = dependency.descriptor(ILobbyContext)

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
        if vehCD == 0 or self.__isVehicleDossierLoaded(accountDBID, vehCD):
            self.__requestedDataReceived(accountDBID, vehCD)
        else:
            self.__dataReceiver.invoke(accountDBID, vehCD)

    def __requestedDataReceived(self, accountDBID, vehCD):
        # respond
        res = self.getDossier(self._battlesType, accountDBID, vehCD)
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
            if cache_item is not None and cache_item['totalBattles'] == dossier.getTotalStats().getBattlesCount():
                return cache_item
            res = self.__prepareAccountResult(accountDBID, dossier)
            self._cache[cache_key] = res
            return res

        # vehicle dossier
        vehicle = self.itemsCache.items.getItemByCD(vehCD)

        rent = vehicle.isRented
        multiNation = vehicle.hasNationGroup
        outfit = vehicle.getOutfit(SeasonType.SUMMER)
        summer_camo = outfit is not None and bool(outfit.hull.slotFor(GUI_ITEM_TYPE.CAMOUFLAGE).getItem())
        outfit = vehicle.getOutfit(SeasonType.WINTER)
        winter_camo = outfit is not None and bool(outfit.hull.slotFor(GUI_ITEM_TYPE.CAMOUFLAGE).getItem())
        outfit = vehicle.getOutfit(SeasonType.DESERT)
        desert_camo = outfit is not None and bool(outfit.hull.slotFor(GUI_ITEM_TYPE.CAMOUFLAGE).getItem())

        if self.__isVehicleDossierLoaded(accountDBID, vehCD):
            dossier = self.itemsCache.items.getVehicleDossier(vehCD, accountDBID)
            totalBattles = dossier.getTotalStats().getBattlesCount()
            randomBattles = dossier.getRandomStats().getBattlesCount()
        else:
            dossier = _DummyDossier()
            totalBattles = 0
            randomBattles = 0

        cache_item = self._cache.get(cache_key, None)
        if cache_item is not None and cache_item['totalBattles'] == totalBattles:
            self.__updateCamouflageResult(cache_item, summer_camo, winter_camo, desert_camo)
            return cache_item

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

        # xTDB, xTE, WTR, xWTR
        xtdb = -1
        xte = -1
        wtr = -1
        xwtr = -1
        if randomBattles > 0:
            stats = self.__getStatsBlock(dossier)
            dmg = stats.getDamageDealt()
            frg = stats.getFragsCount()
            if dmg >= 0 and frg >= 0:
                curdmg = float(dmg) / randomBattles
                curfrg = float(frg) / randomBattles
                xtdb = vehinfo.calculateXTDB(vehCD, curdmg)
                xte = vehinfo.calculateXTE(vehCD, curdmg, curfrg)
                #TODO: how to get WTR value from dossier?
                #wtr = stats.getWTR()
                #if wtr is None:
                #    wtr = -1
                #else:
                #    xwtr = vehinfo.calculateXvmScale('wtr', wtr)
        res = self.__prepareVehicleResult(accountDBID, vehCD, dossier, xtdb, xte, wtr, xwtr, earnedXP, freeXP, xpToElite, rent, multiNation)
        self.__updateCamouflageResult(res, summer_camo, winter_camo, desert_camo)
        self._cache[cache_key] = res
        return res

    # PRIVATE

    # check vehicle dossier already loaded and cached
    def __isVehicleDossierLoaded(self, accountDBID, vehCD):
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
            'totalBattles': dossier.getTotalStats().getBattlesCount(),
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
        if dossier is None:
            return {}

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
                                 ('%s %s' % (backport.getLongDateFormat(lbt), backport.getShortTimeFormat(lbt))),
            'vehicles': {}})

        vehicles = stats.getVehicles()
        for (vehCD, vdata) in vehicles.iteritems():
            res['vehicles'][str(vehCD)] = {
                'battles': vdata.battlesCount,
                'wins': vdata.wins,
                'mastery': stats.getMarkOfMasteryForVehicle(vehCD),
                'xp': vdata.xp}

        # add tanks with 0 battles
        vehicles = self.itemsCache.items.getVehicles(REQ_CRITERIA.INVENTORY)
        for (vehCD, vdata) in vehicles.iteritems():
            if str(vehCD) not in res['vehicles']:
                res['vehicles'][str(vehCD)] = {
                    'battles': 0,
                    'wins': 0,
                    'mastery': 0,
                    'xp': 0}

        return res

    def __prepareVehicleResult(self, accountDBID, vehCD, dossier, xtdb, xte, wtr, xwtr, earnedXP, freeXP, xpToElite, rent, multiNation):
        res = self.__prepareCommonResult(accountDBID, dossier)
        res.update({
            'vehCD': vehCD,
            'xtdb': xtdb,
            'xte': xte,
            'wtr': wtr,
            'xwtr': xwtr,
            'earnedXP': earnedXP,
            'freeXP': freeXP,
            'xpToElite': xpToElite,
            'rent': 'rent' if rent else None,
            'multiNation': 'multi' if multiNation else None,
            'marksOnGun': int(dossier.getRecordValue(_AB.TOTAL, 'marksOnGun')),
            'damageRating': dossier.getRecordValue(_AB.TOTAL, 'damageRating') / 100.0})
        return res

    def __updateCamouflageResult(self, res, summer_camo, winter_camo, desert_camo):
        res.update({
          'camouflageSummer': 'summer' if summer_camo else None,
          'camouflageWinter': 'winter' if winter_camo else None,
          'camouflageDesert': 'desert' if desert_camo else None,
          'camouflageCount': int(summer_camo) + int(winter_camo) + int(desert_camo)})

_dossier = None

def _init():
    global _dossier
    _dossier = _Dossier()

BigWorld.callback(0, _init)
