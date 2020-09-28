package net.wg.gui.battle.eventBattle.views
{
    import net.wg.gui.battle.views.BaseBattlePage;
    import net.wg.gui.battle.eventBattle.views.bossWidget.EventBossProgressWidget;
    import net.wg.gui.battle.views.debugPanel.DebugPanel;
    import net.wg.gui.components.battleDamagePanel.BattleDamageLogPanel;
    import net.wg.gui.battle.views.sixthSense.SixthSense;
    import net.wg.gui.battle.views.consumablesPanel.ConsumablesPanel;
    import net.wg.gui.battle.components.StatusNotificationsPanel;
    import net.wg.gui.components.hintPanel.HintPanel;
    import net.wg.gui.battle.views.damageInfoPanel.DamageInfoPanel;
    import net.wg.gui.battle.views.battleMessenger.BattleMessenger;
    import net.wg.gui.battle.interfaces.IFullStats;
    import net.wg.gui.battle.views.radialMenu.RadialMenu;
    import net.wg.gui.battle.eventBattle.views.eventPlayersPanel.EventPlayersPanel;
    import net.wg.gui.battle.eventBattle.views.battleHints.EventBattleHint;
    import net.wg.gui.battle.eventBattle.views.eventPointCounter.EventPointCounter;
    import net.wg.gui.battle.eventBattle.views.eventTimer.EventTimer;
    import net.wg.gui.battle.views.postmortemPanel.PostmortemNotification;
    import net.wg.gui.battle.eventBattle.views.buffsPanel.BuffsPanel;
    import net.wg.gui.battle.eventBattle.views.battleHints.EventObjectives;
    import net.wg.gui.battle.eventBattle.views.ReinforcementPanel.ReinforcementPanel;
    import net.wg.gui.battle.views.consumablesPanel.events.ConsumablesPanelEvent;
    import net.wg.data.constants.generated.DAMAGE_INFO_PANEL_CONSTS;
    import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
    import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
    import flash.events.MouseEvent;
    import net.wg.infrastructure.events.FocusRequestEvent;
    import flash.events.Event;
    import flash.geom.Rectangle;
    import net.wg.gui.battle.views.minimap.constants.MinimapSizeConst;
    import net.wg.gui.components.battleDamagePanel.constants.BattleDamageLogConstants;
    import flash.display.DisplayObject;
    import net.wg.data.constants.generated.ATLAS_CONSTANTS;

    public class EventBattlePage extends BaseBattlePage
    {

        private static const BATTLE_DAMAGE_LOG_X_POSITION:int = 229;

        private static const BATTLE_DAMAGE_LOG_Y_PADDING:int = 3;

        private static const CONSUMABLES_POPUP_OFFSET:int = 60;

        private static const HINT_PANEL_Y_SHIFT_MULTIPLIER:Number = 1.5;

        private static const POINT_COUNTER_HEIGHT:int = 160;

        private static const VEHICLE_MESSAGES_LIST_OFFSET_Y:int = 106;

        private static const BUFF_PANEL_OFFSET_Y:int = 135;

        private static const PANEL_VEHICLES_OFFSET:int = 61;

        protected static const MESSENGER_Y_OFFSET_WITH_REINFORCEMENT:int = 27;

        protected static const MESSENGER_Y_OFFSET_WITHOUT_REINFORCEMENT:int = MESSENGER_Y_OFFSET_WITH_REINFORCEMENT + 38;

        private static const MINIMAP_MARGIN_HEIGHT:int = 6;

        private static const MINIMAP_MARGIN_WIDTH:int = 0;

        public var bossProgressWidget:EventBossProgressWidget = null;

        public var debugPanel:DebugPanel = null;

        public var battleDamageLogPanel:BattleDamageLogPanel = null;

        public var sixthSense:SixthSense = null;

        public var consumablesPanel:ConsumablesPanel = null;

        public var statusNotificationsPanel:StatusNotificationsPanel = null;

        public var hintPanel:HintPanel = null;

        public var damageInfoPanel:DamageInfoPanel = null;

        public var battleMessenger:BattleMessenger = null;

        public var fullStats:IFullStats = null;

        public var radialMenu:RadialMenu = null;

        public var playersPanelEvent:EventPlayersPanel = null;

        public var eventMessage:EventBattleHint = null;

        public var eventPointCounter:EventPointCounter = null;

        public var eventTimer:EventTimer = null;

        public var postmortemNotification:PostmortemNotification = null;

        public var buffsPanel:BuffsPanel = null;

        public var eventObjectives:EventObjectives = null;

        public var eventReinforcementPanel:ReinforcementPanel = null;

        public function EventBattlePage()
        {
            super();
            this.eventTimer.visible = false;
            this.battleDamageLogPanel.init(ATLAS_CONSTANTS.BATTLE_ATLAS);
            this.eventReinforcementPanel.setCompVisible(false);
            this.battleMessenger.setCompVisible(false);
        }

        override public function as_setPostmortemTipsVisible(param1:Boolean) : void
        {
            super.as_setPostmortemTipsVisible(param1);
            if(!param1 && !this.consumablesPanel.hasEventListener(ConsumablesPanelEvent.UPDATE_POSITION))
            {
                this.consumablesPanel.addEventListener(ConsumablesPanelEvent.UPDATE_POSITION,this.onConsumablesPanelUpdatePositionHandler);
            }
        }

        override public function as_showPostmortemNotification() : void
        {
            this.postmortemNotification.fadeIn();
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            var _loc3_:uint = 0;
            super.updateStage(param1,param2);
            this.battleDamageLogPanel.x = BATTLE_DAMAGE_LOG_X_POSITION;
            this.battleDamageLogPanel.y = damagePanel.y + BATTLE_DAMAGE_LOG_Y_PADDING >> 0;
            this.battleDamageLogPanel.updateSize(param1,param2);
            _loc3_ = param1 >> 1;
            this.sixthSense.x = _loc3_;
            this.sixthSense.y = param2 >> 2;
            this.consumablesPanel.updateStage(param1,param2);
            this.damageInfoPanel.y = (param2 >> 1) / scaleY + DAMAGE_INFO_PANEL_CONSTS.HEIGHT * scaleY | 0;
            this.damageInfoPanel.x = param1 - DAMAGE_INFO_PANEL_CONSTS.WIDTH >> 1;
            this.radialMenu.updateStage(param1,param2);
            this.statusNotificationsPanel.updateStage(param1,param2);
            this.eventMessage.updateStage(param1,param2);
            this.fullStats.updateStageSize(param1,param2);
            this.eventTimer.x = _loc3_;
            this.eventObjectives.x = param1 - this.eventObjectives.width >> 0;
            this.buffsPanel.x = _loc3_;
            this.buffsPanel.y = App.appHeight - BUFF_PANEL_OFFSET_Y;
            this.updateBattleMessengerPosition();
            this.eventReinforcementPanel.x = damagePanel.x;
            this.eventReinforcementPanel.y = damagePanel.y;
            this.playersPanelEvent.updateStage(param1,param2);
            this.updateHintPanelPosition();
            this.updateConsumablesPanelPosition();
            this.updateWTProgressPosition();
            this.updatePostmortemNotificationPosition();
        }

        override protected function createStatisticsController() : BattleStatisticDataController
        {
            return new BattleStatisticDataController(this);
        }

        override protected function initializeStatisticsController(param1:BattleStatisticDataController) : void
        {
            param1.registerComponentController(this.fullStats);
            param1.registerComponentController(this.playersPanelEvent);
            super.initializeStatisticsController(param1);
        }

        override protected function onRegisterStatisticController() : void
        {
            registerFlashComponentS(battleStatisticDataController,BATTLE_VIEW_ALIASES.BATTLE_STATISTIC_DATA_CONTROLLER);
        }

        override protected function configUI() : void
        {
            this.battleMessenger.addEventListener(MouseEvent.ROLL_OVER,this.onBattleMessengerRollOverHandler);
            this.battleMessenger.addEventListener(MouseEvent.ROLL_OUT,this.onBattleMessengerRollOutHandler);
            this.consumablesPanel.addEventListener(ConsumablesPanelEvent.SWITCH_POPUP,this.onConsumablesPanelSwitchPopupHandler);
            this.consumablesPanel.addEventListener(ConsumablesPanelEvent.UPDATE_POSITION,this.onConsumablesPanelUpdatePositionHandler);
            this.consumablesPanel.addEventListener(ConsumablesPanelEvent.SWITCH_POPUP,this.onConsumablesPanelSwitchPopupHandler);
            this.battleMessenger.addEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onBattleMessengerRequestFocusHandler);
            this.battleMessenger.addEventListener(BattleMessenger.REMOVE_FOCUS,this.onBattleMessengerRemoveFocusHandler);
            this.hintPanel.addEventListener(Event.RESIZE,this.onHintPanelResizeHandler);
            this.bossProgressWidget.addEventListener(Event.RESIZE,this.updateWTProgressPosition);
            this.updateWTProgressPosition();
            super.configUI();
        }

        override protected function onPopulate() : void
        {
            registerComponent(this.debugPanel,BATTLE_VIEW_ALIASES.DEBUG_PANEL);
            registerComponent(this.battleDamageLogPanel,BATTLE_VIEW_ALIASES.BATTLE_DAMAGE_LOG_PANEL);
            registerComponent(this.sixthSense,BATTLE_VIEW_ALIASES.SIXTH_SENSE);
            registerComponent(this.battleMessenger,BATTLE_VIEW_ALIASES.BATTLE_MESSENGER);
            registerComponent(this.consumablesPanel,BATTLE_VIEW_ALIASES.CONSUMABLES_PANEL);
            registerComponent(this.statusNotificationsPanel,BATTLE_VIEW_ALIASES.STATUS_NOTIFICATIONS_PANEL);
            registerComponent(this.hintPanel,BATTLE_VIEW_ALIASES.HINT_PANEL);
            registerComponent(this.damageInfoPanel,BATTLE_VIEW_ALIASES.DAMAGE_INFO_PANEL);
            registerComponent(this.fullStats,BATTLE_VIEW_ALIASES.FULL_STATS);
            registerComponent(this.playersPanelEvent,BATTLE_VIEW_ALIASES.PLAYERS_PANEL_EVENT);
            registerComponent(this.eventMessage,BATTLE_VIEW_ALIASES.BATTLE_HINT);
            registerComponent(this.buffsPanel,BATTLE_VIEW_ALIASES.EVENT_BUFFS_PANEL);
            registerComponent(this.eventPointCounter,BATTLE_VIEW_ALIASES.EVENT_POINT_COUNTER);
            registerComponent(this.radialMenu,BATTLE_VIEW_ALIASES.RADIAL_MENU);
            registerComponent(this.eventObjectives,BATTLE_VIEW_ALIASES.EVENT_OBJECTIVES);
            registerComponent(this.bossProgressWidget,BATTLE_VIEW_ALIASES.WT_EVENT_BOSS_PROGRESS_WIDGET);
            registerComponent(this.eventReinforcementPanel,BATTLE_VIEW_ALIASES.WT_EVENT_REINFORCEMENT_PANEL);
            super.onPopulate();
            this.postmortemNotification.setCompVisible(false);
            this.updatePostmortemNotificationPosition();
            this.updateWTProgressPosition();
        }

        override protected function onDispose() : void
        {
            this.consumablesPanel.removeEventListener(ConsumablesPanelEvent.UPDATE_POSITION,this.onConsumablesPanelUpdatePositionHandler);
            this.consumablesPanel.removeEventListener(ConsumablesPanelEvent.SWITCH_POPUP,this.onConsumablesPanelSwitchPopupHandler);
            this.consumablesPanel = null;
            this.battleMessenger.removeEventListener(MouseEvent.ROLL_OVER,this.onBattleMessengerRollOverHandler);
            this.battleMessenger.removeEventListener(MouseEvent.ROLL_OUT,this.onBattleMessengerRollOutHandler);
            this.battleMessenger.removeEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onBattleMessengerRequestFocusHandler);
            this.battleMessenger.removeEventListener(BattleMessenger.REMOVE_FOCUS,this.onBattleMessengerRemoveFocusHandler);
            this.battleMessenger = null;
            this.hintPanel.removeEventListener(Event.RESIZE,this.onHintPanelResizeHandler);
            this.hintPanel = null;
            this.bossProgressWidget.removeEventListener(Event.RESIZE,this.updateWTProgressPosition);
            this.bossProgressWidget = null;
            this.debugPanel = null;
            this.battleDamageLogPanel = null;
            this.sixthSense = null;
            this.statusNotificationsPanel = null;
            this.damageInfoPanel = null;
            this.fullStats = null;
            this.radialMenu = null;
            this.playersPanelEvent = null;
            this.eventMessage = null;
            this.eventObjectives = null;
            this.eventPointCounter = null;
            this.buffsPanel = null;
            this.eventTimer = null;
            this.postmortemNotification = null;
            this.eventReinforcementPanel = null;
            super.onDispose();
        }

        override protected function getAllowedMinimapSizeIndex(param1:Number) : Number
        {
            var _loc2_:Number = App.appHeight - this.playersPanelEvent.y - this.playersPanelEvent.panelHeight - MINIMAP_MARGIN_HEIGHT;
            var _loc3_:Number = App.appWidth - this.consumablesPanel.panelWidth - MINIMAP_MARGIN_WIDTH;
            var _loc4_:Rectangle = null;
            while(param1 > MinimapSizeConst.MIN_SIZE_INDEX)
            {
                _loc4_ = minimap.getMinimapRectBySizeIndex(param1);
                if(_loc2_ - _loc4_.height >= 0 && _loc3_ - _loc4_.width >= 0)
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

        override protected function onComponentVisibilityChanged(param1:String, param2:Boolean) : void
        {
            super.onComponentVisibilityChanged(param1,param2);
            if(param1 == BATTLE_VIEW_ALIASES.WT_EVENT_REINFORCEMENT_PANEL)
            {
                this.updateBattleMessengerPosition();
            }
        }

        private function updateBattleMessengerPosition() : void
        {
            var _loc1_:Number = this.eventReinforcementPanel.visible?MESSENGER_Y_OFFSET_WITH_REINFORCEMENT:MESSENGER_Y_OFFSET_WITHOUT_REINFORCEMENT;
            this.battleMessenger.x = damagePanel.x;
            this.battleMessenger.y = damagePanel.y - this.battleMessenger.height + _loc1_ - PANEL_VEHICLES_OFFSET >> 0;
        }

        private function updatePostmortemNotificationPosition() : void
        {
            this.postmortemNotification.x = width >> 1;
            this.postmortemNotification.y = height;
        }

        private function updateBattleDamageLogPanelPosition() : void
        {
            var _loc1_:int = BattleDamageLogConstants.MAX_VIEW_RENDER_COUNT;
            if(this.battleDamageLogPanel.x + BattleDamageLogConstants.MAX_DAMAGE_LOG_VIEW_WIDTH >= this.consumablesPanel.x)
            {
                _loc1_ = BattleDamageLogConstants.MIN_VIEW_RENDER_COUNT;
            }
            this.battleDamageLogPanel.setDetailActionCount(_loc1_);
        }

        private function updateHintPanelPosition() : void
        {
            this.hintPanel.x = _originalWidth - this.hintPanel.width >> 1;
            this.hintPanel.y = HINT_PANEL_Y_SHIFT_MULTIPLIER * (_originalHeight - this.hintPanel.height >> 1) ^ 0;
        }

        private function updateConsumablesPanelPosition() : void
        {
            this.eventPointCounter.x = App.appWidth >> 1;
            this.eventPointCounter.y = App.appHeight - POINT_COUNTER_HEIGHT;
        }

        private function swapElementsByMouseInteraction(param1:DisplayObject, param2:DisplayObject) : void
        {
            if(!App.contextMenuMgr.isShown() && this.checkZIndexes(param1,param2))
            {
                this.swapChildren(param1,param2);
            }
        }

        private function checkZIndexes(param1:DisplayObject, param2:DisplayObject) : Boolean
        {
            return this.getChildIndex(param1) > this.getChildIndex(param2);
        }

        private function onBattleMessengerRequestFocusHandler(param1:FocusRequestEvent) : void
        {
            setFocus(param1.focusContainer.getComponentForFocus());
            if(this.battleMessenger.isEnterButtonPressed)
            {
                this.swapElementsByMouseInteraction(this.playersPanelEvent,this.battleMessenger);
            }
            else
            {
                this.swapElementsByMouseInteraction(this.battleMessenger,this.playersPanelEvent);
            }
        }

        override protected function get prebattleTimerAlias() : String
        {
            return BATTLE_VIEW_ALIASES.EVENT_PREBATTLE_TIMER;
        }

        private function onBattleMessengerRollOutHandler(param1:MouseEvent) : void
        {
            if(!this.battleMessenger.isEnterButtonPressed)
            {
                this.swapElementsByMouseInteraction(this.battleMessenger,this.playersPanelEvent);
            }
        }

        private function onBattleMessengerRollOverHandler(param1:MouseEvent) : void
        {
            this.swapElementsByMouseInteraction(this.playersPanelEvent,this.battleMessenger);
        }

        private function onBattleMessengerRemoveFocusHandler(param1:Event) : void
        {
            setFocus(this);
            this.swapElementsByMouseInteraction(this.playersPanelEvent,this.battleMessenger);
        }

        private function onConsumablesPanelUpdatePositionHandler(param1:ConsumablesPanelEvent) : void
        {
            if(isPostMortem)
            {
                this.consumablesPanel.removeEventListener(ConsumablesPanelEvent.UPDATE_POSITION,this.onConsumablesPanelUpdatePositionHandler);
                updateBattleDamageLogPosInPostmortem();
            }
            else
            {
                this.updateBattleDamageLogPanelPosition();
            }
            minimap.updateSizeIndex(false);
        }

        private function onConsumablesPanelSwitchPopupHandler(param1:ConsumablesPanelEvent) : void
        {
            var _loc2_:* = 0;
            if(!postmortemTips || !postmortemTips.visible)
            {
                _loc2_ = this.consumablesPanel.isExpand?CONSUMABLES_POPUP_OFFSET:0;
                vehicleMessageList.setLocation(_originalWidth - VEHICLE_MESSAGES_LIST_OFFSET.x >> 1,_originalHeight - VEHICLE_MESSAGES_LIST_OFFSET.y - _loc2_ | 0);
            }
        }

        private function onHintPanelResizeHandler(param1:Event) : void
        {
            this.updateHintPanelPosition();
        }

        private function updateWTProgressPosition(param1:Event = null) : void
        {
            this.bossProgressWidget.x = _width - this.bossProgressWidget.width >> 1;
        }
    }
}
