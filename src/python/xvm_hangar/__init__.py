"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

# Python
import logging

# WoT
import helpers
from CurrentVehicle import g_currentVehicle
from gui.shared import g_eventBus
from gui.prb_control.entities.base.actions_validator import CurrentVehicleActionsValidator
from gui.prb_control.items import ValidationResult
from gui.prb_control.settings import PREBATTLE_RESTRICTION
from gui.Scaleform.genConsts.HANGAR_ALIASES import HANGAR_ALIASES
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
from gui.Scaleform.daapi.view.lobby.hangar.hangar_header import HangarHeader
from gui.Scaleform.daapi.view.lobby.header.LobbyHeader import LobbyHeader
from gui.Scaleform.daapi.view.lobby.profile.ProfileTechnique import ProfileTechnique

# XFW
from xfw import *

# XVM.Main
import xvm_main.python.config as config
from xvm_main.python.consts import *
from xvm_main.python.xvm import l10n



#
# Globals
#

cfg_hangar_blockVehicleIfLowAmmo = False



#
# Configuration
#

def onConfigLoaded(self, e=None):
    global cfg_hangar_blockVehicleIfLowAmmo
    cfg_hangar_blockVehicleIfLowAmmo = config.get('hangar/blockVehicleIfLowAmmo', False)

    Vehicle.NOT_FULL_AMMO_MULTIPLIER = config.get('hangar/lowAmmoPercentage', 20) / 100.0


#
# Handlers/LowAmmoValidators
#

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
    except Exception:
        logging.getLogger('XVM/Hangar').exception('Vehicle_isAmmoFull')
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
    except Exception:
        logging.getLogger('XVM/Hangar').exception('Vehicle_isReadyToPrebattle')
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
    except Exception:
        logging.getLogger('XVM/Hangar').exception('Vehicle_isReadyToFight')
    return result # base is property


# low ammo => vehicle not ready (disable red button)
def CurrentVehicleActionsValidator_validate(base, self):
    res = base(self)
    if g_currentVehicle.isOnlyForEventBattles():
        return res
    elif g_currentVehicle.isOnlyForBattleRoyaleBattles():
        return res
    if not res or res[0] == True:
        try:
            if not g_currentVehicle.isReadyToFight() and g_currentVehicle.item and not g_currentVehicle.item.isAmmoFull and cfg_hangar_blockVehicleIfLowAmmo:
                res = ValidationResult(False, PREBATTLE_RESTRICTION.VEHICLE_NOT_READY)
        except Exception:
            logging.getLogger('XVM/Hangar').exception('CurrentVehicleActionsValidator_validate')
    return res


# low ammo => write on carousel's vehicle 'low ammo'
def _i18n_makeString(base, key, *args, **kwargs):
    if key == MENU.TANKCAROUSEL_VEHICLESTATES_AMMONOTFULL: # originally returns empty string
        return l10n('lowAmmo')
    return base(key, *args, **kwargs)



#
# Handlers/MessengerBar
#

# hide referral program button
def MessengerBarMeta_as_setInitDataS(base, self, data):
    if not config.get('hangar/showReferralButton', True) and ('isReferralEnabled' in data):
        data['isReferralEnabled'] = False
    return base(self, data)


# hide shared chat button
def _LobbyEntry__handleLazyChannelCtlInited(base, self, event):
    if not config.get('hangar/showGeneralChatButton', True):
        ctx = event.ctx
        controller = ctx.get('controller')
        if controller is None:
            logging.getLogger('XVM/Hangar').warning('Controller is not defined: %s', ctx)
            return
        else:
            ctx.clear()
            return
    return base(self, event)



#
# Handlers/HeroTank
#

# hide premium vehicle on the background in the hangar
def HeroTank_recreateVehicle(base, self, typeDescriptor=None, state=ModelStates.UNDAMAGED, callback=None, outfit=None):
    if not config.get('hangar/showPromoPremVehicle', True):
        return
    base(self, typeDescriptor, state, callback, outfit)



#
# Handlers/CombatIntelligence
#

# hide display pop-up messages in the hangar
def TeaserViewer_show(base, self, teaserData, promoCount):
    if not config.get('hangar/combatIntelligence/showPopUpMessages', True):
        return
    base(self, teaserData, promoCount)


