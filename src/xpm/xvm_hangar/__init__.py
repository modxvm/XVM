""" XVM (c) https://modxvm.com 2013-2020 """

#####################################################################
# imports

import traceback

import game
import helpers
import nations
from CurrentVehicle import g_currentVehicle
from gui.shared import g_eventBus
from gui.prb_control.entities.base.actions_validator import CurrentVehicleActionsValidator
from gui.prb_control.items import ValidationResult
from gui.prb_control.settings import PREBATTLE_RESTRICTION
from gui.Scaleform.daapi.view.meta.BarracksMeta import BarracksMeta
from gui.Scaleform.locale.MENU import MENU
from gui.shared.gui_items.Vehicle import Vehicle
from helpers import dependency
from skeletons.gui.shared import IItemsCache
from gui.Scaleform.daapi.view.meta.MessengerBarMeta import MessengerBarMeta
from messenger.gui.Scaleform.lobby_entry import LobbyEntry
from HeroTank import HeroTank
from vehicle_systems.tankStructure import ModelStates
from gui.promo.hangar_teaser_widget import TeaserViewer
from gui.game_control.AwardController import ProgressiveItemsRewardHandler
from gui.game_control.PromoController import PromoController
from gui.Scaleform.daapi.view.lobby.messengerBar.messenger_bar import MessengerBar
from gui.Scaleform.daapi.view.lobby.messengerBar.session_stats_button import SessionStatsButton
from gui.Scaleform.daapi.view.lobby.rankedBattles.ranked_battles_results import RankedBattlesResults
from gui.Scaleform.daapi.view.lobby.hangar.daily_quest_widget import DailyQuestWidget

from xfw import *

import xvm_main.python.config as config
from xvm_main.python.consts import *
from xvm_main.python.logger import *
from xvm_main.python.xvm import l10n

import svcmsg
import battletype
import counters

#####################################################################
# globals

cfg_hangar_barracksShowFlags = True
cfg_hangar_barracksShowSkills = True
cfg_hangar_blockVehicleIfLowAmmo = False

#####################################################################
# initialization/finalization

def onConfigLoaded(self, e=None):
    global cfg_hangar_barracksShowFlags
    cfg_hangar_barracksShowFlags = config.get('hangar/barracksShowFlags', True)

    global cfg_hangar_barracksShowSkills
    cfg_hangar_barracksShowSkills = config.get('hangar/barracksShowSkills', True)

    global cfg_hangar_blockVehicleIfLowAmmo
    cfg_hangar_blockVehicleIfLowAmmo = config.get('hangar/blockVehicleIfLowAmmo', False)

    Vehicle.NOT_FULL_AMMO_MULTIPLIER = config.get('hangar/lowAmmoPercentage', 20) / 100.0

g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, onConfigLoaded)

@registerEvent(game, 'fini')
def fini():
    g_eventBus.removeListener(XVM_EVENT.CONFIG_LOADED, onConfigLoaded)


#####################################################################
# handlers

# replace original 'NOT_FULL_AMMO_MULTIPLIER'
@overrideMethod(Vehicle, 'isAmmoFull')
def Vehicle_isAmmoFull(base, self):
    try:
        if self.isOnlyForEventBattles:
            mult = 0.2
        elif self.isOnlyForBattleRoyaleBattles:
            mult = 0.2
        else:
            mult = self.NOT_FULL_AMMO_MULTIPLIER
        return sum((s.count for s in self.shells.installed.getItems())) >= self.ammoMaxSize * mult
    except Exception as ex:
        err(traceback.format_exc())
        return base(self)

# barracks: add nation flag and skills for tanksman
@overrideMethod(BarracksMeta, 'as_setTankmenS')
def BarracksMeta_as_setTankmenS(base, self, data):
    try:
        if cfg_hangar_barracksShowFlags or cfg_hangar_barracksShowSkills:
            imgPath = 'img://../mods/shared_resources/xvm/res/icons/barracks'
            for tankman in data['tankmenData']:
                if ('role' not in tankman) or tankman['notRecruited']:
                    continue
                tankman['rank'] = tankman['role']
                tankman_role_arr = []
                if cfg_hangar_barracksShowFlags:
                    tankman_role_arr.append("<img src='%s/nations/%s.png' vspace='-3'>" % (imgPath, nations.NAMES[tankman['nationID']]))
                if cfg_hangar_barracksShowSkills:
                    tankman_role_arr.append('')
                    itemsCache = dependency.instance(IItemsCache)
                    tankman_full_info = itemsCache.items.getTankman(tankman['tankmanID'])
                    if tankman_full_info is not None:
                        for skill in tankman_full_info.skills:
                            tankman_role_arr[-1] += "<img src='%s/skills/%s' vspace='-3'>" % (imgPath, skill.icon)
                        if len(tankman_full_info.skills):
                            tankman_role_arr[-1] += "%s%%" % tankman_full_info.descriptor.lastSkillLevel
                        if tankman_full_info.hasNewSkill and tankman_full_info.newSkillCount[0] > 0:
                            tankman_role_arr[-1] += "<img src='%s/skills/new_skill.png' vspace='-3'>x%s" % (imgPath, tankman_full_info.newSkillCount[0])
                    if not tankman_role_arr[-1]:
                        tankman_role_arr[-1] = l10n('noSkills')
                tankman['role'] = ' '.join(tankman_role_arr)
    except Exception as ex:
        err(traceback.format_exc())
    return base(self, data)

