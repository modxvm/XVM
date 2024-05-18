"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2024 XVM Contributors
"""

#####################################################################
# imports

import traceback

import helpers
from CurrentVehicle import g_currentVehicle
from gui.shared import g_eventBus
from gui.prb_control.entities.base.actions_validator import CurrentVehicleActionsValidator
from gui.prb_control.items import ValidationResult
from gui.prb_control.settings import PREBATTLE_RESTRICTION
from gui.Scaleform.locale.MENU import MENU
from gui.shared.gui_items.Vehicle import Vehicle
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
from gui.Scaleform.daapi.view.lobby.hangar.entry_points.event_entry_points_container import EventEntryPointsContainer
from gui.Scaleform.daapi.view.lobby.hangar.Hangar import Hangar
from gui.Scaleform.daapi.view.lobby.header.LobbyHeader import LobbyHeader
from gui.Scaleform.daapi.view.lobby.profile.ProfileTechnique import ProfileTechnique

from xfw import *

import xvm_main.python.config as config
from xvm_main.python.consts import *
from xvm_main.python.logger import *
from xvm_main.python.xvm import l10n

if getRegion() != 'RU':
    # Lootboxes widget / WG related import
    from event_lootboxes.gui.impl.lobby.event_lootboxes.entry_point_view import EventLootBoxesEntryPointWidget as LootBoxesEntryPointWidget
else:
    # Lootboxes widget / Lesta related import
    from gui_lootboxes.gui.impl.lobby.gui_lootboxes.entry_point_view import LootBoxesEntryPointWidget

#####################################################################
# globals

cfg_hangar_blockVehicleIfLowAmmo = False

#####################################################################
# initialization/finalization

def onConfigLoaded(self, e=None):
    global cfg_hangar_blockVehicleIfLowAmmo
    cfg_hangar_blockVehicleIfLowAmmo = config.get('hangar/blockVehicleIfLowAmmo', False)

    Vehicle.NOT_FULL_AMMO_MULTIPLIER = config.get('hangar/lowAmmoPercentage', 20) / 100.0


#####################################################################
# handlers

# replace original 'NOT_FULL_AMMO_MULTIPLIER'
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

# low ammo => vehicle not ready
def Vehicle_isReadyToPrebattle(base, self, *args, **kwargs):
    result = base(self, *args, **kwargs)
    if self.isOnlyForEventBattles:
        return result
    elif self.isOnlyForBattleRoyaleBattles:
        return result
    try:
        if not self.hasLockMode() and not self.isAmmoFull and cfg_hangar_blockVehicleIfLowAmmo:
            return False
    except Exception as ex:
        err(traceback.format_exc())
    return result

# low ammo => vehicle not ready
def Vehicle_isReadyToFight(base, self, *args, **kwargs):
    result = base.fget(self, *args, **kwargs)
    if self.isOnlyForEventBattles:
        return result
    elif self.isOnlyForBattleRoyaleBattles:
        return result
    try:
        if not self.hasLockMode() and not self.isAmmoFull and cfg_hangar_blockVehicleIfLowAmmo:
            return False
    except Exception as ex:
        err(traceback.format_exc())
    return result # base is property

# low ammo => vehicle not ready (disable red button)
def _CurrentVehicleActionsValidator_validate(base, self):
    res = base(self)
    if g_currentVehicle.isOnlyForEventBattles():
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
def _i18n_makeString(base, key, *args, **kwargs):
    if key == MENU.TANKCAROUSEL_VEHICLESTATES_AMMONOTFULL: # originally returns empty string
        return l10n('lowAmmo')
    return base(key, *args, **kwargs)

# hide referral program button
def MessengerBarMeta_as_setInitDataS(base, self, data):
    if not config.get('hangar/showReferralButton', True) and ('isReferralEnabled' in data):
        data['isReferralEnabled'] = False
    return base(self, data)

# hide shared chat button
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
def recreateVehicle(base, self, typeDescriptor=None, state=ModelStates.UNDAMAGED, callback=None, outfit=None):
    if not config.get('hangar/showPromoPremVehicle', True):
        return
    base(self, typeDescriptor, state, callback, outfit)

# hide display pop-up messages in the hangar
def show(base, self, teaserData, promoCount):
    if not config.get('hangar/combatIntelligence/showPopUpMessages', True):
        return
    base(self, teaserData, promoCount)

# hide display unread notifications counter in the menu
def getPromoCount(base, self):
    if not config.get('hangar/combatIntelligence/showUnreadCounter', True):
        return
    base(self)

# hide ranked battle results window
def _populate(base, self):
    if not config.get('hangar/showRankedBattleResults', True):
        return
    base(self)

# hide display session statistics button
def updateSessionStatsBtn(base, self):
    if not config.get('hangar/sessionStatsButton/showButton', True):
        self.as_setSessionStatsButtonVisibleS(False)
        self._MessengerBar__onSessionStatsBtnOnlyOnceHintHidden(True) # hide display session statistics help hints
        return
    base(self)

# hide display the counter of spent battles on the button
def updateBatteleCount(base, self):
    if not config.get('hangar/sessionStatsButton/showBattleCount', True):
        return
    base(self)

# hide display widget with daily quests
def shouldHide(base, self):
    if not config.get('hangar/showDailyQuestWidget', True):
        return True
    return base(self)

# hide display pop-up window when receiving progressive decals
def _showAward(base, self, ctx):
    if not config.get('hangar/showProgressiveDecalsWindow', True):
        return
    base(self, ctx)

# hide display banner of various events in the hangar
def updateEntries(base, self):
    if not config.get('hangar/showEventBanner', True):
        self.as_updateEntriesS([])
        return
    base(self)

# hide lootboxes widget in tank carousel in hangar
def LootBoxesEntryPointWidget_getIsActive(base, state):
    if not config.get('hangar/showLootboxesWidget', True):
        return False
    return base(state)

# hide prestige (elite levels) system widget in the hangar
def Hangar_as_setPrestigeWidgetVisibleS(base, self, value):
    if not config.get('hangar/showHangarPrestigeWidget', True):
        value = False
    return base(self, value)

# hide prestige (elite levels) system widget in the profile 
def ProfileTechnique_as_setPrestigeVisibleS(base, self, value):
    if not config.get('hangar/showProfilePrestigeWidget', True):
        value = False
    return base(self, value)

# hide premium account, shop and WoT Plus buttons
def LobbyHeader_as_setHeaderButtonsS(base, self, data):
    if not config.get('hangar/showWotPlusButton', True) and self.BUTTONS.WOT_PLUS in data:
        data.remove(self.BUTTONS.WOT_PLUS)
    if not config.get('hangar/showBuyPremiumButton', True) and self.BUTTONS.PREM in data:
        data.remove(self.BUTTONS.PREM)
    if not config.get('hangar/showPremiumShopButton', True) and self.BUTTONS.PREMSHOP in data:
        data.remove(self.BUTTONS.PREMSHOP)
    return base(self, data)

# hide achievement reward fullscreen window
def RewardScreenCommand_execute(base, self):
    if config.get('hangar/showAchievementRewardWindow', True):
        base(self)
        return
    self.release()

# hide achievement popups
def EarningAnimationCommand_execute(base, self):
    if config.get('hangar/showAchievementPopups', True):
        base(self)
        return
    self.release()

#
# XFW API
#

__initialized = False

def xfw_module_init():
    global __initialized
    if not __initialized:
        g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, onConfigLoaded)

        overrideMethod(Vehicle, 'isAmmoFull')(Vehicle_isAmmoFull)
        overrideMethod(Vehicle, 'isReadyToPrebattle')(Vehicle_isReadyToPrebattle)
        overrideMethod(Vehicle, 'isReadyToFight')(Vehicle_isReadyToFight)
        overrideMethod(CurrentVehicleActionsValidator, '_validate')(_CurrentVehicleActionsValidator_validate)
        overrideMethod(helpers.i18n, 'makeString')(_i18n_makeString)

        overrideMethod(MessengerBarMeta, 'as_setInitDataS')(MessengerBarMeta_as_setInitDataS)
        overrideMethod(LobbyEntry, '_LobbyEntry__handleLazyChannelCtlInited')(handleLazyChannelCtlInited)
        overrideMethod(HeroTank, 'recreateVehicle')(recreateVehicle)
        overrideMethod(TeaserViewer, 'show')(show)
        overrideMethod(PromoController, 'getPromoCount')(getPromoCount)
        overrideMethod(RankedBattlesResults, '_populate')(_populate)
        overrideMethod(MessengerBar, '_MessengerBar__updateSessionStatsBtn')(updateSessionStatsBtn)
        overrideMethod(SessionStatsButton, '_SessionStatsButton__updateBatteleCount')(updateBatteleCount)

        overrideMethod(DailyQuestWidget, '_DailyQuestWidget__shouldHide')(shouldHide)
        overrideMethod(ProgressiveItemsRewardHandler, '_showAward')(_showAward)
        overrideMethod(EventEntryPointsContainer, '_EventEntryPointsContainer__updateEntries')(updateEntries)
        overrideStaticMethod(LootBoxesEntryPointWidget, 'getIsActive')(LootBoxesEntryPointWidget_getIsActive)

        overrideMethod(LobbyHeader, 'as_setHeaderButtonsS')(LobbyHeader_as_setHeaderButtonsS)

        if getRegion() != 'RU':
            from gui.game_control.achievements_earning_controller import EarningAnimationCommand, RewardScreenCommand

            overrideMethod(Hangar, 'as_setPrestigeWidgetVisibleS')(Hangar_as_setPrestigeWidgetVisibleS)
            overrideMethod(ProfileTechnique, 'as_setPrestigeVisibleS')(ProfileTechnique_as_setPrestigeVisibleS)
            overrideMethod(RewardScreenCommand, 'execute')(RewardScreenCommand_execute)
            overrideMethod(EarningAnimationCommand, 'execute')(EarningAnimationCommand_execute)

        import battletype
        battletype.init()

        import counters
        counters.init()

        import svcmsg
        svcmsg.init()

        __initialized = True


def xfw_module_fini():
    global __initialized
    if __initialized:
        g_eventBus.removeListener(XVM_EVENT.CONFIG_LOADED, onConfigLoaded)

        import battletype
        battletype.fini()

        import counters
        counters.fini()

        import svcmsg
        svcmsg.fini()

        __initialized = False


def xfw_is_module_loaded():
    global __initialized
    return __initialized