# hide display unread notifications counter in the menu
def PromoController_getPromoCount(base, self):
    if not config.get('hangar/combatIntelligence/showUnreadCounter', True):
        return
    base(self)



#
# Handlers/RankedBattlesResults
#

# hide ranked battle results window
def RankedBattlesResults_populate(base, self):
    if not config.get('hangar/showRankedBattleResults', True):
        return
    base(self)



#
# Handlers/SessionStatsButton
#

# hide display session statistics button
def _MessengerBar__updateSessionStatsBtn(base, self):
    if not config.get('hangar/sessionStatsButton/showButton', True):
        self.as_setSessionStatsButtonVisibleS(False)
        self._MessengerBar__onSessionStatsBtnOnlyOnceHintHidden(True) # hide display session statistics help hints
        return
    base(self)


# hide display the counter of spent battles on the button
def _SessionStatsButton__updateBatteleCount(base, self):
    if not config.get('hangar/sessionStatsButton/showBattleCount', True):
        return
    base(self)



#
# Handlers/DailyQuestWidget
#

# hide display widget with daily quests
def _DailyQuestWidget__shouldHide(base, self):
    if not config.get('hangar/showDailyQuestWidget', True):
        return True
    return base(self)



#
# Handlers/ProgressiveItemsRewardHandler
#

# hide display pop-up window when receiving progressive decals
def ProgressiveItemsRewardHandler_showAward(base, self, ctx):
    if not config.get('hangar/showProgressiveDecalsWindow', True):
        return
    base(self, ctx)



#
# Handlers/EventEntryPointsContainer
#

# hide display banner of various events in the hangar
def _EventEntryPointsContainer__updateEntries(base, self):
    if not config.get('hangar/showEventBanner', True):
        self.as_updateEntriesS([])
        return
    base(self)



#
# Handlers/CarouselEntryPoints
#

# hide lootboxes widget in tank carousel in hangar
def LootBoxesEntryPoint_getIsActive(base, state):
    if not config.get('hangar/showLootboxesWidget', True):
        return False
    return base(state)


def Hangar_as_updateCarouselEventEntryStateS(base, self, isVisible):
    if not config.get('hangar/showLootboxesWidget', True):
        isVisible = False
    return base(self, isVisible)


def Hangar_as_setRewardKitsVisibleS(base, self, isVisible):
    if not config.get('hangar/showLootboxesWidget', True):
        isVisible = False
    return base(self, isVisible)


def Hangar_as_setEventTournamentBannerVisibleS(base, self, alias, visible):
    if not config.get('hangar/showEventTournamentWidget', True):
        visible = False
    return base(self, alias, visible)


# Destroy widget if hidden
def TournamentsWidgetComponent_makeInjectView(base, self):
    if not config.get('hangar/showEventTournamentWidget', True):
        self.destroy()
        return
    return base(self)



#
# Handlers/Prestige (WG)
#

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



#
# Handlers/LobbyHeader
#

LOBBY_HEADER_BUTTON_TO_CONFIG = {
    LobbyHeader.BUTTONS.WOT_PLUS: 'showWotPlusButton',
    LobbyHeader.BUTTONS.PREM: 'showBuyPremiumButton',
    LobbyHeader.BUTTONS.PREMSHOP: 'showPremiumShopButton'
}

# hide premium account, shop and WoT Plus buttons
def LobbyHeader_as_setHeaderButtonsS(base, self, buttons):
    for button, key in LOBBY_HEADER_BUTTON_TO_CONFIG.iteritems():
        if not config.get('hangar/%s' % key, True) and button in buttons:
            buttons.remove(button)
    return base(self, buttons)



#
# Handlers/HangarHeader
#

def _HangarHeader__getBPWidget(base, self):
    if config.get('hangar/showBattlePassWidget', True):
        return base(self)
    return ''


def _HangarHeader__getWidgetAlias(base, self):
    result = base(self)
    if not config.get('hangar/showBattlePassWidget', True) and result == HANGAR_ALIASES.BATTLE_PASSS_ENTRY_POINT:
        result = ''
    return result


def _HangarHeader__updateBattlePassSmallWidget(base, self):
    if config.get('hangar/showBattlePassWidget', True):
        return base(self)
    return



