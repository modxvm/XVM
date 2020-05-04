package net.wg.gui.battle.pveEvent.views
{
    import net.wg.gui.battle.random.views.BattlePage;
    import net.wg.gui.battle.pveEvent.views.eventPlayersPanel.EventPlayersPanel;
    import net.wg.gui.battle.pveEvent.views.battleHints.EventBattleHint;
    import net.wg.gui.battle.pveEvent.components.eventTimer.EventTimer;
    import net.wg.gui.battle.pveEvent.views.eventStats.EventStats;
    import net.wg.gui.battle.views.destroyTimers.EventDestroyTimersPanel;
    import net.wg.gui.battle.pveEvent.components.eventPlayerLives.EventPlayerLives;
    import net.wg.gui.battle.pveEvent.views.minimap.EventFullMap;
    import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
    import net.wg.gui.battle.battleloading.BaseBattleLoading;
    import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
    import flash.geom.Rectangle;
    import net.wg.gui.battle.views.minimap.constants.MinimapSizeConst;
    import net.wg.gui.battle.views.minimap.events.MinimapEvent;

    public class EventBattlePage extends BattlePage
    {

        private static const TOP_DETAILS_OFFSET_Y:Number = 470;

        private static const VEHICLE_MESSAGES_LIST_OFFSET_Y:int = 106;

        private static const DAMAGE_PANEL_SPACING:int = 30;

        private static const PANEL_LIVES_OFFSET_Y:int = 33;

        private static const PLAYER_MESSAGES_LIST_OFFSET_Y:Number = 25;

        private static const RIBBONS_POSTMORTEM_OFFSET:int = 423;

        private static const RIBBONS_SPACE:int = 136;

        public var playersPanelEvent:EventPlayersPanel = null;

        public var eventMessage:EventBattleHint = null;

        public var eventTimer:EventTimer = null;

        public var eventTimerTab:EventTimer = null;

        public var eventStats:EventStats = null;

        public var eventDestroyTimersPanel:EventDestroyTimersPanel = null;

        public var playerLives:EventPlayerLives = null;

        public var fullMap:EventFullMap = null;

        public function EventBattlePage()
        {
            super();
            battleTimer.visible = false;
            destroyTimersPanel.visible = false;
            this.fullMap.visible = false;
            endWarningPanel.visible = false;
            battleDamageLogPanel.setTopDetailsOffsetY(TOP_DETAILS_OFFSET_Y);
        }

        override public function as_setPostmortemTipsVisible(param1:Boolean) : void
        {
            super.as_setPostmortemTipsVisible(param1);
            postmortemTips.setCompVisible(param1);
            this.updateRibbonsPositionY();
        }

        override protected function updateRibbonsPositionY() : void
        {
            if(!postmortemTips.visible)
            {
                super.updateRibbonsPositionY();
            }
            else
            {
                ribbonsPanel.setFreeWorkingHeight(RIBBONS_SPACE);
                ribbonsPanel.y = _originalHeight - RIBBONS_POSTMORTEM_OFFSET;
            }
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            super.updateStage(param1,param2);
            var _loc3_:uint = param1 >> 1;
            var _loc4_:uint = param2 >> 1;
            this.eventMessage.updateStage(param1,param2);
            this.eventStats.updateStageSize(param1,param2);
            this.eventDestroyTimersPanel.updateStage(param1,param2);
            this.fullMap.updateStagePosition(param1,param2);
            this.eventStats.x = _loc3_;
            this.eventStats.y = _loc4_;
            this.eventTimer.x = _loc3_;
            this.eventTimer.updateStage(param1,param2);
            this.eventTimerTab.x = _loc3_;
            this.eventTimerTab.updateStage(param1,param2);
            if(this.playerLives)
            {
                this.playerLives.y = damagePanel.y - PANEL_LIVES_OFFSET_Y;
            }
        }

        override protected function getDamagePanelSpacing() : int
        {
            return DAMAGE_PANEL_SPACING;
        }

        override protected function getPlayersPanelBottom() : int
        {
            return this.playersPanelEvent.y + this.playersPanelEvent.height;
        }

        override protected function onRegisterStatisticController() : void
        {
        }

        override protected function createStatisticsController() : BattleStatisticDataController
        {
            return null;
        }

        override protected function initializeStatisticsController(param1:BattleStatisticDataController) : void
        {
        }

        override protected function getBattleLoading() : BaseBattleLoading
        {
            return null;
        }

        override protected function onPopulate() : void
        {
            registerComponent(this.playersPanelEvent,BATTLE_VIEW_ALIASES.PLAYERS_PANEL_EVENT);
            registerComponent(this.eventMessage,BATTLE_VIEW_ALIASES.BATTLE_HINT);
            registerComponent(this.eventTimer,BATTLE_VIEW_ALIASES.EVENT_TIMER);
            registerComponent(this.eventTimerTab,BATTLE_VIEW_ALIASES.EVENT_TIMER_TAB);
            registerComponent(this.eventStats,BATTLE_VIEW_ALIASES.EVENT_STATS);
            registerComponent(this.eventDestroyTimersPanel,BATTLE_VIEW_ALIASES.EVENT_DESTROY_TIMERS_PANEL);
            registerComponent(this.fullMap,BATTLE_VIEW_ALIASES.EVENT_FULL_MAP);
            if(this.playerLives)
            {
                registerComponent(this.playerLives,BATTLE_VIEW_ALIASES.EVENT_PLAYER_LIVES);
            }
            super.onPopulate();
        }

        override protected function onDispose() : void
        {
            this.playersPanelEvent = null;
            this.eventMessage = null;
            this.eventTimer = null;
            this.eventTimerTab = null;
            this.eventStats = null;
            this.eventDestroyTimersPanel = null;
            this.playerLives = null;
            this.fullMap = null;
            super.onDispose();
        }

        override protected function getAllowedMinimapSizeIndex(param1:Number) : Number
        {
            var _loc2_:Number = App.appWidth - consumablesPanel.panelWidth;
            var _loc3_:Rectangle = null;
            while(param1 > MinimapSizeConst.MIN_SIZE_INDEX)
            {
                _loc3_ = minimap.getMinimapRectBySizeIndex(param1);
                if(_loc2_ - _loc3_.width >= 0)
                {
                    break;
                }
                param1--;
            }
            return param1;
        }

        override protected function vehicleMessageListPositionUpdate() : void
        {
            if(postmortemTips && postmortemTips.visible)
            {
                super.vehicleMessageListPositionUpdate();
            }
            else
            {
                vehicleMessageList.setLocation(_originalWidth - VEHICLE_MESSAGES_LIST_OFFSET.x >> 1,_originalHeight - VEHICLE_MESSAGES_LIST_OFFSET_Y | 0);
            }
        }

        override protected function getPlayerMessagesListOffsetY() : Number
        {
            return PLAYER_MESSAGES_LIST_OFFSET_Y;
        }

        override protected function get isQuestProgress() : Boolean
        {
            return false;
        }

        override protected function onMiniMapChangeHandler(param1:MinimapEvent) : void
        {
            super.onMiniMapChangeHandler(param1);
            super.updateStage(App.appWidth,App.appHeight);
        }
    }
}
