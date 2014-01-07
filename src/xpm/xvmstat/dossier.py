""" xvm (c) sirmax 2013 """

#############################
# Command

def getDossier(proxy, args):
    _dossier.getDossier(proxy, args)


#############################
# Private

from pprint import pprint
import traceback
from adisp import process

from gui.shared.gui_items import GUI_ITEM_TYPE
from helpers.i18n import makeString
from gui.Scaleform.locale.MENU import MENU

from gui.mods.xpm import *
from constants import *
from logger import *

#############################

class _Dossier(object):

    def getDossier(self, proxy, args):
        (self.playerId, self.vehId) = args

        #pprint(args)

        from gui.shared import g_itemsCache

        if self.vehId is None:
            if self.playerId is None:
                dossier = g_itemsCache.items.getAccountDossier()
            else:
                plid = int(self.playerId)
                container = g_itemsCache.items._ItemsRequester__itemsCache[GUI_ITEM_TYPE.ACCOUNT_DOSSIER]
                ddescr = container.get(plid)
                if ddescr is None:
                    (ddescr, hidden) = yield g_itemsCache.items.requestUserDossier(plid)
                from gui import game_control
                if game_control.g_instance.roaming.isInRoaming():
                    isInRoaming = game_control.g_instance.roaming.isPlayerInRoaming(plid)
                else:
                    isInRoaming = False
                from gui.shared.gui_items.dossier import AccountDossier
                dossier = AccountDossier(ddescr, False, isInRoaming)

            res = self.prepareAccountResult(dossier)

        else:
            vid = int(self.vehId)
            if self.playerId is None:
                dossier = g_itemsCache.items.getVehicleDossier(vid)
            else:
                plid = int(self.playerId)
                container = g_itemsCache.items._ItemsRequester__itemsCache[GUI_ITEM_TYPE.VEHICLE_DOSSIER]
                ddescr = container.get((plid, vid))
                if ddescr is None:
                    ddescr = yield g_itemsCache.items.requestUserVehicleDossier(plid, vid)
                from gui.shared.gui_items.dossier import VehicleDossier
                dossier = VehicleDossier(ddescr)

            res = self.prepareVehicleResult(dossier)

        # respond
        if proxy and proxy.component and proxy.movie:
            strdata = json.dumps(res)
            proxy.movie.invoke((RESPOND_DOSSIER, [self.playerId, self.vehId, strdata]))

        #print(str(args) + " done")

    getDossier = process(getDossier)


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

        lbt = glob.getLastBattleTime()
        res.update({
            'maxXPVehId': total.getMaxXpVehicle(),
            'maxFragsVehId': total.getMaxFragsVehicle(),
            'maxDamageVehId': total.getMaxDamageVehicle(),

            'creationTime': glob.getCreationTime(),
            'lastBattleTime': lbt,
            'lastBattleTimeStr': makeString(MENU.PROFILE_HEADER_LASTBATTLEDATETITLE) + ' ' +
                ('%s %s' % (BigWorld.wg_getLongDateFormat(lbt), BigWorld.wg_getShortTimeFormat(lbt))),

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