#
# Handlers/Achievements (WG)
#

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
        overrideMethod(CurrentVehicleActionsValidator, '_validate')(CurrentVehicleActionsValidator_validate)
        overrideMethod(helpers.i18n, 'makeString')(_i18n_makeString)

        overrideMethod(MessengerBarMeta, 'as_setInitDataS')(MessengerBarMeta_as_setInitDataS)
        overrideMethod(LobbyEntry, '_LobbyEntry__handleLazyChannelCtlInited')(_LobbyEntry__handleLazyChannelCtlInited)
        overrideMethod(HeroTank, 'recreateVehicle')(HeroTank_recreateVehicle)
        overrideMethod(TeaserViewer, 'show')(TeaserViewer_show)
        overrideMethod(PromoController, 'getPromoCount')(PromoController_getPromoCount)
        overrideMethod(RankedBattlesResults, '_populate')(RankedBattlesResults_populate)
        overrideMethod(MessengerBar, '_MessengerBar__updateSessionStatsBtn')(_MessengerBar__updateSessionStatsBtn)
        overrideMethod(SessionStatsButton, '_SessionStatsButton__updateBatteleCount')(_SessionStatsButton__updateBatteleCount)

        overrideMethod(DailyQuestWidget, '_DailyQuestWidget__shouldHide')(_DailyQuestWidget__shouldHide)
        overrideMethod(ProgressiveItemsRewardHandler, '_showAward')(ProgressiveItemsRewardHandler_showAward)
        overrideMethod(EventEntryPointsContainer, '_EventEntryPointsContainer__updateEntries')(_EventEntryPointsContainer__updateEntries)
        overrideMethod(Hangar, 'as_updateCarouselEventEntryStateS')(Hangar_as_updateCarouselEventEntryStateS)

        overrideMethod(LobbyHeader, 'as_setHeaderButtonsS')(LobbyHeader_as_setHeaderButtonsS)
        overrideMethod(HangarHeader, '_HangarHeader__updateBattlePassSmallWidget')(_HangarHeader__updateBattlePassSmallWidget)

        if getRegion() != 'RU':
            from gui.game_control.achievements_earning_controller import EarningAnimationCommand, RewardScreenCommand
            from gui.impl.lobby.comp7.tournaments_widget import TournamentsWidgetComponent
            from gui.impl.lobby.lootbox_system.entry_point import LootBoxSystemEntryPoint

            overrideMethod(Hangar, 'as_setPrestigeWidgetVisibleS')(Hangar_as_setPrestigeWidgetVisibleS)
            overrideMethod(ProfileTechnique, 'as_setPrestigeVisibleS')(ProfileTechnique_as_setPrestigeVisibleS)
            overrideMethod(Hangar, 'as_setEventTournamentBannerVisibleS')(Hangar_as_setEventTournamentBannerVisibleS)
            # WG NY Lootboxes
            # TODO: remove after WG NY
            overrideMethod(Hangar, 'as_setRewardKitsVisibleS')(Hangar_as_setRewardKitsVisibleS)
            overrideStaticMethod(LootBoxSystemEntryPoint, 'getIsActive')(LootBoxesEntryPoint_getIsActive)
            overrideMethod(HangarHeader, '_HangarHeader__getBPWidget')(_HangarHeader__getBPWidget)
            overrideMethod(TournamentsWidgetComponent, '_makeInjectView')(TournamentsWidgetComponent_makeInjectView)
            overrideMethod(RewardScreenCommand, 'execute')(RewardScreenCommand_execute)
            overrideMethod(EarningAnimationCommand, 'execute')(EarningAnimationCommand_execute)
        else:
            from gui_lootboxes.gui.impl.lobby.gui_lootboxes.entry_point_view import LootBoxesEntryPointWidget

            overrideStaticMethod(LootBoxesEntryPointWidget, 'getIsActive')(LootBoxesEntryPoint_getIsActive)
            overrideMethod(HangarHeader, '_HangarHeader__getWidgetAlias')(_HangarHeader__getWidgetAlias)

        import battletype
        battletype.init()

        import counters
        counters.init()

        import svcmsg
        svcmsg.init()

        import version_label
        version_label.init()

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

        import version_label
        version_label.fini()

        __initialized = False


def xfw_is_module_loaded():
    global __initialized
    return __initialized
