package net.wg.gui.battle.pveEvent.views
{
    import net.wg.gui.battle.random.views.BattlePage;
    import net.wg.gui.battle.pveEvent.views.eventPlayersPanel.EventPlayersPanel;
    import net.wg.gui.battle.pveEvent.views.battleHints.EventBattleHint;
    import net.wg.gui.battle.pveEvent.components.eventPointCounter.EventPointCounter;
    import net.wg.gui.battle.pveEvent.components.bossIndicatorProgress.BossIndicatorProgress;
    import net.wg.gui.battle.pveEvent.components.eventTimer.EventTimer;
    import net.wg.gui.battle.pveEvent.views.eventStats.EventStats;
    import net.wg.gui.battle.views.destroyTimers.EventDestroyTimersPanel;
    import net.wg.gui.battle.pveEvent.views.buffsPanel.BuffsPanel;
    import net.wg.gui.battle.pveEvent.views.phaseIndicator.PhaseIndicator;
    import net.wg.gui.battle.views.ribbonsPanel.RibbonCtrl;
    import net.wg.gui.components.ribbon.data.RibbonSettings;
    import net.wg.gui.components.ribbon.data.PaddingSettings;
    import net.wg.gui.components.battleDamagePanel.constants.BattleDamageLogConstants;
    import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
    import net.wg.gui.battle.battleloading.BaseBattleLoading;
    import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
    import net.wg.gui.battle.pveEvent.components.bossIndicatorProgress.BossIndicatorEvent;
    import flash.geom.Rectangle;
    import net.wg.gui.battle.views.minimap.constants.MinimapSizeConst;
    import net.wg.gui.battle.views.minimap.events.MinimapEvent;

    public class EventBattlePage extends BattlePage
    {

        private static const TOP_DETAILS_OFFSET_Y:Number = 510;

        private static const POINT_COUNTER_HALFWIDTH:int = 64;

        private static const POINT_COUNTER_HEIGHT:int = 60;

        private static const POINT_COUNTER_ADAPTIVE_OFFSET:int = 30;

        private static const MINIMAP_BORDER:int = 15;

        private static const BOSS_INDICATOR_PROGRESS_WIDTH:int = 406;

        private static const BOSS_INDICATOR_PROGRESS_HEIGHT:int = 34;

        private static const BOSS_INDICATOR_PROGRESS_HEIGHT_ALL:int = 45;

        private static const VEHICLE_MESSAGES_LIST_OFFSET_Y:int = 106;

        private static const PLAYER_MESSAGES_ADAPTIVE_MAX_WIDTH:int = 1200;

        private static const ADAPTIVE_PLAYER_MESSAGES_RIBBON_PANEL_OFFSET:int = -20;

        private static const BUFF_PANEL_OFFSET_Y:int = 240;

        private static const HEIGHT_MIN:int = 810;

        private static const MIN_COUNT_RIBBONS:int = 2;

        private static const MAX_COUNT_RIBBONS:int = 3;

        private static const RIBBONS_PANEL_OFFSET_Y:int = 15;

        private static const PHASE_INDICATOR_TOP:int = 15;

        private static const PHASE_INDICATOR_RIGHT:int = 18;

        public var playersPanelEvent:EventPlayersPanel = null;

        public var eventMessage:EventBattleHint = null;

        public var eventPointCounter:EventPointCounter = null;

        public var bossIndicatorProgress:BossIndicatorProgress = null;

        public var eventTimer:EventTimer = null;

        public var eventStats:EventStats = null;

        public var eventDestroyTimersPanel:EventDestroyTimersPanel = null;

        public var buffsPanel:BuffsPanel = null;

        public var phaseIndicator:PhaseIndicator = null;

        public function EventBattlePage()
        {
            super();
            this.bossIndicatorProgress.visible = false;
            battleTimer.visible = false;
            endWarningPanel.visible = false;
            this.bossIndicatorProgress.addEventListener(BossIndicatorEvent.INDICATOR_ENABLED,this.onBossProgressIndicatorEnabledHandler);
            battleDamageLogPanel.setTopDetailsOffsetY(TOP_DETAILS_OFFSET_Y);
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            super.updateStage(param1,param2);
            var _loc3_:uint = param1 >> 1;
            var _loc4_:uint = param2 >> 1;
            this.eventMessage.updateStage(param1,param2);
            this.eventStats.updateStageSize(param1,param2);
            this.eventDestroyTimersPanel.updateStage(param1,param2);
            this.eventStats.x = _loc3_;
            this.eventStats.y = _loc4_;
            this.eventTimer.x = _loc3_;
            this.buffsPanel.x = _loc3_;
            this.buffsPanel.y = App.appHeight - BUFF_PANEL_OFFSET_Y;
            var _loc5_:int = param2 < HEIGHT_MIN?MIN_COUNT_RIBBONS:MAX_COUNT_RIBBONS;
            var _loc6_:int = this.buffsPanel.y - RibbonCtrl.ITEM_HEIGHT * _loc5_ - RIBBONS_PANEL_OFFSET_Y;
            if(ribbonsPanel.y > _loc6_)
            {
                ribbonsPanel.y = _loc6_;
            }
            ribbonsPanel.setFreeWorkingHeight(this.buffsPanel.y - ribbonsPanel.y);
            this.phaseIndicator.x = _originalWidth - PHASE_INDICATOR_RIGHT;
            this.phaseIndicator.y = PHASE_INDICATOR_TOP;
            this.setBossIndicatorProgressPosition();
            this.consumablesPanelPositionUpdated();
            this.playerMessageListPositionUpdate();
        }

        override protected function setRibbonsPanelX() : void
        {
            var _loc1_:* = 0;
            var _loc2_:PaddingSettings = RibbonSettings.getBuffsPaddings();
            if(_loc2_)
            {
                _loc1_ = _loc2_.ribbonOffset;
            }
            ribbonsPanel.x = (_originalWidth >> 1) + _loc1_;
        }

        override protected function consumablesPanelPositionUpdated() : void
        {
            this.eventPointCounter.x = App.appWidth - consumablesPanel.panelWidth - POINT_COUNTER_HALFWIDTH;
            this.eventPointCounter.y = App.appHeight - POINT_COUNTER_HEIGHT;
            if(battleDamageLogPanel.x + BattleDamageLogConstants.MAX_DAMAGE_LOG_VIEW_WIDTH > this.eventPointCounter.x - POINT_COUNTER_HALFWIDTH)
            {
                this.eventPointCounter.y = this.eventPointCounter.y + POINT_COUNTER_ADAPTIVE_OFFSET;
            }
        }

        override protected function getDamageLogPanelRightSpace() : int
        {
            return App.appWidth - consumablesPanel.panelWidth - (POINT_COUNTER_HALFWIDTH << 1);
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
            registerComponent(this.eventPointCounter,BATTLE_VIEW_ALIASES.EVENT_POINT_COUNTER);
            registerComponent(this.bossIndicatorProgress,BATTLE_VIEW_ALIASES.BOSS_INDICATOR_PROGRESS);
            registerComponent(this.eventTimer,BATTLE_VIEW_ALIASES.EVENT_TIMER);
            registerComponent(this.eventStats,BATTLE_VIEW_ALIASES.EVENT_STATS);
            registerComponent(this.eventDestroyTimersPanel,BATTLE_VIEW_ALIASES.EVENT_DESTROY_TIMERS_PANEL);
            registerComponent(this.buffsPanel,BATTLE_VIEW_ALIASES.EVENT_BUFFS_PANEL);
            registerComponent(this.phaseIndicator,BATTLE_VIEW_ALIASES.EVENT_PHASE_INDICATOR);
            super.onPopulate();
        }

        override protected function onDispose() : void
        {
            this.bossIndicatorProgress.removeEventListener(BossIndicatorEvent.INDICATOR_ENABLED,this.onBossProgressIndicatorEnabledHandler);
            this.playersPanelEvent = null;
            this.eventMessage = null;
            this.eventPointCounter = null;
            this.bossIndicatorProgress = null;
            this.eventTimer = null;
            this.eventStats = null;
            this.eventDestroyTimersPanel = null;
            this.buffsPanel = null;
            this.phaseIndicator = null;
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

        override protected function playerMessageListPositionUpdate() : void
        {
            var _loc1_:* = 0;
            var _loc2_:* = 0;
            if(minimap.visible)
            {
                _loc1_ = _originalHeight - minimap.getMessageCoordinate() + PLAYER_MESSAGES_LIST_OFFSET.y;
                _loc2_ = ribbonsPanel.y + ADAPTIVE_PLAYER_MESSAGES_RIBBON_PANEL_OFFSET;
                if(_originalWidth < PLAYER_MESSAGES_ADAPTIVE_MAX_WIDTH && _loc2_ < _loc1_)
                {
                    _loc1_ = _loc2_;
                }
                playerMessageList.setLocation(_originalWidth - PLAYER_MESSAGES_LIST_OFFSET.x | 0,_loc1_);
            }
            else
            {
                playerMessageList.setLocation(_originalWidth - PLAYER_MESSAGES_LIST_OFFSET.x | 0,battleMessenger.y);
            }
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

        private function setBossIndicatorProgressPosition() : void
        {
            if(!this.bossIndicatorProgress.isEnabled)
            {
                return;
            }
            this.bossIndicatorProgress.x = minimap.x + minimap.currentTopLeftPoint.x - MINIMAP_BORDER;
            this.bossIndicatorProgress.width = App.appWidth - this.bossIndicatorProgress.x;
            var _loc1_:Number = (App.appWidth - this.bossIndicatorProgress.x) / BOSS_INDICATOR_PROGRESS_WIDTH;
            var _loc2_:Number = BOSS_INDICATOR_PROGRESS_HEIGHT * _loc1_;
            this.bossIndicatorProgress.y = minimap.y + minimap.currentTopLeftPoint.y - MINIMAP_BORDER - _loc2_;
            this.bossIndicatorProgress.height = BOSS_INDICATOR_PROGRESS_HEIGHT_ALL * _loc1_;
            minimap.messageCoordinateOffset = _loc2_;
            this.playerMessageListPositionUpdate();
        }

        override protected function get isQuestProgress() : Boolean
        {
            return false;
        }

        override protected function onMiniMapChangeHandler(param1:MinimapEvent) : void
        {
            this.setBossIndicatorProgressPosition();
            super.onMiniMapChangeHandler(param1);
        }

        private function onBossProgressIndicatorEnabledHandler(param1:BossIndicatorEvent) : void
        {
            this.setBossIndicatorProgressPosition();
        }
    }
}