# low ammo => vehicle not ready
@overrideMethod(Vehicle, 'isReadyToPrebattle')
def Vehicle_isReadyToPrebattle(base, self, *args, **kwargs):
    if isInBootcamp():
        return
    elif self.isOnlyForEventBattles:
        return True
    elif self.isOnlyForBattleRoyaleBattles:
        return True
    try:
        if not self.hasLockMode() and not self.isAmmoFull and cfg_hangar_blockVehicleIfLowAmmo:
            return False
    except Exception as ex:
        err(traceback.format_exc())
    return base(self, *args, **kwargs)

# low ammo => vehicle not ready
@overrideMethod(Vehicle, 'isReadyToFight')
def Vehicle_isReadyToFight(base, self, *args, **kwargs):
    if isInBootcamp():
        return
    elif self.isOnlyForEventBattles:
        return
    elif self.isOnlyForBattleRoyaleBattles:
        return
    try:
        if not self.hasLockMode() and not self.isAmmoFull and cfg_hangar_blockVehicleIfLowAmmo:
            return False
    except Exception as ex:
        err(traceback.format_exc())
    return base.fget(self, *args, **kwargs) # base is property

# low ammo => vehicle not ready (disable red button)
@overrideMethod(CurrentVehicleActionsValidator, '_validate')
def _CurrentVehicleActionsValidator_validate(base, self):
    res = base(self)
    if isInBootcamp():
        return res
    elif g_currentVehicle.isOnlyForEventBattles():
        return res
    elif g_currentVehicle.isOnlyForBattleRoyaleBattles():
        return res
    if not res or res[0] == True:
        try:
            if not g_currentVehicle.isReadyToFight() and g_currentVehicle.item and not g_currentVehicle.item.isAmmoFull and cfg_hangar_blockVehicleIfLowAmmo:
                res = ValidationResult(False, PREBATTLE_RESTRICTION.VEHICLE_NOT_READY)
        except Exception as ex:
            err(traceback.format_exc())
    return res

# low ammo => write on carousel's vehicle 'low ammo'
@overrideMethod(helpers.i18n, 'makeString')
def _i18n_makeString(base, key, *args, **kwargs):
    if key == MENU.TANKCAROUSEL_VEHICLESTATES_AMMONOTFULL: # originally returns empty string
        return l10n('lowAmmo')
    return base(key, *args, **kwargs)

# hide referral program button
@overrideMethod(MessengerBarMeta, 'as_setInitDataS')
def MessengerBarMeta_as_setInitDataS(base, self, data):
    if not config.get('hangar/showReferralButton', True) and ('isReferralEnabled' in data):
        data['isReferralEnabled'] = False
    return base(self, data)

# hide shared chat button
@overrideMethod(LobbyEntry, '_LobbyEntry__handleLazyChannelCtlInited')
def handleLazyChannelCtlInited(base, self, event):
    if not config.get('hangar/showGeneralChatButton', True):
        ctx = event.ctx
        controller = ctx.get('controller')
        if controller is None:
            log('Controller is not defined', ctx)
            return
        else:
            ctx.clear()
            return
    return base(self, event)

# hide premium vehicle on the background in the hangar
@overrideMethod(HeroTank, 'recreateVehicle')
def recreateVehicle(base, self, typeDescriptor=None, state=ModelStates.UNDAMAGED, callback=None):
    if not config.get('hangar/showPromoPremVehicle', True) and not self.isEvent:
        return
    base(self, typeDescriptor, state, callback)

# hide display pop-up messages in the hangar
@overrideMethod(TeaserViewer, 'show')
def show(base, self, teaserData, promoCount):
    if not config.get('hangar/combatIntelligence/showPopUpMessages', True):
        return
    base(self, teaserData, promoCount)

# hide display unread notifications counter in the menu
@overrideMethod(PromoController, 'getPromoCount')
def getPromoCount(base, self):
    if not config.get('hangar/combatIntelligence/showUnreadCounter', True):
        return
    base(self)

# hide ranked battle results window
@overrideMethod(RankedBattlesResults, '_populate')
def _populate(base, self):
    if not config.get('hangar/showRankedBattleResults', True):
        return
    base(self)

# hide display session statistics button
@overrideMethod(MessengerBar, '_MessengerBar__updateSessionStatsBtn')
def updateSessionStatsBtn(base, self):
    if not config.get('hangar/sessionStatsButton/showButton', True):
        self.as_setSessionStatsButtonVisibleS(False)
        self._MessengerBar__onSessionStatsBtnOnlyOnceHintHidden(True) # hide display session statistics help hints
        return
    base(self)

# hide display the counter of spent battles on the button
@overrideMethod(SessionStatsButton, '_SessionStatsButton__updateBatteleCount')
def updateBatteleCount(base, self):
    if not config.get('hangar/sessionStatsButton/showBattleCount', True):
        return
    base(self)

# hide display widget with daily quests
@overrideMethod(DailyQuestWidget, '_DailyQuestWidget__shouldHide')
def shouldHide(base, self):
    if not config.get('hangar/showDailyQuestWidget', True):
        return True
    base(self)

# hide display pop-up window when receiving progressive decals
@overrideMethod(ProgressiveItemsRewardHandler, '_showAward')
def _showAward(base, self, ctx):
    if not config.get('hangar/showProgressiveDecalsWindow', True):
        return
    base(self, ctx)
